# CMake Superbuild Model

This page will further explain the purpose of our project architecture and structure.

## Project Architecture 
---

### Style : Seperate Dependency &#8594; Seperate Install Area
---
We have chosen to implement a seperate dependency seperate install area because this model will be longer lasting for years to come. In addition, this architecture will allow us to structure dependencies in such a way we are then able to automatically fetch, retrieve, and build dependencies using the superbuild model.

### Superbuild Model Criteria
--- 
In order for the our project to be considered a superbuild we must atleast satisfy the following conditions...
1. )  Atleast one dependency must require no others.
2. )  For other dependencies, then use find_package() to locate their dependencies.
2.5 ) Then set the CMAKE_PREFIX_PATH variable to the respective install area, seperate from all other currently existing dependency install areas.
3. ) A step dependency is added to ensure the configure step only occurs after all other required dependencies have been install correctly. 

Note: The CMAKE_PREFIX_PATH variable given to later dependencies, may require a full list of all previous install directories instead of one single directory to install dependencies to.


### CMAKELIST.txt Model Structure

This will be the main structure of our superbuild model where each external project add can be reused at later times to continue building the project. 


```cmake
cmake_minimum_required(VERSION 3.0)
project(CMaizeSuperbuild)
include(ExternalProject)

set(installDir ${CMAKE_CURRENT_BINARY_DIR}/install)

ExternalProject_Add( rootDependency 
...
INSTALL_DIR ${installDir}
CMAKE_ARGS -DCMAKE_INSTALL_PREFIX: PATH = <INSTALL_DIR>
)

ExternalProject_Add( givenDependency2 
...
INSTALL_DIR ${installDir} 
CMAKE_ARGS -DCMAKE_INSTALL_PREFIX: PATH = <INSTALL_DIR>
           -DCMAKE_PREFIX_PATH: PATH = <INSTALL_DIR>
)

ExternalProject_Add( givenDependencyN
...
INSTALL_DIR ${installDir} 
CONFIGURE_COMMAND <SOURCE_DIR>/configure --prefix <INSTALL_DIR>
)
```

### Adding Libaries Structure

This will be the main structure of our superbuild model where each external project controls it's own libraries through out the project. Each dependency controlling it's own respective library allows the superbuild to put more focus to bringing external projects together. The superbuild will write its own specific details of the project(s) if needed. However, this worst-case scenario takes away from the power of the superbuild.

#### Model Structure

```cmake
cmake_minimum_required(VERSION 3.0)
project(CMaizeSuperbuild)
include(ExternalProject)

ExternalProject_Add_Step( CMaizeSuperbuild Package
...
COMMAND ${CMAKE_COMMAND} --build <BINARY_DIR> --targetPack 
DEPENDEES build
ALWAYS YES
EXCLUDE_FROM_MAIN YES
)

ExternalProject_Add_StepTargets( CMaizeSuperbuild Package)

```

