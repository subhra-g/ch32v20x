# NOTE:
# The Debug library has dependency on system_ch32v20x.h and ch32v20x_conf.h. system_ch32v20x.h sets
# the system clock, hence it is dependent on the board (i.e. the main application). This is sort of
# circular dependency i.e. the application depends on peripheral lib and peripheral lib depends on
# application specific info.

cmake_minimum_required(VERSION 3.23)

list(APPEND uart_options pa9 pa2 pb10)
list(APPEND compile_options DEBUG_UART1 DEBUG_UART2 DEBUG_UART3)

set(all_debug_print_target "")
foreach(uart compile_opt IN ZIP_LISTS uart_options compile_options)
	message(DEBUG "${uart}: ${compile_opt}")

	set(lib debug-print.uart.${uart})
	add_library(${lib} STATIC)
	list(APPEND all_debug_print_target ${lib})

	target_sources(${lib}
		PUBLIC
		$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/debug.h>
		$<INSTALL_INTERFACE:include/ch32v20x/debug/debug.h>
		PRIVATE
		"${CMAKE_CURRENT_SOURCE_DIR}/debug.c"
	)

	target_include_directories(${lib}
		PUBLIC
		$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
		$<INSTALL_INTERFACE:include/>
		# TODO: "debug.c/h" directly includes somefile from SDK. Following is WORKAROUND just for that.
		$<INSTALL_INTERFACE:include/ch32v20x/peripheral>
	)
	target_compile_definitions(${lib} PUBLIC DEBUG=${compile_opt})
	# Processor Arch related
	target_compile_options(${lib} PUBLIC -msave-restore)
	# Optimization
	target_compile_options(${lib} PRIVATE -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -fno-common)
	target_compile_options(${lib} PRIVATE -msmall-data-limit=8)
	# Debugging and optimization
	# target_compile_options(${lib} PRIVATE -Os)
	# target_compile_options(${lib} PRIVATE $<$<CONFIG:Debug>:-g>)

	target_link_options(${lib} PUBLIC -msave-restore)
	target_link_libraries(${lib}
		PUBLIC
		$<BUILD_INTERFACE:peripheral>
		$<INSTALL_INTERFACE:ch32v20x::peripheral>
	)
	target_link_directories(${lib}
		INTERFACE
		$<INSTALL_INTERFACE:lib/ch32v20x>
	)

	# set the target's folder (for IDEs that support it, e.g. Visual Studio)
	set_target_properties(${lib} PROPERTIES FOLDER "${PROJECT_NAME}")
	add_library(ch32v20x::${lib} ALIAS ${lib})

	message(DEBUG "Created target: ch32v20x::${lib} (${lib})")
endforeach()

if(PROJECT_IS_TOP_LEVEL)
	# Prepare for installation when project is built standalone.
	set(install_debug_print_target ${all_debug_print_target} CACHE INTERNAL "All debug-print targets") # For installation.
endif()

# --------------------------------------------------------------------------------------------------

set(lib debug-print.sdi)
add_library(${lib} STATIC)

target_sources(${lib}
	PUBLIC
	$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/debug.h>
	$<INSTALL_INTERFACE:include/ch32v20x/debug/debug.h>
	PRIVATE
	"${CMAKE_CURRENT_SOURCE_DIR}/debug.c"
)

target_include_directories(${lib}
	PUBLIC
	$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
	$<INSTALL_INTERFACE:include/>
	$<INSTALL_INTERFACE:include/ch32v20x/debug>
)
# Processor Arch related
target_compile_definitions(${lib} PUBLIC SDI_PRINT=SDI_PR_OPEN)
target_compile_options(${lib} PUBLIC -msave-restore)
# Optimization
target_compile_options(${lib} PRIVATE -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -fno-common)
target_compile_options(${lib} PUBLIC -msmall-data-limit=8)
# Debugging and Optimization
# target_compile_options(${lib} PRIVATE -Os)
# target_compile_options(${lib} PRIVATE $<$<CONFIG:Debug>:-g>)
target_link_options(${lib} PUBLIC -msave-restore)
target_link_libraries(${lib}
	PUBLIC
	$<BUILD_INTERFACE:peripheral>
	$<INSTALL_INTERFACE:ch32v20x::peripheral>
)
target_link_directories(${lib}
	INTERFACE
	$<INSTALL_INTERFACE:lib/ch32v20x>
)

# set the target's folder (for IDEs that support it, e.g. Visual Studio)
set_target_properties(${lib} PROPERTIES FOLDER "${PROJECT_NAME}/Debug")
add_library(ch32v20x::${lib} ALIAS ${lib})
