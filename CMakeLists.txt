cmake_minimum_required(VERSION 3.5.1)
project(CMaizeSuperbuild VERSION 1.0.1 LANGUAGES CXX)

include(ExternalProject) # For ExternalProject_Add command

# This is where we will install artifacts during the build stage
set(stage_directory "${CMAKE_BINARY_DIR}/stage/${CMAKE_INSTALL_PREFIX}")

# Builds the main library and installs it to the staging directory
ExternalProject_Add(
    "${PROJECT_NAME}_core"
    SOURCE_DIR "${CMAKE_CURRENT_LIST_DIR}/hello_world"
    CMAKE_ARGS -DCMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER}
	       -DCMAKE_INSTALL_PREFIX=${stage_directory}
    BUILD_ALWAYS 1
)
# Builds the CMakePublic library using the external project add function, and installs to the staging directory
ExternalProject_Add(CMakePublic
		PREFIX ${CMAKE_CURRENT_BINARY_DIR}/CMakePublic
		GIT_REPOSITORY https://github.com/CMaizeExamples/CMakePublic
		CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=${stage_directory}
		)


# Installing a superbuild just means copying the stage directory to its final
# location
INSTALL(DIRECTORY "${stage_directory}/" DESTINATION ${CMAKE_INSTALL_PREFIX})
