#!/bin/bash

set -e

OUTPUT_DIR=installer_output

# Crear carpeta de salida si no existe
mkdir -p $OUTPUT_DIR

# Correr CMake para generar los scripts personalizados
echo "⚙️ Ejecutando CMake para generar los scripts de inicio..."
cmake -S . -B build

# Copiar los scripts generados a la carpeta de salida
echo "📦 Copiando scripts a $OUTPUT_DIR..."
cp build/start_osx.sh $OUTPUT_DIR/start_osx.sh
cp build/start_linux.sh $OUTPUT_DIR/start_linux.sh
cp build/start.ps1 $OUTPUT_DIR/start_windows.ps1

# Hacerlos ejecutables en Linux/macOS
chmod +x $OUTPUT_DIR/start_osx.sh $OUTPUT_DIR/start_linux.sh

# Listar resultados
echo "✅ Instaladores generados en la carpeta: $OUTPUT_DIR"
ls -l $OUTPUT_DIR
