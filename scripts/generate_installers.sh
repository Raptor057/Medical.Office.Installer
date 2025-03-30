#!/bin/bash
set -e

OUTPUT_DIR=installer_output
mkdir -p $OUTPUT_DIR

echo "⚙️ Ejecutando CMake para generar los scripts de inicio..."
cmake -S . -B build

echo "📦 Copiando scripts generados a $OUTPUT_DIR..."

cp build/start_linux.sh $OUTPUT_DIR/start_linux.sh || echo "❌ No se encontró: start_linux.sh"
cp build/start_osx.sh $OUTPUT_DIR/start_osx.sh || echo "❌ No se encontró: start_osx.sh"
cp build/start.ps1 $OUTPUT_DIR/start_windows.ps1 || echo "❌ No se encontró: start.ps1"

chmod +x $OUTPUT_DIR/start_linux.sh $OUTPUT_DIR/start_osx.sh 2>/dev/null || echo "⚠️ No se pudo asignar permisos (quizás no existen)"

echo "✅ Instaladores generados en: $OUTPUT_DIR"
ls -l $OUTPUT_DIR

cp build/MedicalOfficeLauncher.command installer_output/MedicalOfficeLauncher.command
chmod +x installer_output/MedicalOfficeLauncher.command

cp docker-compose.yml installer_output/docker-compose.yml
cp -r scripts installer_output/scripts
cp .env installer_output/
