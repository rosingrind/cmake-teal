# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file Copyright.txt or https://cmake.org/licensing for details.


# This should be included before the _INIT variables are
# used to initialize the cache.  Since the rule variables
# have if blocks on them, users can still define them here.
# But, it should still be after the platform file so changes can
# be made to those values.

if(CMAKE_USER_MAKE_RULES_OVERRIDE)
    # Save the full path of the file so try_compile can use it.
    include(${CMAKE_USER_MAKE_RULES_OVERRIDE} RESULT_VARIABLE _override)
    set(CMAKE_USER_MAKE_RULES_OVERRIDE "${_override}")
endif()

if(CMAKE_USER_MAKE_RULES_OVERRIDE_Teal)
    # Save the full path of the file so try_compile can use it.
    include(${CMAKE_USER_MAKE_RULES_OVERRIDE_Teal} RESULT_VARIABLE _override)
    set(CMAKE_USER_MAKE_RULES_OVERRIDE_Teal "${_override}")
endif()

# this is a place holder if teal needed flags for tealc they would go here.
if(NOT CMAKE_Teal_CREATE_STATIC_LIBRARY)
    #  if(WIN32)
    #    set(class_files_mask "*.class")
    #  else()
    set(class_files_mask ".")
    #  endif()

    set(CMAKE_Teal_CREATE_STATIC_LIBRARY
            "<CMAKE_Teal_ARCHIVE> -cf <TARGET> -C <OBJECT_DIR> ${class_files_mask}")
    # "${class_files_mask}" should really be "<OBJECTS>" but compiling a *.teal
    # file can create more than one *.class file...
endif()

# compile a Teal file into an object file
if(NOT CMAKE_Teal_COMPILE_OBJECT)
    set(CMAKE_Teal_COMPILE_OBJECT
            "<CMAKE_Teal_COMPILER> <FLAGS> <SOURCE> -d <OBJECT_DIR>")
endif()

# set teal include flag option and the separator for multiple include paths
set(CMAKE_INCLUDE_FLAG_Teal "-classpath ")
if(WIN32 AND NOT CYGWIN)
    set(CMAKE_INCLUDE_FLAG_SEP_Teal ";")
else()
    set(CMAKE_INCLUDE_FLAG_SEP_Teal ":")
endif()