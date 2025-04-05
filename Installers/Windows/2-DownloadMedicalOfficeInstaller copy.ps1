$ErrorActionPreference = "Stop"

# Rutas y URLs
$zipUrl = "https://github.com/Raptor057/Medical.Office.Installer/releases/download/latest/Medical-Office.zip"
$shaUrl = "https://github.com/Raptor057/Medical.Office.Installer/releases/download/latest/Medical-Office.zip.sha256"

$tempDir = "$PSScriptRoot\_tmp_medicaloffice"
$zipPath = "$tempDir\Medical-Office.zip"
$shaPath = "$tempDir\Medical-Office.zip.sha256"
$targetPath = "C:\MedicalOffice"

# Crear carpeta temporal
if (Test-Path $tempDir) { Remove-Item $tempDir -Recurse -Force }
New-Item -ItemType Directory -Path $tempDir | Out-Null

# Descargar archivos
Write-Host "📥 Descargando archivos..."
Invoke-WebRequest -Uri $zipUrl -OutFile $zipPath
Invoke-WebRequest -Uri $shaUrl -OutFile $shaPath

# Validar SHA256
Write-Host "🧪 Validando integridad..."
$expectedHash = Get-Content $shaPath | Select-String -Pattern '^[a-fA-F0-9]{64}' | ForEach-Object { $_.Matches.Value }
$actualHash = Get-FileHash -Algorithm SHA256 -Path $zipPath | Select-Object -ExpandProperty Hash

if ($expectedHash -ne $actualHash) {
    Write-Error "❌ La verificación SHA256 falló. El archivo puede estar corrupto o alterado."
    Exit 1
} else {
    Write-Host "✅ Integridad verificada."
}

# Extraer y copiar Files a destino
Write-Host "📦 Extrayendo archivos..."
Expand-Archive -Path $zipPath -DestinationPath $tempDir -Force

$filesPath = Join-Path $tempDir "Files"

if (-not (Test-Path $filesPath)) {
    Write-Error "❌ No se encontró la carpeta 'Files' dentro del zip."
    Exit 1
}

# Crear carpeta destino si no existe
if (-not (Test-Path $targetPath)) {
    New-Item -Path $targetPath -ItemType Directory | Out-Null
}

# Copiar contenido
Write-Host "📂 Copiando a $targetPath ..."
Copy-Item "$filesPath\*" -Destination $targetPath -Recurse -Force

# Limpiar temporales
Remove-Item $tempDir -Recurse -Force

Write-Host "🎉 ¡Descarga completada exitosamente en $targetPath!"