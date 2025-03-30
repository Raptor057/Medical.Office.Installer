#!/bin/bash
set -e

OUTPUT_DIR=installer_output
mkdir -p $OUTPUT_DIR

# 🔐 Desencriptar el archivo .env.gpg si existe
if [[ -f .env.gpg ]]; then
  echo "🔐 Detectado archivo .env.gpg, desencriptando..."
  gpg --quiet --batch --yes --decrypt --passphrase="$MY_ENV_PASSPHRASE" \
    --output .env .env.gpg || { echo "❌ Error al desencriptar .env.gpg"; exit 1; }
else
  echo "⚠️ Archivo .env.gpg no encontrado, usando .env existente (si hay)"
fi

echo "⚙️ Ejecutando CMake para generar los scripts de inicio..."
cmake -S . -B build

echo "📦 Copiando scripts generados a $OUTPUT_DIR..."

cp build/start_linux.sh $OUTPUT_DIR/start_linux.sh || echo "❌ No se encontró: start_linux.sh"
cp build/start_osx.sh $OUTPUT_DIR/start_osx.sh || echo "❌ No se encontró: start_osx.sh"
cp build/start.ps1 $OUTPUT_DIR/start_windows.ps1 || echo "❌ No se encontró: start.ps1"

chmod +x $OUTPUT_DIR/start_linux.sh $OUTPUT_DIR/start_osx.sh 2>/dev/null || echo "⚠️ No se pudo asignar permisos (quizás no existen)"

echo "✅ Instaladores generados en: $OUTPUT_DIR"
ls -l $OUTPUT_DIR

cp build/MedicalOfficeLauncher.command $OUTPUT_DIR/MedicalOfficeLauncher.command
chmod +x $OUTPUT_DIR/MedicalOfficeLauncher.command

cp docker-compose.yml $OUTPUT_DIR/docker-compose.yml
cp -r scripts $OUTPUT_DIR/scripts
cp .env $OUTPUT_DIR/