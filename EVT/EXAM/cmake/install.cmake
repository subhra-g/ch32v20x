# Include for 
#	CMAKE_INSTALL_INCLUDEDIR  => usually 'include'
#	CMAKE_INSTALL_LIBDIR      => usually 'lib'
#	CMAKE_INSTALL_BINDIR      => usually 'bin'
#	CMAKE_INSTALL_DATAROOTDIR => usually 'share'
include(GNUInstallDirs)

# Trying out based on https://dominikberner.ch//cmake-interface-lib/
# https://crascit.com/2016/01/31/enhanced-source-file-handling-with-target_sources/
# message(STATUS "DEBUG: CMAKE_INSTALL_INCLUDEDIR  - ${CMAKE_INSTALL_INCLUDEDIR}")
# message(STATUS "DEBUG: CMAKE_INSTALL_LIBDIR      - ${CMAKE_INSTALL_LIBDIR}")
# message(STATUS "DEBUG: CMAKE_INSTALL_BINDIR      - ${CMAKE_INSTALL_BINDIR}")
# message(STATUS "DEBUG: CMAKE_INSTALL_DATAROOTDIR - ${CMAKE_INSTALL_DATAROOTDIR}")

#[[
Installtion planning:
install_dir
  |
  +-- include
  |   |
  |   +-- ch32v20x
  |       |
  |       +-- core -> Contains headers from 'SRC/Core'
  |       |
  |       +-- peripheral -> Contains headers from 'SRC/Peripheral/inc'
  +-- lib
  |   |
  |   +-- ch32v20x -> Contains all built archives and linker script
  |
  +-- share
      |
      +-- cmake -> Contains cmake scripts. use this path for find_package
#]]

install(TARGETS hal.core hal.peripheral hal.startup hal.ld
	EXPORT ch32v20xhal_Targets
	# INCLUDES DESTINATION include/ch32v20x # For include files => ${CMAKE_INSTALL_INCLUDEDIR}
	# PUBLIC_HEADER DESTINATION include/ch32v20x
	# HEADER DESTINATION  include/ch32v20x
	# INTERFACE_SOURCES DESTINATION include/ch32v20x
	ARCHIVE DESTINATION lib/ch32v20x      # For static libs   => ${CMAKE_INSTALL_LIBDIR}
	LIBRARY DESTINATION lib               # For dyamic libs   => ${CMAKE_INSTALL_LIBDIR}
	RUNTIME DESTINATION bin               # For executables   => ${CMAKE_INSTALL_BINDIR}
)
include(CMakePackageConfigHelpers)
write_basic_package_version_file("ch32v20xhalConfigVersion.cmake"
	VERSION ${PROJECT_VERSION}
	COMPATIBILITY SameMajorVersion
)

configure_package_config_file(
	"${PROJECT_SOURCE_DIR}/cmake/ch32v20xhalConfig.cmake.in"
	"${PROJECT_BINARY_DIR}/ch32v20xhalConfig.cmake"
	INSTALL_DESTINATION
	${CMAKE_INSTALL_DATAROOTDIR}/cmake
)

install(EXPORT ch32v20xhal_Targets
	FILE ch32v20xhalTargets.cmake
	NAMESPACE ${PROJECT_NAME}::
	DESTINATION ${CMAKE_INSTALL_DATAROOTDIR}/cmake
)

install(
	FILES "${PROJECT_BINARY_DIR}/ch32v20xhalConfig.cmake"
	      "${PROJECT_BINARY_DIR}/ch32v20xhalConfigVersion.cmake"
	DESTINATION ${CMAKE_INSTALL_DATAROOTDIR}/cmake
)

# REVIEW: Is there no way to do it automatically, like the PUBLIC sources?
install(FILES ${PROJECT_SOURCE_DIR}/SRC/core/core_riscv.h DESTINATION include/ch32v20x/core)
# Following copies 'inc' directory in 'peripheral' creating 'peripheral/inc' path
# install(DIRECTORY ${PROJECT_SOURCE_DIR}/SRC/Peripheral/inc DESTINATION include/ch32v20x/peripheral)
list(APPEND peripheral_srcs
	${PROJECT_SOURCE_DIR}/SRC/Peripheral/inc/ch32v20x.h
	${PROJECT_SOURCE_DIR}/SRC/Peripheral/inc/ch32v20x_adc.h
	${PROJECT_SOURCE_DIR}/SRC/Peripheral/inc/ch32v20x_bkp.h
	${PROJECT_SOURCE_DIR}/SRC/Peripheral/inc/ch32v20x_can.h
	${PROJECT_SOURCE_DIR}/SRC/Peripheral/inc/ch32v20x_crc.h
	${PROJECT_SOURCE_DIR}/SRC/Peripheral/inc/ch32v20x_dbgmcu.h
	${PROJECT_SOURCE_DIR}/SRC/Peripheral/inc/ch32v20x_dma.h
	${PROJECT_SOURCE_DIR}/SRC/Peripheral/inc/ch32v20x_exti.h
	${PROJECT_SOURCE_DIR}/SRC/Peripheral/inc/ch32v20x_flash.h
	${PROJECT_SOURCE_DIR}/SRC/Peripheral/inc/ch32v20x_gpio.h
	${PROJECT_SOURCE_DIR}/SRC/Peripheral/inc/ch32v20x_i2c.h
	${PROJECT_SOURCE_DIR}/SRC/Peripheral/inc/ch32v20x_iwdg.h
	${PROJECT_SOURCE_DIR}/SRC/Peripheral/inc/ch32v20x_misc.h
	${PROJECT_SOURCE_DIR}/SRC/Peripheral/inc/ch32v20x_opa.h
	${PROJECT_SOURCE_DIR}/SRC/Peripheral/inc/ch32v20x_pwr.h
	${PROJECT_SOURCE_DIR}/SRC/Peripheral/inc/ch32v20x_rcc.h
	${PROJECT_SOURCE_DIR}/SRC/Peripheral/inc/ch32v20x_rtc.h
	${PROJECT_SOURCE_DIR}/SRC/Peripheral/inc/ch32v20x_spi.h
	${PROJECT_SOURCE_DIR}/SRC/Peripheral/inc/ch32v20x_tim.h
	${PROJECT_SOURCE_DIR}/SRC/Peripheral/inc/ch32v20x_usart.h
	${PROJECT_SOURCE_DIR}/SRC/Peripheral/inc/ch32v20x_usb.h
	${PROJECT_SOURCE_DIR}/SRC/Peripheral/inc/ch32v20x_wwdg.h
)
install(FILES ${peripheral_srcs} DESTINATION include/ch32v20x/peripheral)
install(FILES ${PROJECT_SOURCE_DIR}/SRC/Ld/Link.ld DESTINATION lib/ch32v20x)
