cmake_minimum_required(VERSION 3.15)
project(MedicalOfficeInstaller)

# Leer .env
file(READ "${PROJECT_SOURCE_DIR}/.env" ENV_CONTENTS)
string(REPLACE "\n" ";" ENV_LINES "${ENV_CONTENTS}")

foreach(line IN LISTS ENV_LINES)
    string(REGEX MATCH "^([A-Za-z_][A-Za-z0-9_]*)=(.*)$" _match "${line}")
    if(_match)
        string(REGEX REPLACE "^([A-Za-z_][A-Za-z0-9_]*)=(.*)$" "\\1" _key "${line}")
        string(REGEX REPLACE "^([A-Za-z_][A-Za-z0-9_]*)=(.*)$" "\\2" _value "${line}")
        set(${_key} "${_value}")
    endif()
endforeach()

message(STATUS "Username: ${GHCR_USERNAME}")

# # 🚀 Siempre generar los tres scripts sin importar la plataforma
# configure_file("${PROJECT_SOURCE_DIR}/scripts/start.sh.in" "${CMAKE_BINARY_DIR}/start_linux.sh" @ONLY)
# configure_file("${PROJECT_SOURCE_DIR}/scripts/start.sh.in" "${CMAKE_BINARY_DIR}/start_osx.sh" @ONLY)
# configure_file("${PROJECT_SOURCE_DIR}/scripts/start.ps1.in" "${CMAKE_BINARY_DIR}/start.ps1" @ONLY)

# Detectar y procesar todos los archivos .in en scripts/
file(GLOB SCRIPT_TEMPLATES "${CMAKE_SOURCE_DIR}/scripts/*.in")

foreach(TEMPLATE_FILE ${SCRIPT_TEMPLATES})
    get_filename_component(FILENAME ${TEMPLATE_FILE} NAME_WE)
    get_filename_component(EXTENSION ${TEMPLATE_FILE} EXT)
    
    if("${EXTENSION}" STREQUAL ".in")
        configure_file(${TEMPLATE_FILE} ${CMAKE_BINARY_DIR}/${FILENAME} @ONLY)
    endif()
endforeach()
