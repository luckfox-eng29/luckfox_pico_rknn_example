
**其他语言版本: [English](README.md), [中文](README_CN.md).**

# Retinaface_Facenet 人脸识别例程

## 文件结构

```bash
luckfox_retinaface_facenet
├── cpp --------------------------------------framebuffer例程源码
├── cpp_spi ----------------------------------spi例程源码
├── demo -------------------------------------编译生成后的文件
└── model ------------------------------------例程使用的模型源码
```

## 编译
以 cpp 为例：
+ 设置环境变量

    ```bash
    export LUCKFOX_SDK_PATH=< luckfox-pico Sdk 地址>
    ```

**注意**：使用绝对地址

+ 执行

    ```bash
    cd cpp/build
    cmake ..
    make -j
    make install
    ```

编译完成后在 `cpp` 文件夹下会生成 `luckfox_retinaface_facenet_demo` 文件夹，移动至 luckfox-pico 运行。

cpp_spi:
由于 luckfox-pico plus 和 luckfox-pico pro/max 引出引脚不同，根据不同的版型需要修改相应的引脚配置，在 `cpp_spi/CMakeLists.txt` 中进行配置即可。
+ luckfox-pico plus

    添加
    ```
    add_definitions(-DLUCKFOX_PICO_PLUS)
    ```
+ luckfox-pico pro/max

    注释
    ```
    #add_definitions(-DLUCKFOX_PICO_PLUS)
    ```
**注意**：cpp 中使用的是 framebuffer 方案，引脚在设备树中设置。
## 运行
以 cpp 为例
+ 进入工程文件，配置执行权限

    ```bash
    cd luckfox_retinaface_facenet_demo
    chmod a+x ./luckfox_retinaface_facenet_demo_test
    ```

+ 执行

    ```bash
    ./luckfox_retinaface_facenet_demo_test <retinaface模型> <facenet模型> <参考图像>
    ```

+ 示例

    ```bash
    ./luckfox_retinaface_facenet_demo_test ./model/RetinaFace.rknn ./model/mobilefacenet.rknn ./test.jpg
    ```

`test.jpg` 文件替换为选用的参考图片。

## 运行效果
+ cpp

    摄像头获取图像，经过模型推理和 opencv-mobile 图像处理后在 Pico-LCD-1.3 上通过读写framebuffer控制屏幕显示，会框住摄像头中出现的人脸并标注其与参考人脸图像的欧式距离。
+ cpp_spi

    摄像头获取图像，经过模型推理和 opencv-mobile 图像处理后在 Pico-ResTouch-LCD-2.8/Pico-ResTouch-LCD-3.5 上通过spi通信控制屏幕显示，会框住摄像头中出现的人脸并标注其与参考人脸图像的欧式距离。
**注意：** 使用 cpp_spi 例程时，不能使用运行在 SD 卡的系统，连接屏幕时会占用 SD 卡的对应引脚，请参考 [luckfox-pico wiki](https://wiki.luckfox.com/Luckfox-Pico/Luckfox-Pico-ResTouch-LCD/) 进行配置。


## 注意
在运行 demo 前请执行 `killall rkipc` 关闭 luckofox-pico 开机默认开启的后台程序 rkicp ，解除对摄像头的占用。

## NOTE
Before demo, run `killall rkipc` to disable rkicp app.

