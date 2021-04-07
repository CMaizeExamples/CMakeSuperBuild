# The main CMake version check happens in the root CMakeLists.txt; if that
# passed the current version is fine so just use it
cmake_minimum_required(VERSION "${CMAKE_VERSION}")

project(HelloWorld LANGUAGES CXX)

# Find external module CMakePublic
# Location to config file given by CMAKE_PREFIX_PATH
find_package(CMakePublic CONFIG REQUIRED)

# Used to deduce the directories for installation
include(GNUInstallDirs)

# Library names should be filesystem friendly name (so not case-sensitive)
set(lib_name hello_world)

# Declares a one-source library
add_library(${lib_name} "${CMAKE_CURRENT_SOURCE_DIR}/src/hello-world.cpp")

# Add library dependencies
target_link_libraries(${lib_name} PUBLIC CMakePublic::CMakePublic)

# Declares that this library has one public header file
set_target_properties(
    ${lib_name} PROPERTIES PUBLIC_HEADER
    "${CMAKE_CURRENT_SOURCE_DIR}/include/hello-world.hpp"
)

# Tells CMake where header files the target depends on can be found
target_include_directories(
    ${lib_name} PUBLIC
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include/>
    $<INSTALL_INTERFACE:include>
)

# Installs the library and header files and associates it with an export target
# "${lib_name}-targets"
install(
    TARGETS ${lib_name}
    EXPORT "${lib_name}-targets"
    PUBLIC_HEADER DESTINATION ${CMAKE_INSTALL_FULL_INCLUDEDIR}
    ARCHIVE DESTINATION ${CMAKE_INSTALL_FULL_LIBDIR}
    LIBRARY DESTINATION ${CMAKE_INSTALL_FULL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_FULL_BINDIR}
)

# Installs the export target
install(
    EXPORT ${lib_name}-targets
    NAMESPACE ${lib_name}::
    FILE ${lib_name}Config.cmake
    DESTINATION ${CMAKE_INSTALL_FULL_LIBDIR}/cmake
)
