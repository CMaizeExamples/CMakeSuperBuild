#pragma once
#include <iostream>
#include <string>

#ifdef USING_CMAKEPUBLIC_
#include <CMakePublic/cmake_public.hpp>
#endif

std::string say_hello();
std::string say_goodbye();