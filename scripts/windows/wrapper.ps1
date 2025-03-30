# scripts/windows/wrapper.ps1

$ErrorActionPreference = "Stop"

# Ruta base donde se encuentra el script (asumiendo que .env.gpg está junto a él)
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$envPath = Join-Path $scriptDir ".env.gpg"

# Passphrase embebida (más adelante puedes reemplazar esto con una env var o forma segura)
$passphrase = "@MY_ENV_PASSPHRASE@"

# Desencriptar el archivo .env.gpg
Write-Host "Desencriptando .env.gpg..."
gpg --quiet --batch --yes --passphrase "$passphrase" --output "$scriptDir/.env" --decrypt "$envPath"

# Cargar variables del .env
Get-Content "$scriptDir/.env" | ForEach-Object {
  if ($_ -match "^(.*?)=(.*)$") {
    $key = $matches[1]
    $val = $matches[2]
    [System.Environment]::SetEnvironmentVariable($key, $val, "Process")
  }
}

# Ejecutar el script real
Write-Host "Ejecutando start_windows.ps1..."
powershell -ExecutionPolicy Bypass -File "$scriptDir/start_windows.ps1"
