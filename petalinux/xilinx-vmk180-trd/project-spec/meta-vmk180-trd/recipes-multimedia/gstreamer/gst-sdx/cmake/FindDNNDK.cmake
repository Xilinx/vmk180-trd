#
# FindDNNDK
# ----------
# Finds the DNNDK libraries
#
# This will will define the following variables::
#
# DNNDK_FOUND - system has DNNDK
# DNNDK_INCLUDE_DIRS - the DNNDK include directory
# DNNDK_LIBRARIES - the DNNDK libraries
#

find_path (DNNDK_INCLUDE_DIRS NAMES dnndk.h)
find_library(DNNDK_DPUTILES NAMES dputils)
find_library(DNNDK_N2CUBE NAMES n2cube)
set (DNNDK_LIBRARIES ${DNNDK_DPUTILES} ${DNNDK_N2CUBE})

set(DNNDK_VERSION 1.0)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(DNNDK
				  REQUIRED_VARS DNNDK_LIBRARIES DNNDK_INCLUDE_DIRS
                                  VERSION_VAR DNNDK_VERSION)

mark_as_advanced(DNNDK_INCLUDE_DIRS DNNDK_LIBRARIES)
