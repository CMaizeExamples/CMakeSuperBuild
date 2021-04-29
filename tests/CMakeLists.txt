cmake_minimum_required(VERSION "${CMAKE_VERSION}")

project(SuperTest LANGUAGES CXX)

#find_package(HelloWorld CONFIG REQUIRED)

add_executable(${PROJECT_NAME} test.cxx)
#target_link_libraries(${PROJECT_NAME} PUBLIC HelloWorld::HelloWorld)

install(
    TARGETS ${PROJECT_NAME}
    EXPORT ${PROJECT_NAME}-targets
    RUNTIME DESTINATION ${CMAKE_INSTALL_PREFIX}/Debug
)

#enable_testing()

#add_test(myTest ${PROJECT_NAME})