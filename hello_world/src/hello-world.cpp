#include "hello-world.hpp"

#ifdef USING_CMAKEPUBLIC_

std::string say_goodbye() {
    int val = cmake_public::call_cmake_public();
    std::string str = std::to_string(val);
    return (std::string("Goodbye from CMake Public! ") + str);
}

#else

std::string say_goodbye() {
    return (std::string("Goodbye from CMake superbuild!"));
}

#endif

std::string say_hello() { return std::string("Hello, CMake superbuild!"); }

int main() {
    std::cout << say_hello() << std::endl;
    std::cout << say_goodbye() << std::endl;
}