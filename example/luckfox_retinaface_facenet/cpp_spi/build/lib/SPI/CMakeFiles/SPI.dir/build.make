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
include lib/SPI/CMakeFiles/SPI.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include lib/SPI/CMakeFiles/SPI.dir/compiler_depend.make

# Include the progress variables for this target.
include lib/SPI/CMakeFiles/SPI.dir/progress.make

# Include the compile flags for this target's objects.
include lib/SPI/CMakeFiles/SPI.dir/flags.make

lib/SPI/CMakeFiles/SPI.dir/dev_hardware_SPI.cc.o: lib/SPI/CMakeFiles/SPI.dir/flags.make
lib/SPI/CMakeFiles/SPI.dir/dev_hardware_SPI.cc.o: ../lib/SPI/dev_hardware_SPI.cc
lib/SPI/CMakeFiles/SPI.dir/dev_hardware_SPI.cc.o: lib/SPI/CMakeFiles/SPI.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/cro/GitPull/luckfox_pico_rknn_example/example/luckfox_retinaface_facenet/cpp_spi/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object lib/SPI/CMakeFiles/SPI.dir/dev_hardware_SPI.cc.o"
	cd /home/cro/GitPull/luckfox_pico_rknn_example/example/luckfox_retinaface_facenet/cpp_spi/build/lib/SPI && /home/cro/Sdk/luckfox-pico/tools/linux/toolchain/arm-rockchip830-linux-uclibcgnueabihf/bin/arm-rockchip830-linux-uclibcgnueabihf-g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT lib/SPI/CMakeFiles/SPI.dir/dev_hardware_SPI.cc.o -MF CMakeFiles/SPI.dir/dev_hardware_SPI.cc.o.d -o CMakeFiles/SPI.dir/dev_hardware_SPI.cc.o -c /home/cro/GitPull/luckfox_pico_rknn_example/example/luckfox_retinaface_facenet/cpp_spi/lib/SPI/dev_hardware_SPI.cc

lib/SPI/CMakeFiles/SPI.dir/dev_hardware_SPI.cc.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/SPI.dir/dev_hardware_SPI.cc.i"
	cd /home/cro/GitPull/luckfox_pico_rknn_example/example/luckfox_retinaface_facenet/cpp_spi/build/lib/SPI && /home/cro/Sdk/luckfox-pico/tools/linux/toolchain/arm-rockchip830-linux-uclibcgnueabihf/bin/arm-rockchip830-linux-uclibcgnueabihf-g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/cro/GitPull/luckfox_pico_rknn_example/example/luckfox_retinaface_facenet/cpp_spi/lib/SPI/dev_hardware_SPI.cc > CMakeFiles/SPI.dir/dev_hardware_SPI.cc.i

lib/SPI/CMakeFiles/SPI.dir/dev_hardware_SPI.cc.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/SPI.dir/dev_hardware_SPI.cc.s"
	cd /home/cro/GitPull/luckfox_pico_rknn_example/example/luckfox_retinaface_facenet/cpp_spi/build/lib/SPI && /home/cro/Sdk/luckfox-pico/tools/linux/toolchain/arm-rockchip830-linux-uclibcgnueabihf/bin/arm-rockchip830-linux-uclibcgnueabihf-g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/cro/GitPull/luckfox_pico_rknn_example/example/luckfox_retinaface_facenet/cpp_spi/lib/SPI/dev_hardware_SPI.cc -o CMakeFiles/SPI.dir/dev_hardware_SPI.cc.s

# Object files for target SPI
SPI_OBJECTS = \
"CMakeFiles/SPI.dir/dev_hardware_SPI.cc.o"

# External object files for target SPI
SPI_EXTERNAL_OBJECTS =

lib/SPI/libSPI.a: lib/SPI/CMakeFiles/SPI.dir/dev_hardware_SPI.cc.o
lib/SPI/libSPI.a: lib/SPI/CMakeFiles/SPI.dir/build.make
lib/SPI/libSPI.a: lib/SPI/CMakeFiles/SPI.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/cro/GitPull/luckfox_pico_rknn_example/example/luckfox_retinaface_facenet/cpp_spi/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX static library libSPI.a"
	cd /home/cro/GitPull/luckfox_pico_rknn_example/example/luckfox_retinaface_facenet/cpp_spi/build/lib/SPI && $(CMAKE_COMMAND) -P CMakeFiles/SPI.dir/cmake_clean_target.cmake
	cd /home/cro/GitPull/luckfox_pico_rknn_example/example/luckfox_retinaface_facenet/cpp_spi/build/lib/SPI && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/SPI.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
lib/SPI/CMakeFiles/SPI.dir/build: lib/SPI/libSPI.a
.PHONY : lib/SPI/CMakeFiles/SPI.dir/build

lib/SPI/CMakeFiles/SPI.dir/clean:
	cd /home/cro/GitPull/luckfox_pico_rknn_example/example/luckfox_retinaface_facenet/cpp_spi/build/lib/SPI && $(CMAKE_COMMAND) -P CMakeFiles/SPI.dir/cmake_clean.cmake
.PHONY : lib/SPI/CMakeFiles/SPI.dir/clean

lib/SPI/CMakeFiles/SPI.dir/depend:
	cd /home/cro/GitPull/luckfox_pico_rknn_example/example/luckfox_retinaface_facenet/cpp_spi/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/cro/GitPull/luckfox_pico_rknn_example/example/luckfox_retinaface_facenet/cpp_spi /home/cro/GitPull/luckfox_pico_rknn_example/example/luckfox_retinaface_facenet/cpp_spi/lib/SPI /home/cro/GitPull/luckfox_pico_rknn_example/example/luckfox_retinaface_facenet/cpp_spi/build /home/cro/GitPull/luckfox_pico_rknn_example/example/luckfox_retinaface_facenet/cpp_spi/build/lib/SPI /home/cro/GitPull/luckfox_pico_rknn_example/example/luckfox_retinaface_facenet/cpp_spi/build/lib/SPI/CMakeFiles/SPI.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : lib/SPI/CMakeFiles/SPI.dir/depend
