#!/bin/bash
set -e

OUTPUT_DIR=installer_output

# Crear carpeta de salida si no existe
mkdir -p $OUTPUT_DIR

# Correr CMake para generar scripts desde plantillas
echo "⚙️ Ejecutando CMake para generar los scripts de inicio..."
cmake -S . -B build

# 🔍 DEBUG: Mostrar archivos generados en el build
echo "🔍 Archivos encontrados en build:"
find build -type f

# 🔍 DEBUG: Mostrar todos los posibles scripts generados
echo "🔍 Buscando start_osx.sh..."
find build -name "start_osx.sh"

echo "🔍 Buscando start_linux.sh..."
find build -name "start_linux.sh"

echo "🔍 Buscando start.ps1..."
find build -name "start.ps1"

# Copiar los scripts generados a la carpeta de salida
echo "📦 Copiando scripts generados a $OUTPUT_DIR..."
cp $(find build -name "start_osx.sh" | head -n 1) $OUTPUT_DIR/start_osx.sh || echo "❌ No se encontró: start_osx.sh"
cp $(find build -name "start_linux.sh" | head -n 1) $OUTPUT_DIR/start_linux.sh || echo "❌ No se encontró: start_linux.sh"
cp $(find build -name "start.ps1" | head -n 1) $OUTPUT_DIR/start_windows.ps1 || echo "❌ No se encontró: start.ps1"

# Dar permisos de ejecución
chmod +x $OUTPUT_DIR/start_osx.sh $OUTPUT_DIR/start_linux.sh 2>/dev/null || echo "⚠️ No se pudo asignar permisos (quizás no existen)"

# Listar resultados finales
echo "✅ Instaladores generados en la carpeta: $OUTPUT_DIR"
ls -l $OUTPUT_DIR
