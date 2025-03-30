#!/bin/bash
set -e

OUTPUT_DIR=installer_output

# Crear carpeta si no existe
mkdir -p $OUTPUT_DIR

# Ejecutar CMake para generar scripts desde plantillas
echo "⚙️ Ejecutando CMake para generar los scripts de inicio..."
cmake -S . -B build

# Detectar archivos generados con find
echo "📦 Copiando scripts generados a $OUTPUT_DIR..."

OSX_SCRIPT=$(find build -name "start_osx.sh" | head -n 1)
LINUX_SCRIPT=$(find build -name "start_linux.sh" | head -n 1)
WIN_SCRIPT=$(find build -name "start.ps1" | head -n 1)

if [[ -f "$OSX_SCRIPT" ]]; then
  cp "$OSX_SCRIPT" "$OUTPUT_DIR/start_osx.sh"
else
  echo "❌ No se encontró: start_osx.sh"
  exit 1
fi

if [[ -f "$LINUX_SCRIPT" ]]; then
  cp "$LINUX_SCRIPT" "$OUTPUT_DIR/start_linux.sh"
else
  echo "❌ No se encontró: start_linux.sh"
  exit 1
fi

if [[ -f "$WIN_SCRIPT" ]]; then
  cp "$WIN_SCRIPT" "$OUTPUT_DIR/start_windows.ps1"
else
  echo "❌ No se encontró: start.ps1"
  exit 1
fi

# Dar permisos de ejecución a scripts shell
chmod +x "$OUTPUT_DIR/start_osx.sh" "$OUTPUT_DIR/start_linux.sh"

echo "✅ Instaladores generados en la carpeta: $OUTPUT_DIR"
ls -l "$OUTPUT_DIR"
