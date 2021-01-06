cmake_minimum_required(VERSION 3.5 FATAL_ERROR)

project(CMaizeSuperbuild_core LANGUAGES CXX)

add_library(${PROJECT_NAME} SHARED hello-world.cpp)

set_target_properties(${PROJECT_NAME} PROPERTIES PUBLIC_HEADER
        ${CMAKE_CURRENT_SOURCE_DIR}/Shared-Library/hello-world.hpp
        )

add_executable(hello-world hello-world.cpp)
