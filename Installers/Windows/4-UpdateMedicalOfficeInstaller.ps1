$ErrorActionPreference = "Stop"

$basePath = "C:\MedicalOffice"
$envPath = Join-Path $basePath ".env.secure.gpg"
$tempEnv = "$env:Temp\env.decrypted.tmp"
$passphrase = "I0fFAwYMpEEXOJkuBARaN7cD7uIQ1Vvs5luQW64d9TBZYCRS9j"

# Validar herramientas necesarias
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
    & gpg --batch --yes --passphrase "$passphrase" --output "$tempEnv" --decrypt "$envPath"
} catch {
    Write-Error "❌ Excepción al intentar desencriptar: $_"
    exit 1
}

Write-Host "🌱 Exportando variables de entorno..."
Get-Content $tempEnv | ForEach-Object {
    if ($_ -match '^\s*#' -or $_ -match '^\s*$') { return }
    $parts = $_ -split '=', 2
    if ($parts.Length -eq 2) {
        [System.Environment]::SetEnvironmentVariable($parts[0], $parts[1], "Process")
        Write-Host "✅ $($parts[0]) cargado"
    }
}

Set-Location $basePath

Write-Host "`n🔄 Verificando actualizaciones de imágenes..."
docker compose pull

Write-Host "`n🛑 Deteniendo contenedores..."
docker compose down

Write-Host "`n🚀 Levantando nueva infraestructura..."
docker compose up -d

Write-Host "`n🧹 Limpiando archivo temporal..."
Remove-Item $tempEnv -Force

Write-Host "`n✅ Actualización completada con éxito."


# Write-Host "🧨 Deteniendo contenedores..."
# $output = docker compose down 2>&1
# if ($LASTEXITCODE -ne 0) {
#     Write-Error "❌ Algo salió mal:\n$output"
#     exit 1
# }
# Write-Host "✅ Contenedores detenidos."
