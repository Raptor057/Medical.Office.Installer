@echo off
powershell -ExecutionPolicy Bypass -File scripts\check_docker_windows.ps1
docker-compose up -d
