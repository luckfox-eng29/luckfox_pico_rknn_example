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

#include <unistd.h>   // sleep()
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/ioctl.h>

#include "retinaface_facenet.h"
#include <time.h>
#include <sys/time.h>

#include "DEV_Config.h"
#include "LCD_Driver.h"
#include "GUI_Paint.h"


extern UWORD *BlackImage;

/*-------------------------------------------
                  Main Function
-------------------------------------------*/

int main(int argc, char **argv)
{
    if (argc != 4)
    {
        printf("%s <retinaface model_path> <facenet model_path> <reference pic_path>\n", argv[0]);
        return -1;
    }

    const char *model_path  = argv[1];
    const char *model_path2 = argv[2];
    const char *image_path  = argv[3]; 

    clock_t start_time;
    clock_t end_time;

    struct timeval start;
    struct timeval end;

    //Model Input
    int retina_width    = 640;
    int retina_height   = 640;
    int facenet_width   = 160;
    int facenet_height  = 160;
    int channels = 3;

    //Display
    int disp_width;
    int disp_height;

    int ret;
    rknn_app_context_t app_retinaface_ctx;
    rknn_app_context_t app_facenet_ctx; 
    object_detect_result_list od_results;
    
    memset(&app_retinaface_ctx, 0, sizeof(rknn_app_context_t));
    memset(&app_facenet_ctx, 0, sizeof(rknn_app_context_t));

    //Get Dev ID
    FILE *fp = fopen("/proc/device-tree/model","r");
    char model[32];
    
    fgets(model,32,fp);
    if (model[strlen(model) - 1] == '\n')
    model[strlen(model) - 1] = '\0';
    fclose(fp);
    
#ifdef LUCKFOX_PICO_PLUS
    const char *target_model = "Luckfox Pico Plus";
    if (strcmp(model, target_model) == 0) {
        printf("The device model is Luckfox Pico Plus.\n");
    } else {
        printf("The device model is not Luckfox Pico Plus.\n");
        return -1;
    }
#else
    const char *target_model = "Luckfox Pico Max";
    if (strcmp(model, target_model) == 0) {
        printf("The device model is Luckfox Pico Pro/Max.\n");
    } else {
        printf("The device model is not Luckfox Pico Pro/Max.\n");
        return -1;
    }
#endif

    //Init GPIO
    if(DEV_ModuleInit() != 0){
        DEV_ModuleExit();
        exit(0);
    }

    uint8_t	lcd_id = LCD_Read_Id();
    printf("lcd_id = %x\n",lcd_id);
    lcd_id = LCD_3_5;
    if(LCD_2_8 == lcd_id){
        printf("Use LCD_2_8\n"); 
        disp_width  = LCD_2_8_WIDTH;
        disp_height = LCD_2_8_HEIGHT;
    }
    else if (LCD_3_5 == lcd_id)
    {
        printf("Use LCD_3_5\n");
        // In order to display the same as 2.8 lcd
        disp_width  = LCD_3_5_HEIGHT;
        disp_height = LCD_3_5_WIDTH;
    }
    else
    {
        printf("Use screens that are not currently supported\n"); 
        return -1;
    }

    //Init Model
    init_retinaface_facenet_model(model_path, model_path2, &app_retinaface_ctx, &app_facenet_ctx);

    //Init LCD    
    LCD_SCAN_DIR lcd_scan_dir = SCAN_DIR_DFT;
    LCD_Init(lcd_scan_dir,800);
    Paint_CreatImage();
    Paint_Clear(WHITE);
#ifdef LUCKFOX_PICO_PLUS
        DEV_HARDWARE_SPI_setSpeed(30*1000*1000);
#else
        DEV_HARDWARE_SPI_setSpeed(20*1000*1000);
#endif
    LCD_BL_1;
    LCD_Display(BlackImage);


    //Init Opencv
    cv::VideoCapture cap;
    cv::Mat bgr(disp_height, disp_width, CV_8UC3);
    cv::Mat bgr640(retina_height, retina_width, CV_8UC3,app_retinaface_ctx.input_mems[0]->virt_addr);
    cap.set(cv::CAP_PROP_FRAME_WIDTH,  disp_width);
    cap.set(cv::CAP_PROP_FRAME_HEIGHT, disp_height);
    cap.open(0);  
    
    //Get reference img feature
    cv::Mat image = cv::imread(image_path);
    unsigned char * input_data = (unsigned char *)app_facenet_ctx.input_mems[0]->virt_addr; 
    letterbox(image,input_data); 
    ret = rknn_run(app_facenet_ctx.rknn_ctx, nullptr);
    if (ret < 0) {
        printf("rknn_run fail! ret=%d\n", ret);
        return -1;
    }
    uint8_t *output = (uint8_t *)(app_facenet_ctx.output_mems[0]->virt_addr);
    float* reference_out_fp32 = (float*)malloc(sizeof(float) * 128); 
    output_normalization(&app_facenet_ctx,output,reference_out_fp32);
    memset(input_data,0,facenet_width * facenet_height * channels); 

    float* out_fp32 = (float*)malloc(sizeof(float) * 128); 
    char show_text[12]; 
    char fps_text[32];
    float fps = 0; 
    printf("Loop\n");

    while(1)
    {
        start_time = clock();
        //opencv get photo
        cap >> bgr;
        cv::resize(bgr, bgr640, cv::Size(retina_width,retina_height), 0, 0, cv::INTER_LINEAR);

        ret = inference_retinaface_model(&app_retinaface_ctx, &od_results);
        if (ret != 0)
        {
            printf("init_retinaface_model fail! ret=%d\n", ret);
            return -1;
        }
  
        for (int i = 0; i < od_results.count; i++)
        {
            //Get det 
            object_detect_result *det_result = &(od_results.results[i]); 
            det_remap(det_result,lcd_id);

            printf("%d %d %d %d\n",det_result->box.left ,det_result->box.top,det_result->box.right,det_result->box.bottom);      
            cv::rectangle(bgr,cv::Point(det_result->box.left ,det_result->box.top),
                          cv::Point(det_result->box.right,det_result->box.bottom),
                          cv::Scalar(0,255,0),
                          1);
        
            //Face capture
            cv::Rect roi(det_result->box.left,   det_result->box.top, 
                         (det_result->box.right - det_result->box.left),
                         (det_result->box.bottom - det_result->box.top));
            cv::Mat face_img = bgr(roi);
            //Get five key points
            // for(int j = 0; j < 5;j ++)
            // {
            //     //printf("point_x = %d point_y = %d\n",det_result->point[j].x,
            //     //                                     det_result->point[j].y);
            //     cv::circle(bgr,cv::Point(det_result->point[j].x,det_result->point[j].y),10,cv::Scalar(0,255,0),3);
            // }
            
            letterbox(face_img,input_data); 
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
                                        cv::FONT_HERSHEY_SIMPLEX,0.5,
                                        cv::Scalar(0,255,0), //GREEN
                                        1);
            printf("the norm is %f",norm);
        }
        //Fps Show 
        sprintf(fps_text,"fps = %.1f",fps); 
        cv::putText(bgr,fps_text,cv::Point(0,20),
                    cv::FONT_HERSHEY_SIMPLEX,0.5,
                    cv::Scalar(0,255,0),1);
        //LCD Show
        cv::cvtColor(bgr, bgr, cv::COLOR_BGR2BGR565);

        Paint_DrawImage((unsigned char *)bgr.data, 0, 0, disp_width, disp_height); 
        LCD_Display(BlackImage);

        //Get Fps
        end_time = clock();
        fps = ((float)CLOCKS_PER_SEC / (end_time - start_time)) ;
    } 
	DEV_ModuleExit();
    free(input_data);
    free(reference_out_fp32);
    free(out_fp32);

    release_facenet_model(&app_facenet_ctx);
    release_retinaface_model(&app_retinaface_ctx);
    return 0;
}
