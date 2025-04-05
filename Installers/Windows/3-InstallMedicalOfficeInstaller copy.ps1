$ErrorActionPreference = "Stop"

$basePath = "C:\MedicalOffice"
$envEncrypted = Join-Path $basePath ".env.secure.gpg"
$envTemp = Join-Path $basePath ".env"
$passphrase = "I0fFAwYMpEEXOJkuBARaN7cD7uIQ1Vvs5luQW64d9TBZYCRS9j"

# Verificar dependencias
if (-not (Get-Command "gpg" -ErrorAction SilentlyContinue)) {
    Write-Error "❌ GPG no está instalado."
    exit 1
}
if (-not (Get-Command "docker" -ErrorAction SilentlyContinue)) {
    Write-Error "❌ Docker no está instalado o no está en el PATH."
    exit 1
}

Write-Host "🔐 Desencriptando .env.secure.gpg..."

try {
    $decryptCommand = "--batch --yes --passphrase $passphrase --output `"$envTemp`" --decrypt `"$envEncrypted`""
    $proc = Start-Process -FilePath "gpg" -ArgumentList $decryptCommand -NoNewWindow -PassThru -Wait -RedirectStandardError "$env:Temp\gpg_err.log"

    if ($proc.ExitCode -ne 0) {
        $errorMessage = Get-Content "$env:Temp\gpg_err.log" -Raw
        Write-Error "❌ Error al desencriptar: $errorMessage"
        exit 1
    }

    Write-Host "✅ Desencriptación exitosa."

    # Cambiar al directorio del proyecto
    Set-Location $basePath

    Write-Host "🐳 Iniciando contenedores con Docker Compose..."
    docker compose --env-file "$envTemp" up

    Write-Host "✅ Contenedores lanzados correctamente."

} finally {
    if (Test-Path $envTemp) {
        Remove-Item $envTemp -Force
        Write-Host "🧹 Archivo .env temporal eliminado."
    }
}
