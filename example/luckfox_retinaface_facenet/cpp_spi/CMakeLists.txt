cmake_minimum_required(VERSION 3.10)

set(SDK_PATH $ENV{LUCKFOX_SDK_PATH})
if(NOT SDK_PATH)
    message(WARNING "Please Set Luckfox-pico SDK Path. Such as:export LUCKFOX_SDK_PATH=/home/user/luckfox-pico")
    return()
endif()

set(CMAKE_C_COMPILER "${SDK_PATH}/tools/linux/toolchain/arm-rockchip830-linux-uclibcgnueabihf/bin/arm-rockchip830-linux-uclibcgnueabihf-gcc"
)
set(CMAKE_CXX_COMPILER "${SDK_PATH}/tools/linux/toolchain/arm-rockchip830-linux-uclibcgnueabihf/bin/arm-rockchip830-linux-uclibcgnueabihf-g++"
)

project(luckfox_retinaface_facenet_spi_demo_text)

add_definitions(-DRV1106_1103)
add_definitions(-DLUCKFOX_PLUS)

#subdirectory
include_directories(${CMAKE_CURRENT_SOURCE_DIR}/lib/Config)
include_directories(${CMAKE_CURRENT_SOURCE_DIR}/lib/GUI)
include_directories(${CMAKE_CURRENT_SOURCE_DIR}/lib/LCD)
include_directories(${CMAKE_CURRENT_SOURCE_DIR}/lib/SPI)
include_directories(${CMAKE_CURRENT_SOURCE_DIR}/lib/GPIO)

add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/3rdparty 3rdparty.out)
add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/lib/Config)
add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/lib/GUI)
add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/lib/LCD)
add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/lib/SPI)
add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/lib/GPIO)

set(CMAKE_INSTALL_RPATH "$ORIGIN/lib")

#library
set(OpenCV_DIR "${CMAKE_CURRENT_SOURCE_DIR}/lib/cmake/opencv4")
find_package(OpenCV REQUIRED)
include_directories(${OpenCV_INCLUDE_DIRS})
set(THREADS_PREFER_PTHREAD_FLAG ON)
find_package(Threads REQUIRED)

#executable
file(GLOB SRCS ${CMAKE_CURRENT_SOURCE_DIR}/src/*.cc)
add_executable(${PROJECT_NAME}
    ${SRCS}
)

target_link_libraries(${PROJECT_NAME} 
    ${LIBRKNNRT}
    ${OpenCV_LIBS}
    Threads::Threads
    Config 
    GUI 
    LCD
    SPI
    GPIO 
)

#include
target_include_directories(${PROJECT_NAME} PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}/include
    ${CMAKE_CURRENT_SOURCE_DIR}/3rdparty/rknpu2/include 
    ${CMAKE_CURRENT_SOURCE_DIR}/lib/Config
    ${CMAKE_CURRENT_SOURCE_DIR}/lib/GUI 
    ${CMAKE_CURRENT_SOURCE_DIR}/lib/LCD
    ${CMAKE_CURRENT_SOURCE_DIR}/lib/SPI
    ${CMAKE_CURRENT_SOURCE_DIR}/lib/GPIO 
    ${OpenCV_INCLUDE_DIRS}
)

#install
set(CMAKE_INSTALL_PREFIX "${CMAKE_CURRENT_SOURCE_DIR}/luckfox_retinaface_facenet_spi_demo")
install(TARGETS ${PROJECT_NAME} DESTINATION .)
file(GLOB RKNN_FILES "${CMAKE_CURRENT_SOURCE_DIR}/../model/*.rknn")
install(FILES ${RKNN_FILES} DESTINATION model)