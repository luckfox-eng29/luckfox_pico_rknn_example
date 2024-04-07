
**Read this in other languages: [English](README.md), [中文](README_CN.md).**
# Retinaface_Facenet Face Recognition Demo

## File Structure

```bash
luckfox_retinaface_facenet
├── cpp --------------------------------------Source code for framebuffer demo
├── cpp_spi ----------------------------------Source code for spi demo
├── demo -------------------------------------Compiled executable files
└── model ------------------------------------Source code for models used in the demo
```

## Compilation
Take `cpp` as an example:
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

After compilation, a folder named `luckfox_retinaface_facenet_demo` will be generated in the `cpp` directory. Move it to luckfox-pico for execution.

For `cpp_spi`, due to differences in pinouts between luckfox-pico plus and luckfox-pico pro/max, corresponding pin configurations need to be modified according to the board type. This can be done in `cpp_spi/CMakeLists.txt`.
+ For luckfox-pico plus

    Add
    ```
    add_definitions(-DLUCKFOX_PICO_PLUS)
    ```
+ For luckfox-pico pro/max

    Comment out
    ```
    #add_definitions(-DLUCKFOX_PICO_PLUS)
    ```
**Note**: The framebuffer solution is used in `cpp`, and the pins are configured in the device tree.

## Execution
Using `cpp` as an example:
+ Navigate to the project folder and set execution permissions

    ```bash
    cd luckfox_retinaface_facenet_demo
    chmod a+x ./luckfox_retinaface_facenet_demo_test
    ```

+ Execute

    ```bash
    ./luckfox_retinaface_facenet_demo_test <retinaface model> <facenet model> <reference image>
    ```

+ Example

    ```bash
    ./luckfox_retinaface_facenet_demo_test ./model/RetinaFace.rknn ./model/mobilefacenet.rknn ./test.jpg
    ```

Replace `test.jpg` with the chosen reference image.

## Execution Result
+ cpp

    Capture images from the camera, process them through model inference and OpenCV-mobile image processing, and display them on the Pico-LCD-1.3 by controlling the screen through framebuffer. Detected faces in the camera feed will be framed, and their Euclidean distance from the reference face image will be marked.
+ cpp_spi

    Capture images from the camera, process them through model inference and OpenCV-mobile image processing, and display them on the Pico-ResTouch-LCD-2.8/Pico-ResTouch-LCD-3.5 via spi communication. Detected faces in the camera feed will be framed, and their Euclidean distance from the reference face image will be marked.
**Note**: When using the `cpp_spi` demo, the system running from the SD card cannot be used as connecting the screen will occupy the corresponding pins of the SD card. Please refer to the [luckfox-pico wiki](https://wiki.luckfox.com/Luckfox-Pico/Luckfox-Pico-ResTouch-LCD/) for configuration.

## Note
Before running the demo, execute `killall rkipc` to disable the default background app `rkicp` running on luckfox-pico, which occupies the camera.