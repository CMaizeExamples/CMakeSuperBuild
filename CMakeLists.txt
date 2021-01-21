cmake_minimum_required(VERSION 3.13.4 FATAL_ERROR)
project(CMaizeSuperbuild VERSION 1.0.0)

include(CTest)
include(ExternalProject)
include(GNUInstallDirs)

#Superbuild Depends Module imported from MIT to aid functions in the superbuild model
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/cmake/Modules")
include(SuperBuildDepends)
superbuild_depend(CMakePublic)

set_property(DIRECTORY PROPERTY EP_BASE ${CMAKE_CURRENT_BINARY_DIR}/subprojects)

set(STAGED_INSTALL_PREFIX ${CMAKE_BINARY_DIR}/stage)
message(STATUS "${PROJECT_NAME} staged install: ${STAGED_INSTALL_PREFIX}")


include_directories(${CMAKE_CURRENT_SOURCE_DIR}/src)
include_directories(${EXTERNAL_INSTALL_LOCATION}/Shared-Library)

add_library(hello-world)
set_target_properties(hello-world PROPERTIES CXX_EXTENSIONS NO)
target_sources(hello-world
        PRIVATE
        ${CMAKE_CURRENT_SOURCE_DIR}/Shared-Library/hello-world.hpp
        ${CMAKE_CURRENT_SOURCE_DIR}/src/hello-world.cpp
        )
target_include_directories(hello-world
        PUBLIC
        ${CMAKE_CURRENT_SOURCE_DIR}/Shared-Library
        ${CMAKE_CURRENT_BINARY_DIR}/Shared-Library
        PRIVATE
        ${CMAKE_CURRENT_SOURCE_DIR}/src
        )
target_link_libraries(hello-world
        PUBLIC
        options::CMakePublic
        )

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

#Note: (1.21.2021) This option may not be needed later
ExternalProject_Add(CMakePublic
        GIT_REPOSITORY https://github.com/CMaizeExamples/CMakePublic
        CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=${EXTERNAL_INSTALL_LOCATION}
        )