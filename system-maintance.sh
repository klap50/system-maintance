#!/usr/bin/env bash
set -euo pipefail

LOGFILE="/var/log/system-maintenance.log"

echo "============================================" | tee -a "$LOGFILE"
echo " Mantenimiento del sistema - $(date)" | tee -a "$LOGFILE"
echo "============================================" | tee -a "$LOGFILE"

# 1. Actualizar índices
echo "[1/7] Actualizando lista de paquetes (apt update)..." | tee -a "$LOGFILE"
apt update >> "$LOGFILE" 2>&1

# 2. Reparar dependencias rotas (si las hubiera)
echo "[2/7] Reparando dependencias rotas (apt --fix-broken install)..." | tee -a "$LOGFILE"
apt --fix-broken install -y >> "$LOGFILE" 2>&1 || true

# 3. Terminar de configurar paquetes pendientes
echo "[3/7] Configurando paquetes pendientes (dpkg --configure -a)..." | tee -a "$LOGFILE"
dpkg --configure -a >> "$LOGFILE" 2>&1 || true

# 4. Actualización completa del sistema
echo "[4/7] Actualizando paquetes (apt full-upgrade)..." | tee -a "$LOGFILE"
apt full-upgrade -y >> "$LOGFILE" 2>&1

# 5. Limpiar paquetes huérfanos y caché
echo "[5/7] Limpiando paquetes huérfanos (apt autoremove --purge)..." | tee -a "$LOGFILE"
apt autoremove --purge -y >> "$LOGFILE" 2>&1

echo "[6/7] Limpiando caché de APT (apt clean & autoclean)..." | tee -a "$LOGFILE"
apt clean >> "$LOGFILE" 2>&1
apt autoclean >> "$LOGFILE" 2>&1

# 6. Actualizar Flatpak si existe
if command -v flatpak >/dev/null 2>&1; then
    echo "[6 bis] Actualizando aplicaciones Flatpak..." | tee -a "$LOGFILE"
    flatpak update -y >> "$LOGFILE" 2>&1 || true
fi


# 7. Chequeo de claves GPG (solo lectura, sin borrar nada)
echo "[7/7] Revisando claves GPG potencialmente expiradas/revocadas..." | tee -a "$LOGFILE"
if command -v apt-key >/dev/null 2>&1; then
    apt-key list 2>/dev/null | grep -E "expired|revoked" || echo "  - No se detectaron claves expiradas/revocadas visibles." | tee -a "$LOGFILE"
else
    echo "  - apt-key no disponible (sistema moderno sin claves legadas)." | tee -a "$LOGFILE"
fi

echo "Mantenimiento completado correctamente." | tee -a "$LOGFILE"

# Enviar notificación de escritorio al finalizar
if command -v notify-send >/dev/null 2>&1; then
    notify-send -u normal -i preferences-system "✅ Mantenimiento del sistema completado" \
    "El mantenimiento automático de tu sistema finalizó correctamente a las $(date +%H:%M)."
fi
