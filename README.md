# 🧙‍♂️ System Maintenance Script — Pop!_OS / Ubuntu

Script automatizado de mantenimiento para sistemas basados en **Ubuntu / Pop!_OS**, diseñado por **Klap (FWCORP)** para mantener el entorno siempre limpio, actualizado y optimizado, con notificación visual al finalizar.

---

## 📋 Descripción

Este script realiza una rutina de mantenimiento del sistema cada 3 días de forma automática (dependiendo como configuren el CRON).  
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


# 📦 Syscron — Mantenimiento Automático del Sistema

## 📁 Estructura de archivos

```
syscron/
├── system-maintance.sh     # Script principal de mantenimiento
└── README.md               # Este archivo
```

---

## ⚙️ Instalación

1. **Cloná el repositorio o copiá los archivos:**

```bash
git clone https://github.com/FW-CORP/syscron.git
cd syscron
```

2. **Asigná permisos de ejecución:**

```bash
sudo chmod +x system-maintance.sh
```

3. **Probá una ejecución manual:**

```bash
sudo ./system-maintance.sh
```

4. **Verificá los logs con:**

```bash
sudo tail -n 30 /var/log/system-maintenance.log
```

---

## ⏱️ Automatización con `cron`

Para ejecutar el script **cada 3 días a las 04:00 AM**, añadí esta línea al cron del usuario root:

```bash
sudo crontab -e
```

Y agregá al final:

```cron
DISPLAY=:0
DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus
0 4 */3 * * /home/user/syscron/system-maintance.sh >> /var/log/system-maintenance.log 2>&1
```

📌 **Notas importantes:**
- `DISPLAY=:0` y `DBUS_SESSION_BUS_ADDRESS=...` permiten enviar notificaciones al escritorio.  
- `1000` corresponde al UID del usuario principal (ver con `id -u $user`).

---

## 🔔 Notificaciones

El script muestra un **popup de escritorio** al finalizar:

- ✅ **Verde:** mantenimiento completado sin actualizaciones ni errores.  
- ⚠️ **Amarillo:** se aplicaron actualizaciones o se detectaron incidencias.

---

## 📊 Logs y monitoreo

Los registros completos de cada ejecución se guardan en:

```
/var/log/system-maintenance.log
```

Podés ver las últimas líneas con:

```bash
sudo tail -f /var/log/system-maintenance.log
```
