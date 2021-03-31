cmake_minimum_required(VERSION 3.5.1)

# This is where we will install artifacts during the build stage
# TODO: change stage_dir to CMAKE_INSTALL_DIR
set(stage_directory "${CMAKE_BINARY_DIR}/stage")

set(CMAKE_BUILD_TYPE_INIT "Release")

project(CMaizeSuperbuild VERSION 1.0.0 LANGUAGES CXX)

# Builds the main library and installs it to the staging directory
# ExternalProject_Add(
#     "${PROJECT_NAME}_core"
#     SOURCE_DIR "${CMAKE_CURRENT_LIST_DIR}/hello_world"
#     CMAKE_ARGS -DCMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER}
# 	       -DCMAKE_INSTALL_PREFIX=${stage_directory}
#     BUILD_ALWAYS 1
# )

## External project ##

include(ExternalProject) # For ExternalProject_Add command

ExternalProject_Add(CMakePublic
    URL "https://github.com/CMaizeExamples/CMakePublic/archive/refs/heads/master.zip"
    CMAKE_ARGS
        -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
        -DCMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER}
        -DCMAKE_INSTALL_PREFIX:PATH=${stage_directory}
)

# Installing a superbuild just means copying the stage directory to its final
# location
INSTALL(DIRECTORY "${stage_directory}/" DESTINATION ${CMAKE_INSTALL_PREFIX})
