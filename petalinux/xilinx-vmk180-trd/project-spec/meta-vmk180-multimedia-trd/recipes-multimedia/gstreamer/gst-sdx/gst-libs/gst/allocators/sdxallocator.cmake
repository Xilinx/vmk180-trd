set(name "sdxallocator")

set(allocator_SOURCES gstsdxallocator.c)

add_library(gstreamer-${name}-${GST_API_VERSION} SHARED ${allocator_SOURCES})
add_library(gstreamer-${name}-${GST_API_VERSION}-static STATIC ${allocator_SOURCES})

set(allocator_HEADERS gstsdxallocator.h)

set_target_properties(gstreamer-${name}-${GST_API_VERSION}
  PROPERTIES OUTPUT_NAME gstsdxallocator-${GST_API_VERSION}
             SOVERSION ${GST_SO_VERSION}
             VERSION ${GST_LIB_VERSION}
)

set_target_properties(gstreamer-${name}-${GST_API_VERSION}-static
                      PROPERTIES OUTPUT_NAME gstreamer-${name}-${GST_API_VERSION})

include_directories(gstreamer-${name}-${GST_API_VERSION}
  ${GSTREAMER_VIDEO_INCLUDE_DIRS}
  ${GSTREAMER_ALLOCATORS_INCLUDE_DIRS}
  ${SDSLIB_INCLUDE_DIRS}
)

target_link_libraries(gstreamer-${name}-${GST_API_VERSION}
  ${GLIB_LIBRARIES}
  ${GSTREAMER_LIBRARIES}
  ${GSTREAMER_VIDEO_LIBRARIES}
  ${GSTREAMER_ALLOCATORS_LIBRARIES}
  ${SDSLIB_LIBRARIES}
)

install(TARGETS gstreamer-${name}-${GST_API_VERSION}
        EXPORT gstreamer-${name}-${GST_API_VERSION}
        DESTINATION ${GSTSDX_LIB_INSTALL_DIR})
install(TARGETS gstreamer-${name}-${GST_API_VERSION}-static
        EXPORT gstreamer-${name}-${GST_API_VERSION}-static
        DESTINATION ${GSTSDX_LIB_INSTALL_DIR})
foreach(header ${allocator_HEADERS})
  install(FILES ${header} DESTINATION ${GSTSDX_INSTALL_INCLUDEDIR}/gst/allocators)
endforeach()
