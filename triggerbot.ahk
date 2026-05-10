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