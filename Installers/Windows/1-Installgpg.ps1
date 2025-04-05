$ErrorActionPreference = "Stop"

# Ruta de instalación esperada
$gpgExe = "$Env:ProgramFiles (x86)\GnuPG\bin\gpg.exe"
$gpgInstallerUrl = "https://files.gpg4win.org/gpg4win-4.3.1.exe"
$gpgInstallerPath = Join-Path $PSScriptRoot "gpg4win-4.3.1.exe"

# Verifica si ya está instalado
if (-not (Test-Path $gpgExe)) {
    Write-Host "📥 GPG no encontrado. Descargando instalador..."

    Invoke-WebRequest -Uri $gpgInstallerUrl -OutFile $gpgInstallerPath

    Write-Host "⚙️ Instalando GPG en modo silencioso..."
    try {
        Start-Process -FilePath $gpgInstallerPath -ArgumentList "/VERYSILENT /NORESTART" -Wait -Verb RunAs
    } catch {
        Write-Error "❌ La instalación de GPG falló. Ejecuta este script como administrador."
        exit 1
    }

    # Validación post instalación
    if (-not (Test-Path $gpgExe)) {
        Write-Error "❌ GPG no se instaló correctamente."
        exit 1
    }
} else {
    Write-Host "✅ GPG ya está instalado."
}

# Verificación final
Write-Host "`n🧪 Verificando ejecución de GPG..."
& "$gpgExe" --version

if (Test-Path $gpgInstallerPath) {
    Remove-Item $gpgInstallerPath -Force
    Write-Host "🧹 Instalador eliminado."
}
