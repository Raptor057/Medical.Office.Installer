#!/bin/bash
set -e

API_URL="http://192.168.100.24:8080"

#echo "✅ Usando variables de entorno desde .env.secure"
#cp .env.secure .env

echo "🔧 Construyendo imagen del frontend con NEXT_PUBLIC_API_URL=${API_URL}"
docker build \
  -t medicalofficefrontend \
  --build-arg NEXT_PUBLIC_API_URL=${API_URL} \
  -f ./Medical.Office.ReactWebClient/Dockerfile \
  ./Medical.Office.ReactWebClient

echo "🚀 Buscando actualizaciones de imágenes con Docker Compose Pull"
docker compose pull || true

echo "🚀 Reconstruyendo servicios (excepto frontend ya compilado manualmente)"
docker compose build || true

echo "🧹 Limpiando contenedores y volúmenes Docker Compose"
docker compose down

echo "🚀 Levantando servicios con Docker Compose"
docker compose up -d

#echo "🧹 Limpiando archivo temporal .env"
#rm .env
