# 🔫 CoreTrigger | External Pixel-Response Tool

### 🚀 High-Performance External Triggerbot for CS2

`CoreTrigger` es una herramienta de respuesta automatizada de alto rendimiento basada en el análisis de píxeles en tiempo real. Diseñada para ofrecer una ventaja competitiva con una latencia mínima y una arquitectura 100% externa.

---

## 💻 Stack Tecnológico
* **Lenguaje:** AutoHotkey v2.0 (Optimized)
* **Motor de Disparo:** Windows API `mouse_event` (Low Latency)
* **Detección:** Algoritmo dinámico de búsqueda de color.

---

## ⚙️ Características principales

* 🟢 **100% External:** No lee la memoria del juego ni inyecta código (VAC Safe Profile).
* ⚡ **Low Latency:** Utiliza `DllCall` para enviar señales de clic directamente al sistema, siendo más rápido que el input estándar.
* 🎯 **Precision Range:** Escaneo optimizado a un área de 3px para maximizar la precisión y evitar disparos accidentales.
* 🔊 **Audio Feedback:** Confirmación por voz (SAPI) al activar o desactivar el sistema.
* 🖥️ **Resolution Independent:** Calcula automáticamente el centro de tu pantalla sin importar si juegas en 1080p, 2K o 4K.

---

## 📥 Instalación y Uso

1.  **Descarga:** Descarga el `CoreTrigger.exe` desde la sección de [Releases](https://github.com/tu-usuario/CoreTrigger/releases).
2.  **Configuración del juego:** Se recomienda usar el resaltado de enemigos (Glow) en color Rojo o Cian para máxima efectividad.
3.  **Activación:** Pulsa la tecla **"C"** para activar o desactivar el Triggerbot.
4.  **Cierre:** Pulsa **F10** para cerrar la aplicación por completo.

---

## 📜 Vista previa del Kernel (v2)

```autohotkey
; Fragmento del motor de detección optimizado
if PixelSearch(&Px, &Py, CentroX-Rango, CentroY-Rango, CentroX+Rango, CentroY+Rango, 0xFF0000, 40) {
    Disparar() ; Ejecuta clic mediante DllCall
}
