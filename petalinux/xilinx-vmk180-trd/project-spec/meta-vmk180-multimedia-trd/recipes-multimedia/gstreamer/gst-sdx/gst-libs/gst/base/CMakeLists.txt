set(name "sdxbase")

set(base_SOURCES gstsdxbase.c)

add_library(gstreamer-${name}-${GST_API_VERSION} SHARED ${base_SOURCES})
add_library(gstreamer-${name}-${GST_API_VERSION}-static STATIC ${base_SOURCES})

set(base_HEADERS gstsdxbase.h)

set_target_properties(gstreamer-${name}-${GST_API_VERSION}
  PROPERTIES OUTPUT_NAME gstsdxbase-${GST_API_VERSION}
             SOVERSION ${GST_SO_VERSION}
             VERSION ${GST_LIB_VERSION}
)
set_target_properties(gstreamer-${name}-${GST_API_VERSION}-static
                      PROPERTIES OUTPUT_NAME gstreamer-${name}-${GST_API_VERSION})

include_directories(gstreamer-${name}-${GST_API_VERSION}
  ${GSTREAMER_VIDEO_INCLUDE_DIRS}
  ${GSTREAMER_ALLOCATORS_INCLUDE_DIRS}
  ${GSTSDX_LIBRARY_INCLUDEDIR}
  $<$<BOOL:${SDSOC_MODE}>:${SDSLIB_INCLUDE_DIRS}>
  ${XRTUTILS_LIBRARY_INCLUDEDIR}
)
target_link_libraries(gstreamer-${name}-${GST_API_VERSION}
  ${GLIB_LIBRARIES}
  ${GSTREAMER_LIBRARIES}
  ${GSTREAMER_VIDEO_LIBRARIES}
  ${GSTREAMER_ALLOCATORS_LIBRARIES}
  $<$<BOOL:${SDSOC_MODE}>:gstreamer-sdxallocator-${GST_API_VERSION}>
  $<$<NOT:$<BOOL:${SDSOC_MODE}>>:gstreamer-xclallocator-${GST_API_VERSION}>
)

target_compile_definitions(gstreamer-${name}-${GST_API_VERSION}
  PRIVATE $<$<BOOL:${SDSOC_MODE}>:SDSOC_ENV>
)

install(TARGETS gstreamer-${name}-${GST_API_VERSION}
        EXPORT gstreamer-${name}-${GST_API_VERSION}
        DESTINATION ${GSTSDX_LIB_INSTALL_DIR})
install(TARGETS gstreamer-${name}-${GST_API_VERSION}-static
        EXPORT gstreamer-${name}-${GST_API_VERSION}-static
        DESTINATION ${GSTSDX_LIB_INSTALL_DIR})
foreach(header ${base_HEADERS})
  install(FILES ${header} DESTINATION ${GSTSDX_INSTALL_INCLUDEDIR}/gst/base)
endforeach()
