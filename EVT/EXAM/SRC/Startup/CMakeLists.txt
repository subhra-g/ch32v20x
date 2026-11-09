cmake_minimum_required(VERSION 3.23)

# Check if the startup file exists or not.
if(NOT EXISTS ${CMAKE_CURRENT_SOURCE_DIR}/${startup_file_name})
	message(FATAL_ERROR "Deduced startup file name ${startup_file_name} doesn't exit in ${CMAKE_CURRENT_SOURCE_DIR}")
endif()

set(lib startupLib)

add_library(${lib} STATIC)
target_sources(${lib}
	PRIVATE
	"${CMAKE_CURRENT_SOURCE_DIR}/${startup_file_name}"
)

# Processor Arch related
target_compile_options(${lib} PUBLIC -msave-restore)
target_compile_definitions(${lib} PUBLIC ${MCU_FAMILY} ${MCU_CLASS_FULL_NAME})

# Optimization. Intentionally kept private.
target_compile_options(${lib} PRIVATE -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -fno-common)
target_compile_options(${lib} PRIVATE -msmall-data-limit=8)

# Debugging and Optimization
# target_compile_options(${lib} PRIVATE -Os)
# target_compile_options(${lib} PRIVATE $<$<CONFIG:Debug>:-g>)

# Linker options
target_link_options(${lib} PUBLIC -msave-restore)
# This is the startup. So, do not use standard system startup files when linking.
target_link_options(${lib} PUBLIC -nostartfiles)
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
	$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/${startup_file_name}>
	# These startup script needs to installed in 'startup/ch32v20x'
	$<INSTALL_INTERFACE:startup/ch32v20x/${startup_file_name}>
)
target_compile_definitions(${lib} INTERFACE ${MCU_FAMILY} ${MCU_CLASS_FULL_NAME})
# This is the startup. So, do not use standard system startup files when linking.
target_link_options(${lib} INTERFACE -nostartfiles)
set_target_properties(${lib} PROPERTIES FOLDER "${PROJECT_NAME}/Debug")
set_target_properties(${lib} PROPERTIES FOLDER "${PROJECT_NAME}")
add_library(ch32v20x::${lib} ALIAS ${lib})
