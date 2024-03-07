cmake_minimum_required(VERSION 3.10)

set(CMAKE_C_COMPILER "$ENV{LUCKFOX_SDK_PATH}/tools/linux/toolchain/arm-rockchip830-linux-uclibcgnueabihf/bin/arm-rockchip830-linux-uclibcgnueabihf-gcc"
)
set(CMAKE_CXX_COMPILER "$ENV{LUCKFOX_SDK_PATH}/tools/linux/toolchain/arm-rockchip830-linux-uclibcgnueabihf/bin/arm-rockchip830-linux-uclibcgnueabihf-g++"
)

project(luckfox_retinaface_facenet_demo_test)

if (ENABLE_ASAN)
	message(STATUS "BUILD WITH ADDRESS SANITIZER")
	set (CMAKE_C_FLAGS_DEBUG "${CMAKE_C_FLAGS_DEBUG} -fno-omit-frame-pointer -fsanitize=address")
	set (CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} -fno-omit-frame-pointer -fsanitize=address")
	set (CMAKE_LINKER_FLAGS_DEBUG "${CMAKE_LINKER_FLAGS_DEBUG} -fno-omit-frame-pointer -fsanitize=address")
endif ()

add_definitions(-DRV1106_1103)

set(LIBRKNNRT "${CMAKE_CURRENT_SOURCE_DIR}/3rdparty/rknpu2/Linux/armhf-uclibc/librknnmrt.so")


set(rknpu2_retinaface_file rknpu2/retinaface.cc)
set(rknpu2_facenet_file    rknpu2/facenet.cc)
#dma
#include_directories(${CMAKE_CURRENT_SOURCE_DIR}/../../../3rdparty/allocator/dma)
add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/3rdparty/ 3rdparty.out)
add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/utils/ utils.out)

set(CMAKE_INSTALL_RPATH "$ORIGIN/lib")

file(GLOB SRCS ${CMAKE_CURRENT_SOURCE_DIR}/*.cc)

#Opencv 4
set(OpenCV_DIR "${CMAKE_CURRENT_SOURCE_DIR}/lib/cmake/opencv4")
find_package(OpenCV REQUIRED)
include_directories(${OpenCV_INCLUDE_DIRS})

add_executable(${PROJECT_NAME}
    main.cc
    ${rknpu2_retinaface_file}
    ${rknpu2_facenet_file}
)

target_link_libraries(
    ${PROJECT_NAME}
    ${LIBRKNNRT}
    ${OpenCV_LIBS}
)


set(THREADS_PREFER_PTHREAD_FLAG ON)
find_package(Threads REQUIRED)
target_link_libraries(${PROJECT_NAME} Threads::Threads)

target_include_directories(${PROJECT_NAME} PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_CURRENT_SOURCE_DIR}/3rdparty/rknpu2/include
    ${OpenCV_LIBS}
)


set(CMAKE_INSTALL_PREFIX "${CMAKE_CURRENT_SOURCE_DIR}/luckfox_retinaface_facenet_demo")

install(TARGETS ${PROJECT_NAME} DESTINATION .)
file(GLOB RKNN_FILES "${CMAKE_CURRENT_SOURCE_DIR}/../model/*.rknn")
install(FILES ${RKNN_FILES} DESTINATION model)