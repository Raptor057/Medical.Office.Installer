cmake_minimum_required(VERSION 3.15)
project(MedicalOfficeInstaller)

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

# Generar los tres scripts
configure_file(${CMAKE_CURRENT_SOURCE_DIR}/scripts/start.sh.in ${CMAKE_BINARY_DIR}/start_linux.sh @ONLY)
configure_file(${CMAKE_CURRENT_SOURCE_DIR}/scripts/start.sh.in ${CMAKE_BINARY_DIR}/start_osx.sh @ONLY)
configure_file(${CMAKE_CURRENT_SOURCE_DIR}/scripts/start.ps1.in ${CMAKE_BINARY_DIR}/start.ps1 @ONLY)

configure_file(${CMAKE_SOURCE_DIR}/scripts/mac/MedicalOfficeLauncher.command.in ${CMAKE_BINARY_DIR}/MedicalOfficeLauncher.command @ONLY)
