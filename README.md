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

## 📜 Código Fuente. (v7.2)

#Requires AutoHotkey v2.0
#SingleInstance Force

; --- OPTIMIZACIÓN DE MOTOR ---
ProcessSetPriority "Realtime"
SetControlDelay -1
SetMouseDelay -1

global CentroX := A_ScreenWidth // 2
global CentroY := A_ScreenHeight // 2
global Rango   := 3 ; <--- Reducido a 3px para precisión quirúrgica
global Activo  := false
global Sapi    := ComObject("SAPI.SpVoice")

~c:: {
    global Activo := !Activo
    try Sapi.Speak(Activo ? "On" : "Off", 1)
}

Loop {
    if (Activo && !GetKeyState("LButton", "P")) {
        ; BUSQUEDA AGRESIVA (Pillamos el Rojo TT que es el más común de detectar)
        ; Reducimos la variación a 40 para evitar falsos positivos con el mapa
        if PixelSearch(&Px, &Py, CentroX-Rango, CentroY-Rango, CentroX+Rango, CentroY+Rango, 0xFF0000, 40) {
            Disparar()
        }
        ; BUSQUEDA CT (Azul/Cian)
        else if PixelSearch(&Px, &Py, CentroX-Rango, CentroY-Rango, CentroX+Rango, CentroY+Rango, 0x00FFFF, 40) {
            Disparar()
        }
    }
    Sleep(1) ; Latencia mínima de refresco
}

Disparar() {
    DllCall("mouse_event", "uint", 0x0002, "int", 0, "int", 0, "uint", 0, "int", 0) ; Left Down
    Sleep(20) ; Mantener pulsado un instante para que el juego lo registre
    DllCall("mouse_event", "uint", 0x0004, "int", 0, "int", 0, "uint", 0, "int", 0) ; Left Up
    Sleep(150) ; <--- Tiempo de espera entre disparos (más natural que 500ms)
}

F10::ExitApp()
