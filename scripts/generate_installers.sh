#!/bin/bash
set -e # Detiene el script si cualquier comando falla

OUTPUT_DIR=installer_output

# Crear carpeta si no existe
mkdir -p $OUTPUT_DIR

# Correr CMake para generar scripts desde plantillas
echo "⚙️ Ejecutando CMake para generar los scripts de inicio..."
cmake -S . -B build

# Copiar scripts generados
echo "📦 Copiando scripts a $OUTPUT_DIR..."
# cp build/start_osx.sh $OUTPUT_DIR/start_osx.sh      # macOS
# cp build/start_linux.sh $OUTPUT_DIR/start_linux.sh  # Linux
# cp build/start.ps1 $OUTPUT_DIR/start_windows.ps1    # Windows

# Copiar los scripts generados a la carpeta de salida
find build -name "start_osx.sh" -exec cp {} $OUTPUT_DIR/start_osx.sh \;
find build -name "start_linux.sh" -exec cp {} $OUTPUT_DIR/start_linux.sh \;
find build -name "start.ps1" -exec cp {} $OUTPUT_DIR/start_windows.ps1 \;

# Dar permisos de ejecución a los scripts shell
chmod +x $OUTPUT_DIR/start_osx.sh $OUTPUT_DIR/start_linux.sh

# Mostrar confirmación
echo "✅ Instaladores generados en la carpeta: $OUTPUT_DIR"
ls -l $OUTPUT_DIR
