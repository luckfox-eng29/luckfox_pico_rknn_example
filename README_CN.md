
**其他语言版本: [English](README.md), [中文](README_CN.md).**
# Luckfox_Pico_rknn_example
## 文件结构

```bash
luckfox_rknn
├── doc ----------------------------------------------------文档
├── package ------------------------------------------------相关安装包
├── example ------------------------------------------------例程
│       ├── luckfox_retinaface_facenet ---------------------人脸识别例程
│       └── luckfox_yolov5 ---------------------------------物体识别例程
├── scripts ------------------------------------------------文档
│       └── luckfox_onnx_to_rknn ---------------------------模型装换脚本
├── dts ----------------------------------------------------framebuffer 设备树文件
└── Readme.md-----------------------------------------------说明
```

## 实验平台

### 硬件

- luckfox-pico plus

- sc3336 摄像头

- Pico-LCD-1.3

### 软件

+ ubuntu22.04（WSL）
- buildroot（基于配置文件 BoardConfig-EMMC-Ubuntu-RV1103_Luckfox_Pico_Plus-IPC.mk修改 ）
- opencv-mobile


### 注意
运行demo前请使用 `RkLunch-stop.sh` 关闭板端开机的后台程序 rkipc 解除对摄像头的占用。

## 相关教程
[RKNN实例使用指南](https://wiki.luckfox.com/zh/Luckfox-Pico/RKNN-example)