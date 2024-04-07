
**Read this in other languages: [English](README.md), [中文](README_CN.md).**
# Luckfox_Pico_rknn_example

## File Structure
```bash
luckfox_rknn
├── doc ----------------------------------------------------Documentation
├── package -----------------------------------------------Related installation packages
├── example ------------------------------------------------Examples
│       ├── luckfox_retinaface_facenet ---------------------Face recognition example
│       └── luckfox_yolov5 ---------------------------------Object detection example
├── scripts ------------------------------------------------Scripts
│       └── luckfox_onnx_to_rknn ---------------------------Model conversion script
├── dts ----------------------------------------------------Device tree files for framebuffer
└── Readme.md----------------------------------------------Instructions
```

## Experimental Platform

### Hardware

- Luckfox-pico plus
- SC3336 camera
- Pico-LCD-1.3

### Software

+ Ubuntu 22.04 (WSL)
- Buildroot (based on configuration file BoardConfig-EMMC-Ubuntu-RV1103_Luckfox_Pico_Plus-IPC.mk modifications)
- OpenCV-Mobile

### Note
Before running the demo, please use `killall rkipc` to close the background program `rkipc` running on the board at startup to release the camera.

## Related Tutorials
[RKNN Instance Usage Guide](https://wiki.luckfox.com/zh/Luckfox-Pico/RKNN-example)

