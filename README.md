# Medical.Office.Installer
## Instalación

1. Crea un archivo `.env` basado en `.env.example`.
2. Ejecuta el instalador con:

   - En macOS/Linux:
     ```bash
     ./start.sh
     ```

   - En Windows:
     ```powershell
     start.bat
     ```

O, si estás usando `CMake`:

```bash
cmake -S . -B build
cmake --build build
