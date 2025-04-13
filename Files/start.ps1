# 🚀 Script: start.ps1 - Lanzador de entorno Docker para Medical Office

# Preferencia: mostrar errores pero continuar ejecución
$ErrorActionPreference = "Continue"

Write-Host "==============================="
Write-Host "🩺 Medical Office Installer"
Write-Host "==============================="
Write-Host ""

# Función para ejecutar un paso con manejo de errores
function Ejecutar {
    param (
        [string]$Mensaje,
        [ScriptBlock]$Accion
    )
    Write-Host "🔸 $Mensaje"
    try {
        & $Accion
    } catch {
        Write-Host "❌ Error: $_"
    }
    Write-Host ""
}

# 1. Pull de imágenes Docker
Ejecutar "Descargando imágenes con Docker Compose Pull" {
    docker compose pull
}

# 2. Build de servicios Docker
Ejecutar "Construyendo servicios con Docker Compose Build" {
    docker compose build
}

# 3. Down (limpia contenedores antiguos)
Ejecutar "Eliminando contenedores y volúmenes anteriores" {
    docker compose down
}

# 4. Up (levanta los servicios)
Ejecutar "Levantando servicios con Docker Compose Up -d" {
    docker compose up -d
}

Write-Host ""
Write-Host "✅ Todos los pasos completados (o tolerados)."
Write-Host "Puedes verificar tus contenedores con:"
Write-Host "`tdocker ps -a`"
