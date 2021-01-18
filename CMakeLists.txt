cmake_minimum_required(VERSION 3.0 FATAL_ERROR)

project(CMaizeSuperbuild)

include(CTest)
include(ExternalProject)
include(FetchContent)

set_property(DIRECTORY PROPERTY EP_BASE ${CMAKE_CURRENT_BINARY_DIR}/subprojects)

set(STAGED_INSTALL_PREFIX ${CMAKE_BINARY_DIR}/stage)
message(STATUS "${PROJECT_NAME} staged install: ${STAGED_INSTALL_PREFIX}")


include_directories(${CMAKE_CURRENT_SOURCE_DIR}/src)
include_directories(${EXTERNAL_INSTALL_LOCATION}/Shared-Library)

ExternalProject_Add(
    "${PROJECT_NAME}_core"
    SOURCE_DIR "${CMAKE_CURRENT_LIST_DIR}/src"
    CMAKE_ARGS -DCMAKE_CXX_COMPILER="${CMAKE_CXX_COMPILER}"
               -DCMAKE_CXX_STANDARD="${CMAKE_CXX_STANDARD}"
               -DCMAKE_CXX_EXTENSIONS="${CMAKE_CXX_EXTENSIONS}"
               -DCMAKE_CXX_STANDARD_REQUIRED="${CMAKE_CXX_STANDARD_REQUIRED}"
    CMAKE_CACHE_ARGS -DCMAKE_CXX_FLAGS:STRING="${CMAKE_CXX_FLAGS}"
    BUILD_ALWAYS 1
    INSTALL_COMMAND ""
)

ExternalProject_Add(CMakePublic
        GIT_REPOSITORY https://github.com/CMaizeExamples/CMakePublic
        CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=${EXTERNAL_INSTALL_LOCATION}
        )

ExternalProject_Add_StepDependencies(CMakePublic configure CMaizeSuperbuild_core)