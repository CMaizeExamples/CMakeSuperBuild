#----------------------------------------------------------------
# Generated CMake target import file for configuration "Debug".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "CMaizeSuperbuild_core::CMaizeSuperbuild_core" for configuration "Debug"
set_property(TARGET CMaizeSuperbuild_core::CMaizeSuperbuild_core APPEND PROPERTY IMPORTED_CONFIGURATIONS DEBUG)
set_target_properties(CMaizeSuperbuild_core::CMaizeSuperbuild_core PROPERTIES
  IMPORTED_LOCATION_DEBUG "/usr/local/libCMaizeSuperbuild_core.dylib"
  IMPORTED_SONAME_DEBUG "@rpath/libCMaizeSuperbuild_core.dylib"
  )

list(APPEND _IMPORT_CHECK_TARGETS CMaizeSuperbuild_core::CMaizeSuperbuild_core )
list(APPEND _IMPORT_CHECK_FILES_FOR_CMaizeSuperbuild_core::CMaizeSuperbuild_core "/usr/local/libCMaizeSuperbuild_core.dylib" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
