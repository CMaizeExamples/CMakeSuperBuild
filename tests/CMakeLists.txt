cmake_minimum_required(VERSION "${CMAKE_VERSION}")
project(SuperTest LANGUAGES CXX)

# Import the whole dependency tree
find_package(CMakePublic CONFIG REQUIRED)
find_package(HelloWorld CONFIG REQUIRED)

# Tell cmake to make this an executable
add_executable(${PROJECT_NAME} test.cpp)

# Link the hello-world library while compiling
target_link_libraries(${PROJECT_NAME} PUBLIC HelloWorld::HelloWorld)
