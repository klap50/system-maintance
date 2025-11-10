# 🧙‍♂️ System Maintenance Script — Pop!_OS / Ubuntu

Script automatizado de mantenimiento para sistemas basados en **Ubuntu / Pop!_OS**, diseñado por **Klap (FWCORP)** para mantener el entorno siempre limpio, actualizado y optimizado, con notificación visual al finalizar.

---

## 📋 Descripción

Este script realiza una rutina de mantenimiento del sistema cada 3 días de forma automática.  
Sus tareas incluyen:

- 🔄 Actualización completa del sistema (`apt update`, `apt full-upgrade`)
- 🧩 Reparación de dependencias rotas
- ⚙️ Configuración de paquetes pendientes
- 🧹 Limpieza de paquetes huérfanos y caché de APT
- 📦 Actualización opcional de Flatpak
- 🔐 Chequeo de claves GPG expiradas o revocadas
- 🔔 Notificación visual (usando `notify-send`)
- 🪶 Log detallado en `/var/log/system-maintenance.log`

---

## 🧠 Requisitos

Asegurate de tener instaladas las herramientas necesarias:

```bash
sudo apt install libnotify-bin flatpak -y
