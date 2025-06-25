; ----------------------------------------------------------------
; AutoHotkey v2 변환본 (수정됨)
; ----------------------------------------------------------------

#Requires AutoHotkey v2.0

; Official repo:
; https://github.com/selfiens/KorTooltip

; References:
; IME state reader: https://iamaman.tistory.com/1805
; Persistent tooltip https://stackoverflow.com/questions/41598616/toggling-a-persistent-tooltip

; # win
; ! alt
; ^ ctrl
; + shift

; ----------------------------------------------------------------
; Initializer >>>

isActive := true
lastX := 0
lastY := 0
lastImeState := 99

idlePollingCurrentSkip := 0
toolTipFlashIdx := 0

; preferences
colorScheme := IniRead('KorTooltip.ini', 'preferences', 'colorScheme', 'whiteOnBlack')

; core
idlePollingSkipMax := Integer(IniRead('KorTooltip.ini', 'internal', 'idlePollingSkipMax', '15'))
toolTipFlashIntervalMs := Integer(IniRead('KorTooltip.ini', 'internal', 'toolTipFlashIntervalMs', '500'))
toolTipOffsetX := Integer(IniRead('KorTooltip.ini', 'internal', 'toolTipOffsetX', '20'))
toolTipOffsetY := Integer(IniRead('KorTooltip.ini', 'internal', 'toolTipOffsetY', '20'))

; 커스텀 툴팁 스타일 설정
SetupCustomTooltip()

InitTrayMenu()
StartWatch()
; <<< Initializer
; ----------------------------------------------------------------

; ----------------------------------------------------------------
; toggle tooltip state
#ScrollLock:: {
    global isActive
    if (!isActive) {
        StartWatch()
    } else {
        StopWatch()
    }
}

StartWatch() {
    global isActive
    isActive := true
    SetTimer(WatchCursor, 16)
}

StopWatch() {
    global isActive
    isActive := false
    SetTimer(WatchCursor, 0)
    ToolTip()  ; 기본 툴팁 숨기기
}

InitTrayMenu() {
    Tray := A_TrayMenu
    Tray.Delete()
    Tray.Add("White", TooltipColorBlackOnWhite)
    Tray.Add("Black", TooltipColorWhiteOnBlack)
    Tray.Add("Red", TooltipColorWhiteOnRed)
    Tray.Add("Flash", StartToolTipFlash)
    Tray.Add()
    Tray.Add("Exit", ExitApp)
}

SaveSettings() {
    global colorScheme
    global idlePollingSkipMax, toolTipFlashIntervalMs, toolTipOffsetX, toolTipOffsetY
    IniWrite(colorScheme, 'KorTooltip.ini', 'preferences', 'colorScheme')
    IniWrite(String(idlePollingSkipMax), 'KorTooltip.ini', 'internal', 'idlePollingSkipMax')
    IniWrite(String(toolTipFlashIntervalMs), 'KorTooltip.ini', 'internal', 'toolTipFlashIntervalMs')
    IniWrite(String(toolTipOffsetX), 'KorTooltip.ini', 'internal', 'toolTipOffsetX')
    IniWrite(String(toolTipOffsetY), 'KorTooltip.ini', 'internal', 'toolTipOffsetY')
}

TooltipColorBlackOnWhite(*) {
    global colorScheme
    colorScheme := "blackOnWhite"
    StopToolTipFlash()
    ToolTipColor("White", "Black")
}

TooltipColorWhiteOnBlack(*) {
    global colorScheme
    colorScheme := "whiteOnBlack"
    StopToolTipFlash()
    ToolTipColor("Black", "White")
}

TooltipColorWhiteOnRed(*) {
    global colorScheme
    colorScheme := "whiteOnRed"
    StopToolTipFlash()
    ToolTipColor("Red", "White")
}

StartToolTipFlash(*) {
    global colorScheme, toolTipFlashIntervalMs, toolTipFlashIdx
    colorScheme := "flash"
    toolTipFlashIdx := 1
    SetTimer(FlashToolTip, toolTipFlashIntervalMs)
}

StopToolTipFlash(*) {
    global toolTipFlashIdx
    toolTipFlashIdx := 0
    SetTimer(FlashToolTip, 0)
}

FlashToolTip(*) {
    global toolTipFlashIdx
    if (toolTipFlashIdx = 1) {
        ToolTipColor("Red", "White")
    }
    if (toolTipFlashIdx = 2) {
        ToolTipColor("Black", "White")
    }
    toolTipFlashIdx++
    if (toolTipFlashIdx > 2) {
        toolTipFlashIdx := 1
    }
}

ExitApp(*) {
    SaveSettings()
    ExitApp()
}

GetCaretScreenPos(&x, &y, &winId) {
    ; 먼저 활성 창이 있는지 확인
    winId := WinExist("A")
    if !winId
        return false
    
    ; 방법 1: GetCaretPos 시도
    pt := Buffer(8, 0)
    if DllCall("GetCaretPos", "ptr", pt.Ptr) {
        x := NumGet(pt, 0, "Int")
        y := NumGet(pt, 4, "Int")
        
        ; 유효한 좌표인지 확인 (0, 0이 아닌 경우)
        if (x != 0 || y != 0) {
            ; 화면 좌표로 변환
            if DllCall("ClientToScreen", "ptr", winId, "ptr", pt.Ptr) {
                x := NumGet(pt, 0, "Int")
                y := NumGet(pt, 4, "Int")
                return true
            }
        }
    }
    
    ; 방법 2: GetGUIThreadInfo 시도
    gui := Buffer(48, 0)
    NumPut("UInt", 48, gui, 0)  ; cbSize
    
    if DllCall("GetGUIThreadInfo", "UInt", 0, "Ptr", gui.Ptr) {
        caretLeft := NumGet(gui, 20, "Int")
        caretTop := NumGet(gui, 24, "Int")
        caretRight := NumGet(gui, 28, "Int")
        caretBottom := NumGet(gui, 32, "Int")
        
        ; 유효한 커서 영역이 있는지 확인
        if (caretLeft != 0 || caretTop != 0 || caretRight != 0 || caretBottom != 0) {
            x := caretLeft
            y := caretTop
            
            ; 화면 좌표로 변환
            pt2 := Buffer(8, 0)
            NumPut("Int", x, pt2, 0)
            NumPut("Int", y, pt2, 4)
            
            if DllCall("ClientToScreen", "ptr", winId, "ptr", pt2.Ptr) {
                x := NumGet(pt2, 0, "Int")
                y := NumGet(pt2, 4, "Int")
                return true
            }
        }
    }
    
    return false
}

