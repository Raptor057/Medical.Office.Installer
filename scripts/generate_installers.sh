#!/bin/bash
set -e

OUTPUT_DIR=installer_output

# Crear carpeta si no existe
mkdir -p $OUTPUT_DIR

echo "⚙️ Ejecutando CMake para generar los scripts de inicio..."
cmake -S $(pwd) -B build

echo "🔍 Archivos encontrados en build:"
find build

echo "📦 Copiando scripts generados a $OUTPUT_DIR..."

cp installer_output/start_linux.sh $OUTPUT_DIR/start_linux.sh 2>/dev/null || echo "❌ No se encontró: start_linux.sh"
cp installer_output/start_osx.sh $OUTPUT_DIR/start_osx.sh 2>/dev/null || echo "❌ No se encontró: start_osx.sh"
cp installer_output/start_windows.ps1 $OUTPUT_DIR/start_windows.ps1 2>/dev/null || echo "❌ No se encontró: start_windows.ps1"

chmod +x $OUTPUT_DIR/*.sh 2>/dev/null || echo "⚠️ No se pudo asignar permisos (quizás no existen)"

echo "✅ Instaladores generados en la carpeta: $OUTPUT_DIR"
ls -l $OUTPUT_DIR
