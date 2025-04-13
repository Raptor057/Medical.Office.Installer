#!/bin/bash
set -e

#echo "✅ Usando variables de entorno desde .env.secure"
#cp .env.secure .env


echo "🚀 Buscando actualicacion de imagenes Docker Compose Pull"
docker compose pull

echo "🚀 Buscando actualicacion de imagenes Docker Compose Build"
docker compose build

echo "🚀 Limpiando contenedores y volúmenes Docker Compose"
docker compose down

echo "🚀 Levantando servicios con Docker Compose"
docker compose up -d

#echo "🧹 Limpiando archivo temporal .env"
#rm .env
