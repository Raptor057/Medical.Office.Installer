# scripts/check_docker_windows.ps1
if (-not (Get-Command docker -ErrorAction SilentlyContinue)) {
    Write-Output "Docker no está instalado. Descargando instalador..."
    Start-Process "https://desktop.docker.com/win/main/amd64/Docker%20Desktop%20Installer.exe"
    exit 1
  } else {
    Write-Output "Docker ya está instalado."
  }
  
  if (-not (Get-Command docker-compose -ErrorAction SilentlyContinue)) {
    Write-Output "Docker Compose no está instalado. Se instalará junto con Docker Desktop."
  } else {
    Write-Output "Docker Compose ya está instalado."
  }
  