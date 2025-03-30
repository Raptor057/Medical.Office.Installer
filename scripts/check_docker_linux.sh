# scripts/check_docker_linux.sh
#!/bin/bash

if ! command -v docker &> /dev/null; then
  echo "Docker no está instalado. Instalando..."
  curl -fsSL https://get.docker.com | sh
else
  echo "Docker ya está instalado."
fi

if ! command -v docker-compose &> /dev/null; then
  echo "Docker Compose no está instalado. Instalando..."
  sudo curl -L "https://github.com/docker/compose/releases/download/v2.23.3/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose
else
  echo "Docker Compose ya está instalado."
fi
