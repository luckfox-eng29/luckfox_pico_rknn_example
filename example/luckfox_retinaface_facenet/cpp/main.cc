// Copyright (c) 2023 by Rockchip Electronics Co., Ltd. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

/*-------------------------------------------
                Includes
-------------------------------------------*/
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>



// #if defined(RV1106_1103) 
//     #include "dma_alloc.cpp"
// #endif


#include <unistd.h>   // sleep()
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/ioctl.h>
#include <sys/mman.h>
#include <linux/fb.h>

#include "retinaface_facenet.h"
#include <time.h>
#include <sys/time.h>


#define FB_HIGHT   240
#define FB_WEIGHT  240


/*-------------------------------------------
                  Main Function
-------------------------------------------*/
int main(int argc, char **argv)
{
    if (argc != 4)
    {
        printf("%s <model_path> \n", argv[0]);
        return -1;
    }

    const char *model_path  = argv[1];
    const char *model_path2 = argv[2];
    const char *image_path  = argv[3]; //参考图片

    clock_t start_time;
    clock_t end_time;

    struct timeval start;
    struct timeval end;


    int width    = 640;
    int height   = 640;
    int channels = 3;

    int ret;
    rknn_app_context_t app_retinaface_ctx;
    rknn_app_context_t app_facenet_ctx; 
    object_detect_result_list od_results;
    unsigned char *src_image = (unsigned char *)malloc(sizeof(unsigned char)*640*640*3);
    memset(&app_retinaface_ctx, 0, sizeof(rknn_app_context_t));
    memset(&app_facenet_ctx, 0, sizeof(rknn_app_context_t));

    init_retinaface_facenet_model(model_path, model_path2, &app_retinaface_ctx, &app_facenet_ctx);
 
    //dma_buf_alloc(RV1106_CMA_HEAP_PATH, 640*640*3, &rknn_app_ctx.img_dma_buf.dma_buf_fd, 
    //                            (void **) & (rknn_app_ctx.img_dma_buf.dma_buf_virt_addr));
    
    //Init fb
    int fb = open("/dev/fb0", O_RDWR);
    if(fb == -1)
    {
        close(fb);
        return -1;
    }
    size_t    screensize = FB_HIGHT * FB_WEIGHT * 2;
    uint16_t* framebuffer = (uint16_t*)mmap(NULL, screensize, PROT_READ | PROT_WRITE, MAP_SHARED, fb, 0);
    cv::Mat   rgb565Image(240, 240, CV_16UC1);

    //Init Opencv
    cv::VideoCapture cap;
    cv::Mat bgr;
    cv::Mat bgr640;
    cap.set(cv::CAP_PROP_FRAME_WIDTH,  240);
    cap.set(cv::CAP_PROP_FRAME_HEIGHT, 240);
    cap.open(0); 
    
    
    //获取参考图片的特征值
    cv::Mat image = cv::imread(image_path);
    unsigned char * input_data = (unsigned char *)malloc(sizeof(unsigned char) * 160*160*3); 
    letterbox(image,input_data); 
    memcpy(app_facenet_ctx.input_mems[0]->virt_addr, input_data, 160*160*3); 
    ret = rknn_run(app_facenet_ctx.rknn_ctx, nullptr);
    if (ret < 0) {
        printf("rknn_run fail! ret=%d\n", ret);
        return -1;
    }
    uint8_t  *output = (uint8_t *)(app_facenet_ctx.output_mems[0]->virt_addr);

    float* reference_out_fp32 = (float*)malloc(sizeof(float) * 128); 
    output_normalization(&app_facenet_ctx,output,reference_out_fp32);

    memset(input_data,0,160*160*3);
    //获取facenet输出数据
    float* out_fp32 = (float*)malloc(sizeof(float) * 128); 
    char show_text[12]; 
    char fps_text[32]; 
    printf("Loop\n");

    while(1)
    {
        start_time = clock();
        //opencv get photo
        cap >> bgr;
        cv::resize(bgr, bgr, cv::Size(640,640), 0, 0, cv::INTER_LINEAR);
        for (int y = 0; y < height; ++y) {
          for (int x = 0; x < width; ++x) {
              cv::Vec3b pixel = bgr.at<cv::Vec3b>(y, x);
              src_image[(y * width + x) * channels + 0] = pixel[2]; // Red
              src_image[(y * width + x) * channels + 1] = pixel[1]; // Green
              src_image[(y * width + x) * channels + 2] = pixel[0]; // Blue
            }
        }
        
        //DMA
        //memcpy(rknn_app_ctx.img_dma_buf.dma_buf_virt_addr, src_image, 640*640*3); 
        //dma_sync_cpu_to_device(rknn_app_ctx.img_dma_buf.dma_buf_fd);    
        //src_image.virt_addr = (unsigned char *)rknn_app_ctx.img_dma_buf.dma_buf_virt_addr;
       

        memcpy(app_retinaface_ctx.input_mems[0]->virt_addr, src_image,640*640*3);
        
        ret = inference_retinaface_model(&app_retinaface_ctx, &od_results);
        if (ret != 0)
        {
            printf("init_retinaface_model fail! ret=%d\n", ret);
            return -1;
        }

        
        for (int i = 0; i < od_results.count; i++)
        {

            //获取框的四个坐标 
            object_detect_result *det_result = &(od_results.results[i]);
            //printf("%d %d %d %d\n",det_result->box.left ,det_result->box.top,det_result->box.right,det_result->box.bottom);      
            cv::rectangle(bgr,cv::Point(det_result->box.left ,det_result->box.top),
                          cv::Point(det_result->box.right,det_result->box.bottom),cv::Scalar(0,255,0),3);
            
            //截取人脸
             cv::Rect roi(det_result->box.left,det_result->box.top, 
                         (det_result->box.right - det_result->box.left),
                         (det_result->box.bottom - det_result->box.top));
             cv::Mat face_img = bgr(roi);

            //获取五点关键点
            // for(int j = 0; j < 5;j ++)
            // {
            //     //printf("point_x = %d point_y = %d\n",det_result->point[j].x,
            //     //                                     det_result->point[j].y);
            //     cv::circle(bgr,cv::Point(det_result->point[j].x,det_result->point[j].y),10,cv::Scalar(0,255,0),3);
            // }
            
            letterbox(face_img,input_data); 
            
            memcpy(app_facenet_ctx.input_mems[0]->virt_addr, input_data, 160*160*3);



            ret = rknn_run(app_facenet_ctx.rknn_ctx, nullptr);
            if (ret < 0) {
                printf("rknn_run fail! ret=%d\n", ret);
                return -1;
            }
            output = (uint8_t *)(app_facenet_ctx.output_mems[0]->virt_addr);

            output_normalization(&app_facenet_ctx,output, out_fp32);

            float norm = get_duclidean_distance(reference_out_fp32,out_fp32); 
            
            sprintf(show_text,"norm=%f",norm);
            cv::putText(bgr, show_text, cv::Point(det_result->box.left, det_result->box.top - 8),
                                         cv::FONT_HERSHEY_SIMPLEX,1,
                                         cv::Scalar(0,255,0),2);


        }
        
        end_time = clock();
        float fps = ((float)CLOCKS_PER_SEC / (end_time - start_time)) ;
        sprintf(fps_text,"fps = %.1f",fps); 
        cv::putText(bgr,fps_text,cv::Point(0, 40),
                    cv::FONT_HERSHEY_SIMPLEX,1,
                    cv::Scalar(0,255,0),1);
        //fb 显示
        //printf("show rectangle\n");
        cv::resize(bgr, bgr, cv::Size(240,240), 0, 0, cv::INTER_LINEAR);
        for (int i = 0; i < bgr.rows; ++i) {
            for (int j = 0; j < bgr.cols; ++j) {
                uint16_t b = (bgr.at<cv::Vec3b>(i, j)[0] >> 3);
                uint16_t g = (bgr.at<cv::Vec3b>(i, j)[1] >> 2) << 5;
                uint16_t r = (bgr.at<cv::Vec3b>(i, j)[2] >> 3) << 11;

                rgb565Image.at<uint16_t>(i, j) = r | g | b;
                framebuffer[i * FB_HIGHT + j] = rgb565Image.at<uint16_t>(i, j);
            }
        }

    } 

    //dma_buf_free(rknn_app_ctx.img_dma_buf.size, &rknn_app_ctx.img_dma_buf.dma_buf_fd, 
    //             rknn_app_ctx.img_dma_buf.dma_buf_virt_addr);

    free(src_image);
    free(input_data);
    free(reference_out_fp32);
    free(out_fp32);

    release_facenet_model(&app_facenet_ctx);
    release_retinaface_model(&app_retinaface_ctx);

    return 0;
}
