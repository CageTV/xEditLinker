# SSEEditLinker.dll (plugin name xedit_linker_sse) on alandtse's CommonLibSSE-NG (Skyrim 1.6.1170 and 1.7.x, SE and AE);
# included by E:/WorkSpace/ng-build/CMakeLists.txt (see ng_plugin there). The repository's own CMake (src/sse) builds against an older CommonLibSSE-NG
# fetched at configure time, whose Address Library reader cannot open the version 5 files of Skyrim 1.7.x.
file(READ "${CMAKE_CURRENT_LIST_DIR}/src/sse/CMakeLists.txt" _xel_cmakelists)
if(NOT _xel_cmakelists MATCHES "VERSION ([0-9]+)\.([0-9]+)\.([0-9]+)")
    message(FATAL_ERROR "xEditLinker ng.cmake: no VERSION x.y.z in src/sse/CMakeLists.txt")
endif()
set(_xel_ver "${CMAKE_MATCH_1}.${CMAKE_MATCH_2}.${CMAKE_MATCH_3}")
# Plugin.h comes from src/sse/cmake/Plugin.h.in, the same way the repository's own build makes it
set(_xel_saved_project_name "${PROJECT_NAME}")
set(PROJECT_NAME "xedit_linker_sse")
set(PROJECT_VERSION_MAJOR ${CMAKE_MATCH_1})
set(PROJECT_VERSION_MINOR ${CMAKE_MATCH_2})
set(PROJECT_VERSION_PATCH ${CMAKE_MATCH_3})
set(_xel_gen "${CMAKE_BINARY_DIR}/xeditlinker-gen")
configure_file("${CMAKE_CURRENT_LIST_DIR}/src/sse/cmake/Plugin.h.in" "${_xel_gen}/Plugin.h" @ONLY)
set(PROJECT_NAME "${_xel_saved_project_name}")

ng_plugin(TARGET xEditLinker NAME SSEEditLinker PLUGIN_NAME xedit_linker_sse VERSION ${_xel_ver} AUTHOR "Modding Forge" ROOT "${CMAKE_CURRENT_LIST_DIR}"
    SOURCES src/sse/main.cpp src/common/xedit_linker.cpp
    INCLUDES "${CMAKE_CURRENT_LIST_DIR}/src/sse" "${CMAKE_CURRENT_LIST_DIR}/src/common" "${_xel_gen}"
    PCH "${CMAKE_CURRENT_LIST_DIR}/src/sse/PCH.h"
    DEFINES XEL_NG)
