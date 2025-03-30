#!/bin/bash
if ! command -v docker &> /dev/null; then
  echo "Docker no está instalado. Instalando..."
  curl -fsSL https://get.docker.com | sh
else
  echo "Docker ya está instalado."
fi
