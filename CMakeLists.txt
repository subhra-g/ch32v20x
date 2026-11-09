#[[
CONFIGURATIONS:
- MCU:
		CH32V20x_D8W: CH32V208
		CH32V20x_D8 : CH32V203RB
		CH32V20x_D6 : CH32V203F6-CH32V203F8-CH32V203G6-CH32V203G8-CH32V203K8-CH32V203C6-CH32V203C8-CH32V203G8
		If none defined, SDK will set the default one. The default in SDK can be controlled by commenting/uncommenting line.
- HSE_VALUE

Usage instruction:
Using CMake,
1. Use `FetchContent`.
    include(FetchContent)
    FetchContent_Declare(ch32v20xhal
      SOURCE_DIR "PATH/TO/SDK" # e.g ${HOME}/dev/libs/ch32v20x/EVT/EXAM
      CMAKE_ARGS "-DMCU=${ch32v203c8}"
      EXCLUDE_FROM_ALL
      SYSTEM
    )
    Fetchcontent_MakeAvailable(ch32v20xhal)
2. The main application needs to have a function `SystemInit` defined. This function is expected to be
	 called from the startup file. The function can be defined in the main application or in a target
	 which is linked with the main application. The function is expected to initialize the system clock
	 and other system related initializations. Refer to the examples in the SDK for more details.
#]]

cmake_minimum_required(VERSION 3.23)

project("ch32v20xhal" VERSION 2.2.0 # The version is from ch32v20x.h
	DESCRIPTION "CH32V20x HAL"
	HOMEPAGE_URL "https://github.com/openwch/ch32v20x/tree/main/EVT/EXAM"
	LANGUAGES C CXX ASM)

# if(NOT DEFINED MCU)
# 	message(FATAL_ERROR "MCU not defined to build CH32V20x HAL")
# endif()

# if(NOT TARGET ch32v20x_config)
# 	message(FATAL_ERROR "ch32v20x_config target is required. This target should have include path which holds ch32v20x_conf.h and system_ch32v20x.h.")
# endif()

# This SDK supports only CH32V203 and CH32V208 MCUs
set(MCU_FAMILY CH32V20x) # Includes CH32V203, CH32V208

# Detect MCU Classification
# From reference manual (CH32FV2x_V3xRM.PDF)
# CH32V20x_D6: CH32V203F6, CH32V203G6, CH32V203F8, CH32V203G8, CH32V203K8, CH32V203C6 and CH32V203C8.
# CH32V20x_D8: CH32V203RB.
# CH32V20x_D8W: CH32V208GB, CH32V208CB, CH32V208RB and CH32V208WB.
if(${MCU} MATCHES "^CH32V203[FGC][68]")
	set(MCU_CLASS D6)
elseif(${MCU} MATCHES "^CH32V203K8")
	set(MCU_CLASS D6)
elseif(${MCU} MATCHES "^CH32V203RB")
	set(MCU_CLASS D8)
elseif(${MCU} MATCHES "^CH32V208[GCRW]B")
	set(MCU_CLASS D8W)
else()
	message(FATAL_ERROR "Invalid MCU ${MCU}")
endif()
message(STATUS "MCU: ${MCU}, Family: ${MCU_FAMILY}, Class: ${MCU_CLASS}")

set(MCU_CLASS_FULL_NAME "${MCU_FAMILY}_${MCU_CLASS}")
string(TOLOWER ${MCU_FAMILY} MCU_FAMILY_SMALL_CASE)
set(startup_file_name "startup_${MCU_FAMILY_SMALL_CASE}_${MCU_CLASS}.S")
message(VERBOSE "Setting startup file to ${startup_file_name}")

# ToDo: Following way of setting MCU specific option doesn't make sense when it is consumed using FetchContent.
#       But it is required when built as package (to be consumed by  find_package).
#       How to satisfy both use case?
if(PROJECT_IS_TOP_LEVEL)
	# ToDo: Need to accomodate other supported MCUs by this SDK.
	include(${CMAKE_CURRENT_SOURCE_DIR}/cmake/${MCU}.cmake)
endif()

message(VERBOSE "Building ${PROJECT_NAME} for ${MCU}")

# This is the manufacturer provided HAL.
add_subdirectory(EVT/EXAM)

# Don't setup installation when the project is not build standalone(e.g. `FetchContent`).
if(PROJECT_IS_TOP_LEVEL)
	message(STATUS "CH32V20x HAL is being build as top project")
	include(cmake/install.cmake)
endif()


#[[
cmake configure command with installation info:
-----------------------------------------------
cmake .. --preset preset_name -DCMAKE_INSTALL_PREFIX:PATH=<Path to install>
cmake --build build_dir/ --config <Debug/Release> --target install

e.g.
cmake --preset ch32v203c8 -DCMAKE_INSTALL_PREFIX:PATH=$PWD/SDK_BUILD_TEST
cmake --build build/ch32v203c8/ --config Release --target install
#]]
