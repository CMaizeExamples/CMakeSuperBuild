#include <hello-world.hpp>
#include <external/cmakepublic/cmake_public.hpp>

std::string say_goodbye() {
    int val = call_cmake_public();
    std::string str = std::to_string(val);
    return (std::string("Goodbye from CMake Public! ") + str);
}

std::string say_hello() { return std::string("Hello, CMake superbuild!"); }
