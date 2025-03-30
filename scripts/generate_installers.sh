#!/bin/bash
set -e  # Detiene el script si cualquier comando falla

OUTPUT_DIR=installer_output
BUILD_DIR=build

# Crear carpeta si no existe
mkdir -p $OUTPUT_DIR

# Ejecutar CMake
echo "⚙️ Ejecutando CMake para generar los scripts de inicio..."
cmake -S . -B $BUILD_DIR

# Función para copiar y verificar
copiar_script() {
  local nombre_archivo=$1
  local destino=$2

  ruta=$(find $BUILD_DIR -name "$nombre_archivo" | head -n 1)

  if [[ -f "$ruta" ]]; then
    cp "$ruta" "$destino"
    echo "✅ Copiado: $nombre_archivo"
  else
    echo "❌ No se encontró: $nombre_archivo"
    exit 1
  fi
}

echo "📦 Copiando scripts generados a $OUTPUT_DIR..."
copiar_script "start_osx.sh" "$OUTPUT_DIR/start_osx.sh"
copiar_script "start_linux.sh" "$OUTPUT_DIR/start_linux.sh"
copiar_script "start.ps1" "$OUTPUT_DIR/start_windows.ps1"

# Aplicar permisos de ejecución solo si existen
chmod +x "$OUTPUT_DIR/start_osx.sh"
chmod +x "$OUTPUT_DIR/start_linux.sh"

# Mostrar resultados
echo "✅ Instaladores generados:"
ls -lh $OUTPUT_DIR
