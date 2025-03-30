cmake_minimum_required(VERSION 3.15)
project(MedicalOfficeInstaller)

# Leer .env
file(READ "${CMAKE_CURRENT_SOURCE_DIR}/.env" ENV_CONTENTS)
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

# Usar rutas absolutas al copiar
set(OUTPUT_DIR "${CMAKE_CURRENT_SOURCE_DIR}/installer_output")
file(MAKE_DIRECTORY "${OUTPUT_DIR}")

configure_file(${CMAKE_SOURCE_DIR}/scripts/start.sh.in ${OUTPUT_DIR}/start_linux.sh @ONLY)
configure_file(${CMAKE_SOURCE_DIR}/scripts/start.sh.in ${OUTPUT_DIR}/start_osx.sh @ONLY)
configure_file(${CMAKE_SOURCE_DIR}/scripts/start.ps1.in ${OUTPUT_DIR}/start_windows.ps1 @ONLY)
