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

#include "yolov5.h"
#include "image_utils.h"
#include "file_utils.h"
#include "image_drawing.h"

#include <unistd.h>   
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/ioctl.h>
#include <sys/mman.h>
#include <linux/fb.h>
#include <time.h>

//opencv
#include <opencv2/core/core.hpp>
#include <opencv2/highgui/highgui.hpp>
#include <opencv2/imgproc/imgproc.hpp>

#include "dma_alloc.cpp"

#define FB_WIDTH   240
#define FB_HEIGHT  240

#define USE_DMA 1

/*-------------------------------------------
                  Main Function
-------------------------------------------*/
int main(int argc, char **argv)
{
    if (argc != 2)
    {
        printf("%s <yolov5 model_path>\n", argv[0]);
        return -1;
    }
    const char *model_path = argv[1];

    clock_t start_time;
    clock_t end_time;
    char text[8];
    float fps = 0;

    //Model Input 
    int model_width    = 640;
    int model_height   = 640;
    int channels = 3;

    //display
    int disp_width = FB_WIDTH;
    int disp_height = FB_HEIGHT;


    int ret;
    rknn_app_context_t rknn_app_ctx;
    object_detect_result_list od_results;
    memset(&rknn_app_ctx, 0, sizeof(rknn_app_context_t));
    
    init_yolov5_model(model_path, &rknn_app_ctx);
    init_post_process();
    
    //Init fb
    int fb = open("/dev/fb0", O_RDWR);
    if(fb == -1)
    {
        close(fb);
        return -1;
    }
    size_t    screensize = FB_WIDTH * FB_HEIGHT * 2;
    uint16_t* framebuffer = (uint16_t*)mmap(NULL, screensize, PROT_READ | PROT_WRITE, MAP_SHARED, fb, 0);

    //Init Opencv-mobile 
    cv::VideoCapture cap;
    cv::Mat bgr(disp_height, disp_width, CV_8UC3);
    cv::Mat bgr565(disp_height, disp_width, CV_16UC1);
    cv::Mat bgr640(model_height, model_width, CV_8UC3, rknn_app_ctx.input_mems[0]->virt_addr);
    cap.set(cv::CAP_PROP_FRAME_WIDTH,  disp_width);
    cap.set(cv::CAP_PROP_FRAME_HEIGHT, disp_height);
    cap.open(0); 
#if USE_DMA
    int framebuffer_fd = 0;
    dma_buf_alloc(RV1106_CMA_HEAP_PATH,
                  disp_width * disp_height * 2, //RGB565 
                  &framebuffer_fd, 
                  (void **) & (bgr565.data)); 
#endif

    while(1)
    {

        start_time = clock();
        cap >> bgr;
        //bgr = cv::imread("./bus.jpg");
        cv::resize(bgr, bgr640, cv::Size(model_width, model_height), 0, 0, cv::INTER_LINEAR);

        inference_yolov5_model(&rknn_app_ctx, &od_results);

        // Add rectangle and probability

        for (int i = 0; i < od_results.count; i++)
        {
            object_detect_result *det_result = &(od_results.results[i]);
            det_remap(det_result); 
            //  printf("%s @ (%d %d %d %d) %.3f\n", coco_cls_to_name(det_result->cls_id),
            //         det_result->box.left, det_result->box.top,
            //         det_result->box.right, det_result->box.bottom,
            //         det_result->prop);

            cv::rectangle(bgr,cv::Point(det_result->box.left ,det_result->box.top),
                              cv::Point(det_result->box.right,det_result->box.bottom),cv::Scalar(0,255,0),3);

            sprintf(text, "%s %.1f%%", coco_cls_to_name(det_result->cls_id), det_result->prop * 100);
            cv::putText(bgr,text,cv::Point(det_result->box.left, det_result->box.top - 8),
                                         cv::FONT_HERSHEY_SIMPLEX,0.5,
                                         cv::Scalar(0,255,0),2); 
        }
        //Fps Show
        sprintf(text,"fps=%.1f",fps); 
        cv::putText(bgr,text,cv::Point(0, 20),
                    cv::FONT_HERSHEY_SIMPLEX,0.5,
                    cv::Scalar(0,255,0),1);

        //LCD Show 
        cv::cvtColor(bgr, bgr565, cv::COLOR_BGR2BGR565);
        memcpy(framebuffer, bgr565.data, disp_width * disp_height * 2);
#if USE_DMA
        dma_sync_cpu_to_device(framebuffer_fd);
#endif   
        //Update Fps
        end_time = clock();
        fps= (float) (CLOCKS_PER_SEC / (end_time - start_time)) ;
        memset(text,0,8); 
    }


    deinit_post_process();

#if USE_DMA
    dma_buf_free(disp_width*disp_height*2,
                 &framebuffer_fd, 
                 bgr.data);
#endif

    ret = release_yolov5_model(&rknn_app_ctx);
    if (ret != 0)
    {
        printf("release_yolov5_model fail! ret=%d\n", ret);
    }

    return 0;
}
