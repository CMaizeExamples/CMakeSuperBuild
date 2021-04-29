cmake_minimum_required(VERSION 3.5.1)
project(CMaizeSuperbuild VERSION 1.0.0 LANGUAGES CXX)

# This is where we will install artifacts during the build stage
set(stage_directory "${CMAKE_BINARY_DIR}/stage/${CMAKE_INSTALL_PREFIX}")

# Tell compiler to not include debug flags
set(CMAKE_BUILD_TYPE_INIT "Release")

# Add cmake config location to paths to search
list(APPEND CMAKE_PREFIX_PATH ${stage_directory})

## External project ##
include(ExternalProject)

ExternalProject_Add(
    CMakePublic
    GIT_REPOSITORY "https://github.com/CMaizeExamples/CMakePublic"
    CMAKE_ARGS
        -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
        -DCMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER}
        -DCMAKE_INSTALL_PREFIX:PATH=${stage_directory}
    BUILD_ALWAYS ON
)

# Builds the main library and installs it to the staging directory
ExternalProject_Add(
    "${PROJECT_NAME}_core"
    SOURCE_DIR "${CMAKE_CURRENT_LIST_DIR}/hello_world"
    CMAKE_ARGS
        -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
        -DCMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER}
	    -DCMAKE_INSTALL_PREFIX:PATH=${stage_directory}
        -DCMAKE_PREFIX_PATH=${CMAKE_PREFIX_PATH}
    DEPENDS CMakePublic
    BUILD_ALWAYS ON
)

# Installing a superbuild just means copying the stage directory to its final
# location
INSTALL(DIRECTORY "${stage_directory}/" DESTINATION ${CMAKE_INSTALL_PREFIX})

# Add Testing
if(CMAKE_PROJECT_NAME STREQUAL PROJECT_NAME)
    include(CTest)
endif()

if(CMAKE_PROJECT_NAME STREQUAL PROJECT_NAME AND BUILD_TESTING)
    # add_subdirectory(tests)
    ExternalProject_Add(
        "${PROJECT_NAME}_test"
        SOURCE_DIR "${CMAKE_CURRENT_LIST_DIR}/tests"
        CMAKE_ARGS
            -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
            -DCMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER}
	        -DCMAKE_INSTALL_PREFIX:PATH=${stage_directory}
            -DCMAKE_PREFIX_PATH=${CMAKE_PREFIX_PATH}
        #DEPENDS "${PROJECT_NAME}_core"
        BUILD_ALWAYS ON
    )

    add_test(myTest "${stage_directory}/supertest")
endif()