WatchCursor(*) {
    global lastX, lastY, lastImeState, toolTipFlashIdx
    global idlePollingCurrentSkip, idlePollingSkipMax
    global toolTipOffsetX, toolTipOffsetY
    
    ; 현재 마우스 위치 가져오기
    MouseGetPos(&x, &y)
    winId := WinExist("A")
    
    ; IME 상태 확인
    imeState := 0
    if (winId) {
        imeState := ReadImeState(winId)
    }
    
    ; 위치나 IME 상태가 변경되었을 때 툴팁 업데이트
    ; 또는 일정 시간마다 강제 업데이트
    if (x != lastX || y != lastY || imeState != lastImeState || idlePollingCurrentSkip >= idlePollingSkipMax) {
        ; 툴팁 텍스트 결정
        tooltipText := (imeState = 1) ? "ko" : "en"
        
        ; 기본 툴팁 표시
        ToolTip(tooltipText, x + toolTipOffsetX, y + toolTipOffsetY, 1)
        
        lastX := x
        lastY := y
        lastImeState := imeState
        idlePollingCurrentSkip := 0
    } else {
        idlePollingCurrentSkip++
    }
}

ReadImeState(hWnd) {
    return Send_ImeControl(ImmGetDefaultIMEWnd(hWnd), 0x005, "")
}

Send_ImeControl(DefaultIMEWnd, wParam, lParam) {
    DetectSave := A_DetectHiddenWindows
    DetectHiddenWindows(true)
    try {
        result := SendMessage(0x283, wParam, lParam,, "ahk_id " DefaultIMEWnd)
    } catch {
        result := 0
    }
    DetectHiddenWindows(DetectSave)
    return result
}

ImmGetDefaultIMEWnd(hWnd) {
    return DllCall("imm32.dll\ImmGetDefaultIMEWnd", "ptr", hWnd, "ptr")
}

ToolTipFont(Options := "", Name := "", hwnd := "") {
    static hfont := 0
    if (hwnd = "")
        hfont := Options = "Default" ? 0 : _TTG("Font", Options, Name), _TTHook()
    else
        DllCall("SendMessage", "ptr", hwnd, "uint", 0x30, "ptr", hfont, "ptr", 0)
}

ToolTipColor(Background := "", Text := "", hwnd := "") {
    static bc := "", tc := ""
    if (hwnd = "") {
        if (Background != "")
            bc := Background = "Default" ? "" : _TTG("Color", Background)
        if (Text != "")
            tc := Text = "Default" ? "" : _TTG("Color", Text)
        _TTHook()
    } else {
        ; 텍스트 색상을 빨간색으로 설정
        DllCall("SendMessage", "ptr", hwnd, "uint", 1044, "ptr", 0x0000FF, "ptr", 0)  ; TTM_SETTIPTEXTCOLOR - 빨간색 (BGR 형식)
    }
}

_TTHook() {
    static hook := 0
    if !hook
        hook := DllCall("SetWindowsHookExW", "int", 4, "ptr", CallbackCreate(_TTWndProc), "ptr", 0, "uint", DllCall("GetCurrentThreadId"), "ptr")
}

_TTWndProc(nCode, _wp, _lp) {
    Critical(999)
    uMsg := NumGet(_lp + 2 * A_PtrSize, "uint")
    hwnd := NumGet(_lp + 3 * A_PtrSize, "ptr")
    if (nCode >= 0 && (uMsg = 1081 || uMsg = 1036)) {
        try {
            _hack_ := "ahk_id " hwnd
            wclass := WinGetClass(_hack_)
            if (wclass = "tooltips_class32") {
                ToolTipColor(,, hwnd)
                ToolTipFont(,, hwnd)
            }
        }
    }
    return DllCall("CallNextHookEx", "ptr", 0, "int", nCode, "ptr", _wp, "ptr", _lp, "ptr")
}

_TTG(Cmd, Arg1, Arg2 := "") {
    static htext := 0, hgui := 0, myGui := 0
    if !htext {
        myGui := Gui("+LastFound +0x40000000", "_TTG")
        hgui := myGui.Hwnd
        htext := myGui.Add("Text", "").Hwnd
    }
    if (Cmd = "Font") {
        myGui.SetFont(Arg1, Arg2)
        return SendMessage(0x31, 0, 0,, "ahk_id " htext)
    }
    if (Cmd = "Color") {
        hdc := DllCall("GetDC", "ptr", htext, "ptr")
        SendMessage(0x138, hdc, htext,, "ahk_id " hgui)
        clr := DllCall("GetBkColor", "ptr", hdc, "uint")
        DllCall("ReleaseDC", "ptr", htext, "ptr", hdc)
        return clr
    }
}

; ----------------------------------------------------------------
; Custom Tooltip Setup

SetupCustomTooltip() {
    ; 빨간색 텍스트 설정
    ToolTipColor("", "Red")  ; 배경 기본, 텍스트 빨간색
} 