# Yolov5 物体识别例程

## 文件结构

```bash
luckfox_yolov5
├── cpp --------------------------------------例程源码
├── demo -------------------------------------编译生成后的文件
└── model ------------------------------------例程使用的模型源码
```

## 编译

+ 设置环境变量

```bash
export LUCKFOX_SDK_PATH=< luckfox-pico Sdk 地址>
```

**注意**：使用绝对地址。

+ 执行

```bash
cd cpp/build
cmake ..
make -j
make install
```

        编译完成后在 `cpp` 文件夹下会生成 `luckfox_yolov5_demo` 文件夹，移动至 luckfox-pico运行。

## 运行

+ luckfox-pico 进入工程文件，配置执行权限

```bash
cd luckfox_yolov5_demo
chmod a+x ./luckfox_yolov5_demo_test
```

+ 执行

```bash
./rknn_yolov5_demo_test <yolov5模型> 
```

+ 示例

```bash
./lrknn_yolov5_demo_test ./model/yolov5.rknn
```

## 效果

摄像头获取图像，经过模型推理和 opencv-mobile 图像处理后在 Pico-LCD-1.3 上显示，会框住摄像头捕获到的物体并标注识别种类和置信度。

## 注意
在运行demo前请执行killall rkipc关闭luckofox-pico开机默认开启的后台程序rkicp ,解除对摄像头的占用。

## NOTE
Before demo, run killall rkipc to disable rkicp app.