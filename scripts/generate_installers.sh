#!/bin/bash
set -e

OUTPUT_DIR=installer_output

# Crear carpeta si no existe
mkdir -p $OUTPUT_DIR

echo "⚙️ Ejecutando CMake para generar los scripts de inicio..."
cmake -S . -B build

# Asegúrate que tengan permisos de ejecución
chmod +x $OUTPUT_DIR/start_linux.sh $OUTPUT_DIR/start_osx.sh 2>/dev/null || true

echo "✅ Instaladores generados en la carpeta: $OUTPUT_DIR"
ls -l $OUTPUT_DIR
