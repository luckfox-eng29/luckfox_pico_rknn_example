# Install script for directory: /home/cro/GitPull/luckfox_pico_rknn_example/example/luckfox_retinaface_facenet/cpp_spi

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/home/cro/GitPull/luckfox_pico_rknn_example/example/luckfox_retinaface_facenet/cpp_spi/luckfox_retinaface_facenet_spi_demo")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Install shared libraries without execute permission?
if(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  set(CMAKE_INSTALL_SO_NO_EXE "1")
endif()

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "FALSE")
endif()

# Set default install directory permissions.
if(NOT DEFINED CMAKE_OBJDUMP)
  set(CMAKE_OBJDUMP "/home/cro/Sdk/luckfox-pico/tools/linux/toolchain/arm-rockchip830-linux-uclibcgnueabihf/bin/arm-rockchip830-linux-uclibcgnueabihf-objdump")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/./luckfox_retinaface_facenet_spi_demo_test" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/./luckfox_retinaface_facenet_spi_demo_test")
    file(RPATH_CHECK
         FILE "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/./luckfox_retinaface_facenet_spi_demo_test"
         RPATH "$ORIGIN/lib")
  endif()
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/." TYPE EXECUTABLE FILES "/home/cro/GitPull/luckfox_pico_rknn_example/example/luckfox_retinaface_facenet/cpp_spi/build/luckfox_retinaface_facenet_spi_demo_test")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/./luckfox_retinaface_facenet_spi_demo_test" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/./luckfox_retinaface_facenet_spi_demo_test")
    file(RPATH_CHANGE
         FILE "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/./luckfox_retinaface_facenet_spi_demo_test"
         OLD_RPATH "/home/cro/GitPull/luckfox_pico_rknn_example/example/luckfox_retinaface_facenet/cpp_spi/3rdparty/rknpu2/Linux/armhf-uclibc:"
         NEW_RPATH "$ORIGIN/lib")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/home/cro/Sdk/luckfox-pico/tools/linux/toolchain/arm-rockchip830-linux-uclibcgnueabihf/bin/arm-rockchip830-linux-uclibcgnueabihf-strip" "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/./luckfox_retinaface_facenet_spi_demo_test")
    endif()
  endif()
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/model" TYPE FILE FILES
    "/home/cro/GitPull/luckfox_pico_rknn_example/example/luckfox_retinaface_facenet/cpp_spi/../model/RetinaFace.rknn"
    "/home/cro/GitPull/luckfox_pico_rknn_example/example/luckfox_retinaface_facenet/cpp_spi/../model/mobilefacenet.rknn"
    )
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for each subdirectory.
  include("/home/cro/GitPull/luckfox_pico_rknn_example/example/luckfox_retinaface_facenet/cpp_spi/build/3rdparty.out/cmake_install.cmake")
  include("/home/cro/GitPull/luckfox_pico_rknn_example/example/luckfox_retinaface_facenet/cpp_spi/build/lib/Config/cmake_install.cmake")
  include("/home/cro/GitPull/luckfox_pico_rknn_example/example/luckfox_retinaface_facenet/cpp_spi/build/lib/GUI/cmake_install.cmake")
  include("/home/cro/GitPull/luckfox_pico_rknn_example/example/luckfox_retinaface_facenet/cpp_spi/build/lib/LCD/cmake_install.cmake")
  include("/home/cro/GitPull/luckfox_pico_rknn_example/example/luckfox_retinaface_facenet/cpp_spi/build/lib/SPI/cmake_install.cmake")
  include("/home/cro/GitPull/luckfox_pico_rknn_example/example/luckfox_retinaface_facenet/cpp_spi/build/lib/GPIO/cmake_install.cmake")

endif()

if(CMAKE_INSTALL_COMPONENT)
  set(CMAKE_INSTALL_MANIFEST "install_manifest_${CMAKE_INSTALL_COMPONENT}.txt")
else()
  set(CMAKE_INSTALL_MANIFEST "install_manifest.txt")
endif()

string(REPLACE ";" "\n" CMAKE_INSTALL_MANIFEST_CONTENT
       "${CMAKE_INSTALL_MANIFEST_FILES}")
file(WRITE "/home/cro/GitPull/luckfox_pico_rknn_example/example/luckfox_retinaface_facenet/cpp_spi/build/${CMAKE_INSTALL_MANIFEST}"
     "${CMAKE_INSTALL_MANIFEST_CONTENT}")
