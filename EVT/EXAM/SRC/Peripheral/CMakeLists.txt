cmake_minimum_required(VERSION 3.23)

set(lib peripheral)

add_library(${lib} STATIC)

# HAL Peripherals
target_sources(${lib}
	PUBLIC
	$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/inc/ch32v20x.h>
	$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/inc/ch32v20x_adc.h>
	$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/inc/ch32v20x_bkp.h>
	$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/inc/ch32v20x_can.h>
	$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/inc/ch32v20x_crc.h>
	$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/inc/ch32v20x_dbgmcu.h>
	$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/inc/ch32v20x_dma.h>
	$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/inc/ch32v20x_exti.h>
	$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/inc/ch32v20x_flash.h>
	$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/inc/ch32v20x_gpio.h>
	$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/inc/ch32v20x_i2c.h>
	$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/inc/ch32v20x_iwdg.h>
	$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/inc/ch32v20x_misc.h>
	$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/inc/ch32v20x_opa.h>
	$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/inc/ch32v20x_pwr.h>
	$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/inc/ch32v20x_rcc.h>
	$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/inc/ch32v20x_rtc.h>
	$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/inc/ch32v20x_spi.h>
	$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/inc/ch32v20x_tim.h>
	$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/inc/ch32v20x_usart.h>
	$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/inc/ch32v20x_usb.h>
	$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/inc/ch32v20x_wwdg.h>
	# Install location for following files needs to be in include/Peripheral
	$<INSTALL_INTERFACE:include/ch32v20x/peripheral/ch32v20x.h>
	$<INSTALL_INTERFACE:include/ch32v20x/peripheral/ch32v20x_adc.h>
	$<INSTALL_INTERFACE:include/ch32v20x/peripheral/ch32v20x_bkp.h>
	$<INSTALL_INTERFACE:include/ch32v20x/peripheral/ch32v20x_can.h>
	$<INSTALL_INTERFACE:include/ch32v20x/peripheral/ch32v20x_crc.h>
	$<INSTALL_INTERFACE:include/ch32v20x/peripheral/ch32v20x_dbgmcu.h>
	$<INSTALL_INTERFACE:include/ch32v20x/peripheral/ch32v20x_dma.h>
	$<INSTALL_INTERFACE:include/ch32v20x/peripheral/ch32v20x_exti.h>
	$<INSTALL_INTERFACE:include/ch32v20x/peripheral/ch32v20x_flash.h>
	$<INSTALL_INTERFACE:include/ch32v20x/peripheral/ch32v20x_gpio.h>
	$<INSTALL_INTERFACE:include/ch32v20x/peripheral/ch32v20x_i2c.h>
	$<INSTALL_INTERFACE:include/ch32v20x/peripheral/ch32v20x_iwdg.h>
	$<INSTALL_INTERFACE:include/ch32v20x/peripheral/ch32v20x_misc.h>
	$<INSTALL_INTERFACE:include/ch32v20x/peripheral/ch32v20x_opa.h>
	$<INSTALL_INTERFACE:include/ch32v20x/peripheral/ch32v20x_pwr.h>
	$<INSTALL_INTERFACE:include/ch32v20x/peripheral/ch32v20x_rcc.h>
	$<INSTALL_INTERFACE:include/ch32v20x/peripheral/ch32v20x_rtc.h>
	$<INSTALL_INTERFACE:include/ch32v20x/peripheral/ch32v20x_spi.h>
	$<INSTALL_INTERFACE:include/ch32v20x/peripheral/ch32v20x_tim.h>
	$<INSTALL_INTERFACE:include/ch32v20x/peripheral/ch32v20x_usart.h>
	$<INSTALL_INTERFACE:include/ch32v20x/peripheral/ch32v20x_usb.h>
	$<INSTALL_INTERFACE:include/ch32v20x/peripheral/ch32v20x_wwdg.h>
	PRIVATE
	"${CMAKE_CURRENT_SOURCE_DIR}/src/ch32v20x_adc.c"
	"${CMAKE_CURRENT_SOURCE_DIR}/src/ch32v20x_bkp.c"
	"${CMAKE_CURRENT_SOURCE_DIR}/src/ch32v20x_can.c"
	"${CMAKE_CURRENT_SOURCE_DIR}/src/ch32v20x_crc.c"
	"${CMAKE_CURRENT_SOURCE_DIR}/src/ch32v20x_dbgmcu.c"
	"${CMAKE_CURRENT_SOURCE_DIR}/src/ch32v20x_dma.c"
	"${CMAKE_CURRENT_SOURCE_DIR}/src/ch32v20x_exti.c"
	"${CMAKE_CURRENT_SOURCE_DIR}/src/ch32v20x_flash.c"
	"${CMAKE_CURRENT_SOURCE_DIR}/src/ch32v20x_gpio.c"
	"${CMAKE_CURRENT_SOURCE_DIR}/src/ch32v20x_i2c.c"
	"${CMAKE_CURRENT_SOURCE_DIR}/src/ch32v20x_iwdg.c"
	"${CMAKE_CURRENT_SOURCE_DIR}/src/ch32v20x_misc.c"
	"${CMAKE_CURRENT_SOURCE_DIR}/src/ch32v20x_opa.c"
	"${CMAKE_CURRENT_SOURCE_DIR}/src/ch32v20x_pwr.c"
	"${CMAKE_CURRENT_SOURCE_DIR}/src/ch32v20x_rcc.c"
	"${CMAKE_CURRENT_SOURCE_DIR}/src/ch32v20x_rtc.c"
	"${CMAKE_CURRENT_SOURCE_DIR}/src/ch32v20x_spi.c"
	"${CMAKE_CURRENT_SOURCE_DIR}/src/ch32v20x_tim.c"
	"${CMAKE_CURRENT_SOURCE_DIR}/src/ch32v20x_usart.c"
	"${CMAKE_CURRENT_SOURCE_DIR}/src/ch32v20x_wwdg.c"
)

target_include_directories(${lib} 
	PUBLIC
	$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/inc>
	$<INSTALL_INTERFACE:include/>
	# TODO: "debug.c/h" directly includes somefile from SDK. Following is WORKAROUND just for that.
	$<INSTALL_INTERFACE:include/ch32v20x/peripheral>
)
# Processor Arch related
target_compile_options(${lib} PUBLIC -msave-restore)
# Optimization. Intentionally kept private.
target_compile_options(${lib} PRIVATE -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -fno-common)
target_compile_options(${lib} PRIVATE -msmall-data-limit=8)
# Debugging and Optimization
# target_compile_options(${lib_name} PRIVATE -Os)
# target_compile_options(${lib_name} PRIVATE $<$<CONFIG:Debug>:-g>)
# Linker
target_link_options(${lib} PUBLIC -msave-restore)
target_link_libraries(${lib} PUBLIC ch32v20x::core)

set_target_properties(${lib} PROPERTIES FOLDER "${PROJECT_NAME}")
add_library(ch32v20x::peripheral ALIAS ${lib})
