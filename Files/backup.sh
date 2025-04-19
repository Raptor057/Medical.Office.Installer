#!/bin/sh

echo "⏳ Esperando 180 segundos para que SQL Server esté listo..."
sleep 180

echo "🔍 Verificando disponibilidad de SQL Server en medicalofficesql:1433..."

# Esperar a que SQL Server esté disponible antes de continuar
until /opt/mssql-tools/bin/sqlcmd -S medicalofficesql,1433 -U sa -P "$SA_PASSWORD" -Q "SELECT 1" > /dev/null 2>&1
do
  echo "❌ Aún no disponible... reintentando en 180 segundos."
  sleep 180
done

echo "✅ SQL Server está listo. Iniciando ciclo de backups..."

while true; do
  TIMESTAMP=$(date +%F_%H-%M-%S)
  /opt/mssql-tools/bin/sqlcmd -S medicalofficesql,1433 -U sa -P "$SA_PASSWORD" \
    -Q "BACKUP DATABASE [Medical.Office.SqlLocalDB] TO DISK = '/backups/medical_office_$TIMESTAMP.bak'"
  echo "📦 Backup realizado: $TIMESTAMP"
  sleep 86400  # Espera 24 horas
done
