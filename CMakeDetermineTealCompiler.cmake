# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file Copyright.txt or https://cmake.org/licensing for details.


# determine the compiler to use for Teal programs
# NOTE, a generator may set CMAKE_Teal_COMPILER before
# loading this file to force a compiler.

if(NOT CMAKE_Teal_COMPILER)
    # prefer the environment variable CC
    if(NOT $ENV{TEAL_COMPILER} STREQUAL "")
        get_filename_component(CMAKE_Teal_COMPILER_INIT $ENV{TEAL_COMPILER} PROGRAM PROGRAM_ARGS CMAKE_Teal_FLAGS_ENV_INIT)
        if(CMAKE_Teal_FLAGS_ENV_INIT)
            set(CMAKE_Teal_COMPILER_ARG1 "${CMAKE_Teal_FLAGS_ENV_INIT}" CACHE STRING "Arguments to Teal compiler")
        endif()
        if(NOT EXISTS ${CMAKE_Teal_COMPILER_INIT})
            message(SEND_ERROR "Could not find compiler set in environment variable TEAL_COMPILER:\n$ENV{TEAL_COMPILER}.")
        endif()
    endif()

    set(Teal_BIN_PATH
            $ENV{TEAL_HOME}/bin
            /usr/bin
            /usr/local/bin
            /opt/homebrew/bin
            )
    # if no compiler has been specified yet, then look for one
    if(CMAKE_Teal_COMPILER_INIT)
        set(CMAKE_Teal_COMPILER ${CMAKE_Teal_COMPILER_INIT} CACHE PATH "Teal Compiler")
    else()
        find_program(CMAKE_Teal_COMPILER
                NAMES tl
                PATHS ${Teal_BIN_PATH}
                )
    endif()
endif()
mark_as_advanced(CMAKE_Teal_COMPILER)

# configure variables set in this file for fast reload later on
configure_file(${CMAKE_CURRENT_LIST_DIR}/CMakeTealCompiler.cmake.in
        ${CMAKE_CURRENT_BINARY_DIR}/CMakeFiles/3.24.2/CMakeTealCompiler.cmake @ONLY)
set(CMAKE_Teal_COMPILER_ENV_VAR "TEAL_COMPILER")