# Medical Office Installer

Este proyecto contiene todo lo necesario para desplegar el sistema **Medical Office** utilizando Docker, ya sea de manera automática o manual. A continuación, se describe el flujo, uso, instalación, y estructura de carpetas y scripts.

---

## 🚀 Objetivo

Desplegar un sistema completo con:
- SQL Server
- Web API (.NET 8)
- Frontend (Next.js)
- SEQ para logs

---

## 📁 Estructura del Proyecto

```
Medical.Office.Installer/
├── .env                         # Variables sensibles (credenciales GHCR, passwords SQL, etc)
├── CMakeLists.txt               # Generador de scripts según sistema operativo
├── docker-compose.yml          # Orquestador de contenedores
├── scripts/                    # Scripts para verificar e instalar Docker
│   ├── check_docker_linux.sh
│   ├── check_docker_macos.sh
│   └── check_docker_windows.ps1
├── generate_installers.sh      # Script maestro para generar instaladores
├── installer_output/           # Carpeta con los scripts generados (start_osx.sh, start_linux.sh, start.ps1)
└── README.md                   # Este archivo
```

---

## 🧪 Requisitos

- Tener acceso a internet.
- Contar con Docker instalado o permitir su instalación automática.

---

## ⚙️ Instalación Manual

1. Abre terminal en la raíz del proyecto.

```bash
bash generate_installers.sh
```

2. Esto generará instaladores para:
   - macOS → `installer_output/start_osx.sh`
   - Linux → `installer_output/start_linux.sh`
   - Windows → `installer_output/start.ps1`

3. Ve a la carpeta de salida:

```bash
cd installer_output
```

4. Ejecuta el archivo correspondiente a tu sistema operativo:

### macOS:
```bash
./start_osx.sh
```

### Linux:
```bash
./start_linux.sh
```

### Windows (PowerShell):
```powershell
.\start.ps1
```

---

## 🧠 ¿Qué hacen los instaladores?

1. Verifican si Docker y Docker Compose están instalados.
2. Si no lo están, los instalan automáticamente (excepto en macOS, donde abre la página web para instalación manual).
3. Inician sesión en el Registry de GitHub (GHCR) usando variables del archivo `.env`.
4. Verifican si hay imágenes nuevas:
   ```bash
   docker-compose pull
   ```
5. Apagan contenedores existentes:
   ```bash
   docker-compose down
   ```
6. Inician los nuevos:
   ```bash
   docker-compose up -d
   ```

---

## 🔄 Flujo Automatizado (CI/CD)

Si estás en GitHub, puedes crear un archivo `.github/workflows/ci.yml` con:

```yaml
name: Generate Installers

on:
  push:
    paths:
      - '**.in'
      - 'scripts/**'
      - '.env'
      - 'generate_installers.sh'
      - 'CMakeLists.txt'

jobs:
  build-installers:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Setup CMake
        run: sudo apt-get install -y cmake
      - name: Generate Installers
        run: bash generate_installers.sh
      - name: Upload Artifacts
        uses: actions/upload-artifact@v3
        with:
          name: installers
          path: installer_output/
```

Esto generará automáticamente tus scripts cada vez que hagas un cambio relevante.

---

## 🧼 Recomendaciones Finales

- Mantén tu `.env` fuera de GitHub o usa secretos en el CI.
- Verifica que los permisos de ejecución estén bien en Linux/macOS:
  ```bash
  chmod +x installer_output/*.sh
  ```
- Puedes empaquetar los scripts como `.pkg`, `.deb`, o `.exe` si deseas, dependiendo de la plataforma.
