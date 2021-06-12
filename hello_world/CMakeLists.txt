# The main CMake version check happens in the root CMakeLists.txt; if that
# passed the current version is fine so just use it
cmake_minimum_required(VERSION "${CMAKE_VERSION}")

project(HelloWorld LANGUAGES CXX)

# Find external module CMakePublic
# Location to config file given by CMAKE_PREFIX_PATH
find_package(CMakePublic CONFIG REQUIRED)

# Used to deduce the directories for installation
include(GNUInstallDirs)

# Declares a one-source library
add_library(${PROJECT_NAME} STATIC "${CMAKE_CURRENT_SOURCE_DIR}/src/hello-world.cpp")

# Add library dependencies
target_link_libraries(${PROJECT_NAME} PUBLIC CMakePublic::CMakePublic)

# Declares that this library has one public header file
set_target_properties(${PROJECT_NAME}
    PROPERTIES
        PUBLIC_HEADER "${CMAKE_CURRENT_SOURCE_DIR}/include/hello-world.hpp"
)

# Tells CMake where header files the target depends on can be found
target_include_directories(${PROJECT_NAME}
    PUBLIC
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include/>
        $<INSTALL_INTERFACE:include>
)

# Installs the library and header files and associates it with an export target
# "${lib_name}-targets"
install(
    TARGETS ${PROJECT_NAME}
    EXPORT ${PROJECT_NAME}-targets
    PUBLIC_HEADER DESTINATION ${CMAKE_INSTALL_FULL_INCLUDEDIR}/helloworld
    ARCHIVE DESTINATION ${CMAKE_INSTALL_FULL_LIBDIR}/helloworld
    LIBRARY DESTINATION ${CMAKE_INSTALL_FULL_LIBDIR}/helloworld
    RUNTIME DESTINATION ${CMAKE_INSTALL_FULL_BINDIR}/helloworld

)

# Installs the export target
install(
    EXPORT ${PROJECT_NAME}-targets
    NAMESPACE ${PROJECT_NAME}::
    #FILE ${PROJECT_NAME}Config.cmake
    DESTINATION ${CMAKE_INSTALL_FULL_LIBDIR}/helloworld/cmake
)

include(CMakePackageConfigHelpers)

configure_package_config_file(
    ${CMAKE_CURRENT_SOURCE_DIR}/cmake/Config.cmake.in
    "${CMAKE_INSTALL_FULL_LIBDIR}/helloworld/cmake/helloworldConfig.cmake"
    INSTALL_DESTINATION ${CMAKE_INSTALL_FULL_LIBDIR}/helloworld/cmake
)

install(FILES
    "${CMAKE_INSTALL_FULL_LIBDIR}/helloworld/cmake/helloworldConfig.cmake"
    DESTINATION ${CMAKE_INSTALL_FULL_LIBDIR}/helloworld/cmake
)