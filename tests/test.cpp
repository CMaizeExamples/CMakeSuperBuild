/*
 *  This file tests to see if hello-world runs without errors
 */

#include <iostream>
#include <helloworld/hello-world.hpp>

int main() {
    std::cout << say_hello() << std::endl;
    std::cout << say_goodbye() << std::endl;
    return 0;
}
