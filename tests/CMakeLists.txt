cmake_minimum_required(VERSION "${CMAKE_VERSION}")
project(SuperTest LANGUAGES CXX)

# Import the whole dependency tree
#find_package(CMakePublic CONFIG REQUIRED)
find_package(HelloWorld CONFIG REQUIRED)

# Tell cmake to make this an executable
add_executable(${PROJECT_NAME} test.cpp)

# Link the hello-world library while compiling
target_link_libraries(${PROJECT_NAME} PUBLIC HelloWorld::HelloWorld)

# Add testing support
include(CTest)

# Add test to this build directory and link to it from the superbuild
add_test(NewTest ${PROJECT_NAME})

# Edit test to look at `stdout` rather then main's return value
set_tests_properties(NewTest
    PROPERTIES
    PASS_REGULAR_EXPRESSION "Hello, CMake superbuild!\nGoodbye from CMake Public! 3\n"
)