# scripts/package_dmg.sh

set -e

# Directorio final con el contenido del instalador
OUTPUT_DIR="installer_output"

# Asegurarse de que el script final existe
if [ ! -f "$OUTPUT_DIR/MedicalOfficeLauncher.command" ]; then
  echo "❌ El archivo MedicalOfficeLauncher.command no fue encontrado. Asegúrate de ejecutar generate_installers.sh primero."
  exit 1
fi

# Crear el .dmg
echo "💽 Generando el archivo .dmg..."
create-dmg \
  --volname "MedicalOfficeInstaller" \
  --window-pos 200 120 \
  --window-size 600 300 \
  --icon-size 100 \
  --icon "MedicalOfficeLauncher.command" 175 120 \
  --hide-extension "MedicalOfficeLauncher.command" \
  --app-drop-link 425 120 \
  "MedicalOfficeInstaller.dmg" \
  "$OUTPUT_DIR"

echo "✅ .dmg creado: MedicalOfficeInstaller.dmg"
