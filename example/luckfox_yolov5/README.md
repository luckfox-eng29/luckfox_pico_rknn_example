
**Read this in other languages: [English](README.md), [中文](README_CN.md).**
# YOLOv5 Object Detection Demo

## File Structure

```bash
luckfox_yolov5
├── cpp --------------------------------------Source code for the demo
├── demo -------------------------------------Compiled executable files
└── model ------------------------------------Source code for the models used in the demo
```

## Compilation

+ Set up environment variables

```bash
export LUCKFOX_SDK_PATH=<luckfox-pico SDK path>
```

**Note**: Use absolute path.

+ Execute

```bash
cd cpp/build
cmake ..
make -j
make install
```

After compilation, a folder named `luckfox_yolov5_demo` will be generated in the `cpp` directory. Move it to luckfox-pico for execution.

## Execution

+ Navigate to the project folder on luckfox-pico and set execution permissions

```bash
cd luckfox_yolov5_demo
chmod a+x ./luckfox_yolov5_demo_test
```

+ Execute

```bash
./luckfox_yolov5_demo_test <yolov5 model> 
```

+ Example

```bash
./luckfox_yolov5_demo_test ./model/yolov5.rknn
```

## Result

Capture images from the camera, process them through model inference and OpenCV-mobile image processing, and display them on the Pico-LCD-1.3. Detected objects in the camera feed will be framed, and their class and confidence will be labeled.

## Note
Before running the demo, execute `killall rkipc` to disable the default background app `rkicp` running on luckfox-pico, which occupies the camera.