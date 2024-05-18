# 设置目标系统名称和处理器
set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_SYSTEM_PROCESSOR arm)

# 指定交叉编译器的位置
set(CROSS_COMPILER_PREFIX aarch64-linux-gnu)
set(CMAKE_C_COMPILER ${CROSS_COMPILER_PREFIX}-gcc)
set(CMAKE_CXX_COMPILER ${CROSS_COMPILER_PREFIX}-g++)
set(CMAKE_ASM_COMPILER ${CROSS_COMPILER_PREFIX}-gcc)
# set(CMAKE_OBJCOPY ${CROSS_COMPILER_PREFIX}-objcopy)
set(CMAKE_OBJCOPY ${CROSS_COMPILER_PREFIX}-objcopy CACHE INTERNAL "Path to the objcopy utility")

# 设置编译器和链接器的标志
set(CMAKE_C_FLAGS "-march=armv8-a -mtune=cortex-a72 -MMD -Wall" CACHE STRING "Set C Compiler Flags" FORCE)
set(CMAKE_ASM_FLAGS "-march=armv8-a -mtune=cortex-a72 -MMD" CACHE STRING "Set ASM Compiler Flags" FORCE)

set(CMAKE_CXX_FLAGS "-march=armv8-a -mtune=cortex-a72" CACHE STRING "C++ flags")
set(CMAKE_EXE_LINKER_FLAGS "-nostartfiles" CACHE STRING "Linker flags" FORCE)

# 设置查找程序、库、头文件的方式
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)

