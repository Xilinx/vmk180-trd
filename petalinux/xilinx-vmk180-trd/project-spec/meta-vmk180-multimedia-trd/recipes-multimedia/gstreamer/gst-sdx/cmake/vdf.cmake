# Compiler defines/flags
set (VDF_CDEFS_PFM PLATFORM_ZCU102 CACHE INTERNAL "")
set (VDF_CDEFS_REL __FORTIFY_SOURCE=2 CACHE INTERNAL "")
set (VDF_CFLAGS -Wall -fstack-protector-strong CACHE INTERNAL "")
set (VDF_CFLAGS_DBG -O0 -ggdb3 CACHE INTERNAL "")
set (VDF_CFLAGS_REL -O3 CACHE INTERNAL "")
set (VDF_CFLAGS_RELDBG -O3 -ggdb3 CACHE INTERNAL "")

# Helper macro
macro (GetVarFromCmdlOrEnv var dflt)
	if (NOT DEFINED ${var})
		if (NOT DEFINED ENV{${var}})
			message (WARNING "'${var}' not specified using '${dflt}'")
			set (${var} ${dflt})
		else()
			set (${var} $ENV{${var}})
		endif()
	endif()
endmacro()

# Sets variables:
#   <acc>_sds_LIBRARIES
#   <acc>_sds_INCLUDE_DIRS
function (find_accelerator acc)
	find_path (${acc}_sds_INCLUDE_DIRS NAMES ${acc}_sds.h
		PATHS ${SAMPLESDIR}
		PATH_SUFFIXES "include"
		NO_DEFAULT_PATH
		NO_CMAKE_FIND_ROOT_PATH
	)

	find_library(${acc}_sds_LIBRARIES NAMES ${SDSHW_LIBRARIES}
		PATHS ${SAMPLESDIR}
		PATH_SUFFIXES "lib"
		NO_DEFAULT_PATH
		NO_CMAKE_FIND_ROOT_PATH
	)

	set (${acc}_sds_INCLUDE_DIRS ${${acc}_sds_INCLUDE_DIRS} PARENT_SCOPE)
	set (${acc}_sds_LIBRARIES ${${acc}_sds_LIBRARIES} PARENT_SCOPE)
endfunction()
