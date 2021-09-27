cmake_minimum_required(VERSION 3.5.1)
project(CMaizeSuperbuild VERSION 1.0.0 LANGUAGES CXX)

# This is where we will install artifacts during the build stage
set(stage_directory "${CMAKE_BINARY_DIR}/stage${CMAKE_INSTALL_PREFIX}")

# Tell compiler to not include debug flags
set(CMAKE_BUILD_TYPE_INIT "Release")
set(EXTERNAL_DIR "helloworld/external")

include(ExternalProject)
include(GNUInstallDirs)

# Add project with no dependencies from git
# TODO add find package line here to check if we should externally add project
ExternalProject_Add(
    CMakePublic
    GIT_REPOSITORY "https://github.com/CMaizeExamples/CMakePublic"
    CMAKE_ARGS
        -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
        -DCMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER}
        -DCMAKE_INSTALL_PREFIX:PATH=${stage_directory}
        # Switch install path to be inside .../helloworld
        -DCMAKE_INSTALL_INCLUDEDIR=${CMAKE_INSTALL_INCLUDEDIR}/${EXTERNAL_DIR}
        -DCMAKE_INSTALL_LIBDIR=${CMAKE_INSTALL_LIBDIR}/${EXTERNAL_DIR}
        -DCMAKE_INSTALL_BINDIR=${CMAKE_INSTALL_BINDIR}/${EXTERNAL_DIR}
    BUILD_ALWAYS ON
)

# Tells find_package where to look for config files
list(APPEND CMAKE_PREFIX_PATH ${stage_directory}) # Location of helloworld's config
list(APPEND CMAKE_PREFIX_PATH ${stage_directory}/${CMAKE_INSTALL_LIBDIR}/${EXTERNAL_DIR}) # Location of helloworld's dependencies configs

#External Project Add doesn't work well with ';' as a list seperator
string(REPLACE ";" "|" CMAKE_PREFIX_ALT_PATH "${CMAKE_PREFIX_PATH}")

# Builds the main library and installs it to the staging directory
# Allows CMakePublic to build first since it's a dependency
ExternalProject_Add(
    "${PROJECT_NAME}_core"
    SOURCE_DIR "${CMAKE_CURRENT_LIST_DIR}/hello_world"
    LIST_SEPARATOR |
    CMAKE_ARGS
        -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
        -DCMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER}
	    -DCMAKE_INSTALL_PREFIX:PATH=${stage_directory}
        -DCMAKE_PREFIX_PATH=${CMAKE_PREFIX_ALT_PATH}
    DEPENDS CMakePublic
    BUILD_ALWAYS ON
)

# Installing a superbuild just means copying the stage directory to its final
# location
INSTALL(DIRECTORY "${stage_directory}/" DESTINATION ${CMAKE_INSTALL_PREFIX})

# Building the tests is off by default and can be turned on
# by adding -DBUILD_TESTING=ON when running cmake
if(BUILD_TESTING)

    # Testing doesn't need to be installed so it's overwritten with an echo
    ExternalProject_Add(
        "${PROJECT_NAME}_test"
        SOURCE_DIR "${CMAKE_CURRENT_LIST_DIR}/tests"
        CMAKE_ARGS
            -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
            -DCMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER}
            -DCMAKE_PREFIX_PATH=${CMAKE_PREFIX_PATH}
        DEPENDS "${PROJECT_NAME}_core"
        INSTALL_COMMAND cmake -E echo "Skipping install step."
        TEST_COMMAND
        BUILD_ALWAYS ON
    )

    # Include directory that the test is built in
    ExternalProject_Get_Property(${PROJECT_NAME}_test binary_dir)
    file(APPEND ${CMAKE_BINARY_DIR}/CTestTestfile.cmake "SUBDIRS(${binary_dir})\n")
    
endif()
