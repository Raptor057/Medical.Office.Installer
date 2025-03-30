# scripts/check_docker_macos.sh
#!/bin/bash

if ! command -v docker &> /dev/null; then
  echo "Docker no está instalado. Abriendo página de descarga..."
  open https://www.docker.com/products/docker-desktop/
  exit 1
else
  echo "Docker ya está instalado."
fi

if ! command -v docker-compose &> /dev/null; then
  echo "Docker Compose no está instalado. Abriendo página de descarga..."
  open https://docs.docker.com/compose/install/
  exit 1
else
  echo "Docker Compose ya está instalado."
fi