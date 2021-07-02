#
# FindSDSLib
# ----------
# Finds the SDSLib library
#
# This will will define the following variables::
#
# SDSLIB_FOUND - system has SDSLib
# SDSLIB_INCLUDE_DIRS - the SDSLib include directory
# SDSLIB_LIBRARIES - the SDSLib libraries
#

GetVarFromCmdlOrEnv (XILINX_SDX "")

get_filename_component (compiler ${CMAKE_C_COMPILER} NAME)
if (${compiler} STREQUAL "aarch64-linux-gnu-gcc")
    set (arch "aarch64-linux")
elseif (${compiler} STREQUAL "arm-linux-gnueabihf-gcc")
    set (arch "aarch32-linux")
else ()
    message(WARNING "No matching SDSLib libraries found for compiler '${compiler}'.")
endif ()

find_path (SDSLIB_INCLUDE_DIRS NAMES sds_lib.h
			       PATHS ${XILINX_SDX}
			       PATH_SUFFIXES target/${arch}/include)
find_library(SDSLIB_LIBRARIES NAMES sds_lib
			      PATHS ${XILINX_SDX}
			      PATH_SUFFIXES target/${arch}/lib)

set(SDSLIB_VERSION 1.0)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(SDSLib
                                  REQUIRED_VARS SDSLIB_LIBRARIES SDSLIB_INCLUDE_DIRS
                                  VERSION_VAR SDSLIB_VERSION)

mark_as_advanced(SDSLIB_INCLUDE_DIRS SDSLIB_LIBRARIES)
