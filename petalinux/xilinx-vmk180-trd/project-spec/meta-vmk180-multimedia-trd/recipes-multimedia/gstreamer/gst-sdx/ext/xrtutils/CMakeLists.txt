cmake_minimum_required (VERSION 2.8.12)

set (name "xrtutils")

project (${name} CXX)

# Source files
add_library (xrtutils SHARED
  xcl2.cpp
  xrtutils.cpp
)

# Dependencies
find_package (OpenCL REQUIRED)

target_include_directories (${name} PUBLIC
  ${OpenCL_INCLUDE_DIRS}
  ${XRT_INCLUDE_DIRS}
)

target_link_libraries (${name} PRIVATE
  ${OpenCL_LIBRARIES}
)

install (TARGETS ${name} EXPORT ${name} DESTINATION lib)
install (FILES xcl2.hpp DESTINATION include)
install (FILES xrt_mapping_buffer.h DESTINATION include)
install (FILES xrtutils.hpp DESTINATION include)
