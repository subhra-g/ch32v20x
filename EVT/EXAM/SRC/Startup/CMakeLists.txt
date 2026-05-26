cmake_minimum_required(VERSION 3.23)

set(lib startupLib)

add_library(${lib} STATIC)

# TODO: startup_ch32v20x_D8.S(CH32V203RB) and startup_ch32v20x_D8W.S(CH32V208)
target_sources(${lib}
	PRIVATE
	"${CMAKE_CURRENT_SOURCE_DIR}/startup_ch32v20x_D6.S"
)

# Processor Arch related
target_compile_options(${lib} PUBLIC -msave-restore)

# Optimization. Intentionally kept private.
target_compile_options(${lib} PRIVATE -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -fno-common)
target_compile_options(${lib} PRIVATE -msmall-data-limit=8)

# Debugging and Optimization
# target_compile_options(${lib} PRIVATE -Os)
# target_compile_options(${lib} PRIVATE $<$<CONFIG:Debug>:-g>)

# Linker options
target_link_options(${lib} PUBLIC -msave-restore)
#target_link_options(${lib} PUBLIC -Xlinker --gc-sections)
#ToDo: This assembly file expect a function 'SystemInit'. It doesn't create problem durinng compile
#      time, rather it causes linker error. How to solve it?
#      1. Expect a predefined target which must have the symbol(function). This will have PUBLIC dependency with that target.
#      2. Just keep it as it is. It is user's responsibility to link with a target with the symbol(function) defined.

# set the target's folder (for IDEs that support it, e.g. Visual Studio)
set_target_properties(${lib} PROPERTIES FOLDER "${PROJECT_NAME}")
add_library(ch32v20x::${lib} ALIAS ${lib})

# An interface target if app directly wants to use the script.
set(lib startup)
add_library(${lib} INTERFACE)
target_sources(${lib}
	INTERFACE
	$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/startup_ch32v20x_D6.S>  # For CH32V203F6, CH32V203F8, CH32V203G6, CH32V203G8, CH32V203K8, CH32V203C6, CH32V203C8, CH32V203G8
	# ToDo: Incorporate followings.
	# $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/startup_ch32v20x_D8.S>  # For CH32V203RB
	# $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/startup_ch32v20x_D8W.S> # For CH32V208x
	# These startup script needs to installed in 'startup/ch32v20x'
	$<INSTALL_INTERFACE:startup/ch32v20x/startup_ch32v20x_D6.S> # For CH32V203F6, CH32V203F8, CH32V203G6, CH32V203G8, CH32V203K8, CH32V203C6, CH32V203C8, CH32V203G8
	# ToDo: Incorporate followings.
	# $<INSTALL_INTERFACE:startup/ch32v20x/startup_ch32v20x_D8.S> # For CH32V203RB
	# $<INSTALL_INTERFACE:startup/ch32v20x/startup_ch32v20x_D8W.S> # For CH32V208x
)
set_target_properties(${lib} PROPERTIES FOLDER "${PROJECT_NAME}/Debug")
set_target_properties(${lib} PROPERTIES FOLDER "${PROJECT_NAME}")
add_library(ch32v20x::${lib} ALIAS ${lib})
