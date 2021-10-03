# The main CMake version check happens in the root CMakeLists.txt; if that
# passed the current version is fine so just use it
cmake_minimum_required(VERSION "${CMAKE_VERSION}")

project(HelloWorld LANGUAGES CXX)

# Find external module CMakePublic
# Location to config file given by CMAKE_PREFIX_PATH
find_package(CMakePublic CONFIG REQUIRED)

# Allows user to specify install dirs
include(GNUInstallDirs)

# Declares a one-source library
add_library(${PROJECT_NAME} STATIC "${CMAKE_CURRENT_SOURCE_DIR}/src/hello-world.cpp")

# Add library dependencies
target_link_libraries(${PROJECT_NAME} PUBLIC CMakePublic::CMakePublic)

# Declares that this library has one public header file
set_target_properties(${PROJECT_NAME}
    PROPERTIES
        PUBLIC_HEADER "${CMAKE_CURRENT_SOURCE_DIR}/include/helloworld/hello-world.hpp"
)

# Tells cmake that the header file can be found in hello_world/include during build
# and then install_prefix/include during install
target_include_directories(${PROJECT_NAME}
    PUBLIC
        $<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/include>
        $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>
)

# # Include header for any dependencies
# target_include_directories(CMakePublic::CMakePublic
#     INTERFACE
#         $<BUILD_INTERFACE:${CMAKE_INSTALL_FULL_INCLUDEDIR}/helloworld>
#         $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}/helloworld>
# )

# Installs the library and target
# "${lib_name}-targets"
install(
    TARGETS ${PROJECT_NAME}
    EXPORT ${PROJECT_NAME}-targets
    # Where to install the header file to
    PUBLIC_HEADER DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/helloworld
    # Where to install the static libraries (.a) to
    ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}/helloworld
    # Where to install the dynamic libraries (.dll/.so) to
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}/helloworld
    # Where to install the executalbe to
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}/helloworld
)

# Exports the HelloWorld target
# Tells CMake where to find files and build this project
install(
    EXPORT ${PROJECT_NAME}-targets
    NAMESPACE ${PROJECT_NAME}::
    DESTINATION ${CMAKE_INSTALL_LIBDIR}/helloworld/cmake
)

# Install header(s)
# install(FILES ${CMAKE_CURRENT_LIST_DIR}/include/hello-world.hpp
#   DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
# )

include(CMakePackageConfigHelpers)

# Grab config template and add extra logic to it
# Config template has info on dependencies
set(config_file_name "${PROJECT_BINARY_DIR}/helloworld-config.cmake")
configure_package_config_file(
    ${CMAKE_CURRENT_SOURCE_DIR}/cmake/Config.cmake.in
    "${config_file_name}"
    INSTALL_DESTINATION ${CMAKE_INSTALL_FULL_LIBDIR}/cmake/helloworld
)

# Export package config file
install(FILES
    "${config_file_name}"
    DESTINATION ${CMAKE_INSTALL_LIBDIR}/helloworld/cmake
)
