#!/bin/bash
if ! command -v docker &> /dev/null; then
  echo "Docker no está instalado. Descargando Docker Desktop..."
  open https://www.docker.com/products/docker-desktop/
  exit 1
else
  echo "Docker ya está instalado."
fi
