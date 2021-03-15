#include "hello-world.hpp"
#include "cmake_public.hpp"

std::string say_hello() { return std::string("Hello, CMake superbuild!"); }

int call_cmake_public();

std::int test_cmake_public() {return call_cmake_public();}