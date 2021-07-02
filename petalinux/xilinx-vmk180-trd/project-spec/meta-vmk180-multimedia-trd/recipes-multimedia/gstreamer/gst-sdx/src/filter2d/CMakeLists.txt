if (SDSOC_MODE)
  find_accelerator("filter2d")
endif ()

add_library (gstsdxfilter2d SHARED
  gstsdxfilter2d.cpp
  filter2d_cv.cpp
  $<$<NOT:$<BOOL:${SDSOC_MODE}>>:xclfilter2d.cpp>
)

find_package (OpenCV REQUIRED core imgproc)
find_package (XRT REQUIRED)

include_directories (gstsdxfilter2d
  ${OpenCV_INCLUDE_DIRS}
  $<$<BOOL:${SDSOC_MODE}>:${filter2d_sds_INCLUDE_DIRS}>
  ${GSTSDX_LIBRARY_INCLUDEDIR}
  $<$<NOT:$<BOOL:${SDSOC_MODE}>>:${XRTUTILS_LIBRARY_INCLUDEDIR}>
  $<$<NOT:$<BOOL:${SDSOC_MODE}>>:${XCL_INCLUDE_DIRS}>
)

target_link_libraries (gstsdxfilter2d
  $<$<BOOL:${SDSOC_MODE}>:${filter2d_sds_LIBRARIES}>
  $<$<NOT:$<BOOL:${XRT_MODE}>>:${XCL_LIBRARIES}>
  ${OpenCV_LIBS}
  ${GLIB_LIBRARIES}
  ${GSTREAMER_LIBRARIES}
  gstreamer-sdxbase-${GST_API_VERSION}
)

target_compile_definitions (gstsdxfilter2d
  PRIVATE $<$<BOOL:${SDSOC_MODE}>:SDSOC_ENV>
)

install (TARGETS gstsdxfilter2d DESTINATION ${GSTSDX_PLUGIN_INSTALL_DIR})
