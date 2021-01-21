if(NOT TARGET depends::CMakePublic)
    FetchContent_Declare(
            depends-CMakePublic
            GIT_REPOSITORY https://github.com/CMaizeExamples/CMakePublic.git
            GIT_TAG        1.0.0
            GIT_SHALLOW    TRUE
    )
    FetchContent_GetProperties(depends-CMakePublic)
    if(NOT depends-CMakePublic_POPULATED)
        message(STATUS "Fetching CMakePublic sources")
        FetchContent_Populate(depends-CMakePublic)
        message(STATUS "Fetching CMakePublic sources - done")
    endif()
    add_library(depends::CMakePublic INTERFACE IMPORTED GLOBAL)
    target_link_libraries(depends::CMakePublic INTERFACE options::hello-world)
    target_include_directories(depends::CMakePublic INTERFACE ${depends-CMakePublic_SOURCE_DIR})
    set(depends-CMakePublic-source-dir ${depends-CMakePublic_SOURCE_DIR} CACHE INTERNAL "" FORCE)
    mark_as_advanced(depends-CMakePublic-source-dir)
endif()