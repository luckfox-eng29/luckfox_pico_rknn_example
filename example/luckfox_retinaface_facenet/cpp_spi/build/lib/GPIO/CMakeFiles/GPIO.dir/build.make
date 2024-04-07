# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.22

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Disable VCS-based implicit rules.
% : %,v

# Disable VCS-based implicit rules.
% : RCS/%

# Disable VCS-based implicit rules.
% : RCS/%,v

# Disable VCS-based implicit rules.
% : SCCS/s.%

# Disable VCS-based implicit rules.
% : s.%

.SUFFIXES: .hpux_make_needs_suffix_list

# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/cro/GitPull/luckfox_pico_rknn_example/example/luckfox_retinaface_facenet/cpp_spi

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/cro/GitPull/luckfox_pico_rknn_example/example/luckfox_retinaface_facenet/cpp_spi/build

# Include any dependencies generated for this target.
include lib/GPIO/CMakeFiles/GPIO.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include lib/GPIO/CMakeFiles/GPIO.dir/compiler_depend.make

# Include the progress variables for this target.
include lib/GPIO/CMakeFiles/GPIO.dir/progress.make

# Include the compile flags for this target's objects.
include lib/GPIO/CMakeFiles/GPIO.dir/flags.make

lib/GPIO/CMakeFiles/GPIO.dir/sysfs_gpio.cc.o: lib/GPIO/CMakeFiles/GPIO.dir/flags.make
lib/GPIO/CMakeFiles/GPIO.dir/sysfs_gpio.cc.o: ../lib/GPIO/sysfs_gpio.cc
lib/GPIO/CMakeFiles/GPIO.dir/sysfs_gpio.cc.o: lib/GPIO/CMakeFiles/GPIO.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/cro/GitPull/luckfox_pico_rknn_example/example/luckfox_retinaface_facenet/cpp_spi/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object lib/GPIO/CMakeFiles/GPIO.dir/sysfs_gpio.cc.o"
	cd /home/cro/GitPull/luckfox_pico_rknn_example/example/luckfox_retinaface_facenet/cpp_spi/build/lib/GPIO && /home/cro/Sdk/luckfox-pico/tools/linux/toolchain/arm-rockchip830-linux-uclibcgnueabihf/bin/arm-rockchip830-linux-uclibcgnueabihf-g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT lib/GPIO/CMakeFiles/GPIO.dir/sysfs_gpio.cc.o -MF CMakeFiles/GPIO.dir/sysfs_gpio.cc.o.d -o CMakeFiles/GPIO.dir/sysfs_gpio.cc.o -c /home/cro/GitPull/luckfox_pico_rknn_example/example/luckfox_retinaface_facenet/cpp_spi/lib/GPIO/sysfs_gpio.cc

lib/GPIO/CMakeFiles/GPIO.dir/sysfs_gpio.cc.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/GPIO.dir/sysfs_gpio.cc.i"
	cd /home/cro/GitPull/luckfox_pico_rknn_example/example/luckfox_retinaface_facenet/cpp_spi/build/lib/GPIO && /home/cro/Sdk/luckfox-pico/tools/linux/toolchain/arm-rockchip830-linux-uclibcgnueabihf/bin/arm-rockchip830-linux-uclibcgnueabihf-g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/cro/GitPull/luckfox_pico_rknn_example/example/luckfox_retinaface_facenet/cpp_spi/lib/GPIO/sysfs_gpio.cc > CMakeFiles/GPIO.dir/sysfs_gpio.cc.i

lib/GPIO/CMakeFiles/GPIO.dir/sysfs_gpio.cc.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/GPIO.dir/sysfs_gpio.cc.s"
	cd /home/cro/GitPull/luckfox_pico_rknn_example/example/luckfox_retinaface_facenet/cpp_spi/build/lib/GPIO && /home/cro/Sdk/luckfox-pico/tools/linux/toolchain/arm-rockchip830-linux-uclibcgnueabihf/bin/arm-rockchip830-linux-uclibcgnueabihf-g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/cro/GitPull/luckfox_pico_rknn_example/example/luckfox_retinaface_facenet/cpp_spi/lib/GPIO/sysfs_gpio.cc -o CMakeFiles/GPIO.dir/sysfs_gpio.cc.s

# Object files for target GPIO
GPIO_OBJECTS = \
"CMakeFiles/GPIO.dir/sysfs_gpio.cc.o"

# External object files for target GPIO
GPIO_EXTERNAL_OBJECTS =

lib/GPIO/libGPIO.a: lib/GPIO/CMakeFiles/GPIO.dir/sysfs_gpio.cc.o
lib/GPIO/libGPIO.a: lib/GPIO/CMakeFiles/GPIO.dir/build.make
lib/GPIO/libGPIO.a: lib/GPIO/CMakeFiles/GPIO.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/cro/GitPull/luckfox_pico_rknn_example/example/luckfox_retinaface_facenet/cpp_spi/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX static library libGPIO.a"
	cd /home/cro/GitPull/luckfox_pico_rknn_example/example/luckfox_retinaface_facenet/cpp_spi/build/lib/GPIO && $(CMAKE_COMMAND) -P CMakeFiles/GPIO.dir/cmake_clean_target.cmake
	cd /home/cro/GitPull/luckfox_pico_rknn_example/example/luckfox_retinaface_facenet/cpp_spi/build/lib/GPIO && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/GPIO.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
lib/GPIO/CMakeFiles/GPIO.dir/build: lib/GPIO/libGPIO.a
.PHONY : lib/GPIO/CMakeFiles/GPIO.dir/build

lib/GPIO/CMakeFiles/GPIO.dir/clean:
	cd /home/cro/GitPull/luckfox_pico_rknn_example/example/luckfox_retinaface_facenet/cpp_spi/build/lib/GPIO && $(CMAKE_COMMAND) -P CMakeFiles/GPIO.dir/cmake_clean.cmake
.PHONY : lib/GPIO/CMakeFiles/GPIO.dir/clean

lib/GPIO/CMakeFiles/GPIO.dir/depend:
	cd /home/cro/GitPull/luckfox_pico_rknn_example/example/luckfox_retinaface_facenet/cpp_spi/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/cro/GitPull/luckfox_pico_rknn_example/example/luckfox_retinaface_facenet/cpp_spi /home/cro/GitPull/luckfox_pico_rknn_example/example/luckfox_retinaface_facenet/cpp_spi/lib/GPIO /home/cro/GitPull/luckfox_pico_rknn_example/example/luckfox_retinaface_facenet/cpp_spi/build /home/cro/GitPull/luckfox_pico_rknn_example/example/luckfox_retinaface_facenet/cpp_spi/build/lib/GPIO /home/cro/GitPull/luckfox_pico_rknn_example/example/luckfox_retinaface_facenet/cpp_spi/build/lib/GPIO/CMakeFiles/GPIO.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : lib/GPIO/CMakeFiles/GPIO.dir/depend
