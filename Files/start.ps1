# Hacer que el script falle si ocurre un error
$ErrorActionPreference = "Stop"

#echo "✅ Usando variables de entorno desde .env.secure"
#Copy-Item ".env.secure" -Destination ".env"

Write-Host "🚀 Buscando actualización de imágenes (Docker Compose Pull)" -ForegroundColor Cyan
docker compose pull

Write-Host "🚀 Construyendo servicios (Docker Compose Build)" -ForegroundColor Cyan
docker compose build

Write-Host "🚀 Limpiando contenedores y volúmenes (Docker Compose Down)" -ForegroundColor Yellow
docker compose down

Write-Host "🚀 Levantando servicios con Docker Compose (Up -d)" -ForegroundColor Green
docker compose up -d

#Write-Host "🧹 Limpiando archivo temporal .env" -ForegroundColor DarkGray
#Remove-Item ".env" -Force
