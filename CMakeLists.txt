cmake_minimum_required(VERSION 3.25.0)

set(CMAKE_TOOLCHAIN_FILE "${CMAKE_SOURCE_DIR}/toolchain-file.cmake")

project(Benos_W C ASM)



# 设置交叉编译器
# set(ARMGNU aarch64-linux-gnu CACHE STRING "Cross compiler")

# 设置板型
set(board "rpi4" CACHE STRING "Board type")

# 根据板型设置编译选项
if(board STREQUAL "rpi3")
    add_definitions(-DCONFIG_BOARD_PI3B)
    set(QEMU_FLAGS "-machine raspi3")
elseif(board STREQUAL "rpi4")
    add_definitions(-DCONFIG_BOARD_PI4B)
    set(QEMU_FLAGS "-machine raspi4b1g")
endif()

# 设置编译器标志
# set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -g -Wall -Iinclude")
# set(CMAKE_ASM_FLAGS "${CMAKE_ASM_FLAGS} -g -Iinclude")

# 设置源文件目录和构建目录
set(SRC_DIR "${CMAKE_SOURCE_DIR}/src")
set(BUILD_DIR "${CMAKE_BINARY_DIR}/build")

# 设置源文件
file(GLOB C_FILES "${SRC_DIR}/*.c")
file(GLOB ASM_FILES "${SRC_DIR}/*.S")

# 设置目标文件
set(OBJ_FILES ${C_FILES} ${ASM_FILES})
# set_source_files_properties(${ASM_FILES} PROPERTIES LANGUAGE ASM)

# 添加链接器脚本
set(LINKER_SCRIPT "${SRC_DIR}/linker.ld")

# 添加可执行文件
add_executable(benos.elf ${OBJ_FILES})
set_target_properties(benos.elf PROPERTIES LINK_FLAGS "-T ${LINKER_SCRIPT}")

target_include_directories(benos.elf
    PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}/include
    )

# 添加自定义命令，生成二进制文件
add_custom_command(TARGET benos.elf
    POST_BUILD
    COMMAND ${CMAKE_OBJCOPY} $<TARGET_FILE:benos.elf> -O binary benos.bin
    BYPRODUCTS benos.bin
    COMMENT "Converting ELF to binary")

# add_custom_command(TARGET benos.elf
#                    POST_BUILD
#                    COMMAND /home/wang/wang/runninglinuxkernel/qemu-patch-raspberry4/build/qemu-system-aarch64 -machine raspi4b1g -nographic -kernel benos.bin -S -s
#                    COMMENT "Running QEMU after building benos.elf")
