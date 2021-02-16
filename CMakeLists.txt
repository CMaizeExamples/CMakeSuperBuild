cmake_minimum_required(VERSION 3.5.1)
project(CMaizeSuperbuild VERSION 1.0.0)

include(ExternalProject)

include(GNUInstallDirs)

set(
        STAGING_DIRECTORY "${CMAKE_BINARY_DIR}/stage/"
)

ExternalProject_Add(
    "${PROJECT_NAME}_core"
    SOURCE_DIR "${CMAKE_CURRENT_LIST_DIR}/hello_world/src"
    CMAKE_ARGS -DCMAKE_CXX_COMPILER="${CMAKE_CXX_COMPILER}"
               -DCMAKE_CXX_STANDARD="${CMAKE_CXX_STANDARD}"
               -DCMAKE_INSTALL_PREFIX="${STAGING_DIRECTORY}"
    CMAKE_CACHE_ARGS -DCMAKE_CXX_FLAGS:STRING="${CMAKE_CXX_FLAGS}"
    BUILD_ALWAYS 1
    INSTALL_COMMAND ""
)