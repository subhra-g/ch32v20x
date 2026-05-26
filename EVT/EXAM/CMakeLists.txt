cmake_minimum_required(VERSION 3.23)

# This is the manufacturer provided HAL.
add_subdirectory(SRC)
if(BUILD_EXAMPLES)
	# Build all examples.
endif()
