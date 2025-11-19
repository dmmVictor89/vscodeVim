#requires autohotkey v2.0

;모니터 이동 및 정 easyclick 호출
; 1번 모니터 1000, 500
monitor1pos := { x: 1000, y: 500 }    ; 1번 모니터 클릭 위치
monitor2pos := { x: -1000, y: 500 }   ; 2번 모니터 클릭 위치

/* ^!1:: {
    SelectMonitor(1)
}

^!2:: {
    SelectMonitor(2)
} */

SelectMonitor(monitorNum) {
    ; 해당 모니터의 작업 영역 정보 가져오기
    MonitorGetWorkArea(monitorNum, &left, &top, &right, &bottom)

    ; 모니터의 중앙 좌표 계산
    centerX := left + (right - left) // 2
    centerY := top + (bottom - top) // 2

    ; 마우스를 해당 모니터의 중앙으로 이동
    MouseMove(centerX, centerY, 0)

    ; 현재 마우스 커서 위치(중앙)에 있는 창의 핸들(ID)을 가져옵니다.
    ; 이것이 바로 해당 위치의 Z-order상 가장 위에 있는 창입니다.
    winId := DllCall("WindowFromPoint", "int", centerX, "int", centerY, "ptr")

    ; 창을 찾았으면 활성화하고 신호 전송
    if (winId) {
        WinActivate("ahk_id " winId)
    } else {
        Click
    }
    Send("!;") ; ctrl+; 전송
}

; 한글/영어 입력 상태 감지 및 커스텀 툴팁 표시
#SingleInstance Force
SetWorkingDir A_ScriptDir

; DPI 스케일링 설정 개선 - 시스템 DPI 인식 사용
DllCall("SetThreadDpiAwarenessContext", "Ptr", -1)  ; System DPI awareness (더 안정적)

; 전역 변수
lastImeState := -1
lastMouseX := 0
lastMouseY := 0
guiTooltip := ""
isActive := true  ; 토글 상태
cachedMonitors := Map()  ; 모니터 정보 캐싱
lastCacheUpdate := 0  ; 캐시 업데이트 시간 추적

; 모니터 정보 캐싱 함수
CacheMonitorInfo() {
    global cachedMonitors
    cachedMonitors.Clear()
    MonitorCount := MonitorGetCount()
    Loop MonitorCount {
        MonitorGetWorkArea(A_Index, &left, &top, &right, &bottom)
        cachedMonitors[A_Index] := {left: left, top: top, right: right, bottom: bottom}
    }
}

; 절대 좌표를 사용한 현재 마우스가 위치한 모니터 식별 함수
GetCurrentMonitor(x, y) {
    global cachedMonitors
    
    ; 캐시된 정보가 없으면 새로 생성
    if (cachedMonitors.Count = 0) {
        CacheMonitorInfo()
    }
    
    ; 각 모니터 영역과 비교
    for monitorNum, bounds in cachedMonitors {
        if (x >= bounds.left && x <= bounds.right && y >= bounds.top && y <= bounds.bottom) {
            return monitorNum
        }
    }
    return MonitorGetPrimary()
}

; 좌표 정규화 함수 - 가상 데스크톱 좌표를 절대 좌표로 변환
NormalizeCoordinates(x, y) {
    ; GetSystemMetrics로 가상 화면 정보 가져오기
    virtualScreenLeft := DllCall("GetSystemMetrics", "Int", 76)  ; SM_XVIRTUALSCREEN
    virtualScreenTop := DllCall("GetSystemMetrics", "Int", 77)   ; SM_YVIRTUALSCREEN
    
    ; 절대 좌표로 변환
    normalizedX := x - virtualScreenLeft
    normalizedY := y - virtualScreenTop
    
    return {x: normalizedX, y: normalizedY}
}

; 절대 좌표 가져오기 함수 - 포커스에 영향받지 않음
GetAbsoluteMousePos() {
    ; POINT 구조체 생성 (8바이트: x(4) + y(4))
    point := Buffer(8, 0)
    
    ; GetCursorPos API 호출 - 절대 화면 좌표 반환
    if (DllCall("GetCursorPos", "Ptr", point)) {
        x := NumGet(point, 0, "Int")
        y := NumGet(point, 4, "Int")
        return {x: x, y: y}
    }
    
    ; 실패 시 기본 MouseGetPos 사용
    MouseGetPos(&fallbackX, &fallbackY)
    return {x: fallbackX, y: fallbackY}
}

; GUI 생성 함수 (멀티모니터 지원 개선)
ShowCustomTooltip(text) {
    global guiTooltip

    ; 절대 좌표로 마우스 위치 가져오기
    mousePos := GetAbsoluteMousePos()
    mouseX := mousePos.x
    mouseY := mousePos.y
    
    ; 현재 모니터 식별 (절대 좌표 사용)
    currentMonitor := GetCurrentMonitor(mouseX, mouseY)
    
    ; 모니터 작업 영역 가져오기
    if (!cachedMonitors.Has(currentMonitor)) {
        CacheMonitorInfo()
    }
    
    bounds := cachedMonitors[currentMonitor]
    left := bounds.left
    top := bounds.top
    right := bounds.right
    bottom := bounds.bottom

    ; 툴팁 좌표 계산 (절대 좌표 기준)
    x := mouseX + 10 
    y := mouseY - 10
    tooltipWidth := 80
    tooltipHeight := 40

    ; 경계 조정 (해당 모니터 내에서)
    if (x < left) {
        x := left + 10
    }
    if (x + tooltipWidth > right) {
        x := right - tooltipWidth - 10
    }
    if (y < top) {
        y := top + 10
    }
    if (y + tooltipHeight > bottom) {
        y := mouseY - tooltipHeight - 10
        if (y < top) {
            y := top + 10
        }
    }
    
    ; 디버그 용
    debugInfo .= "Bounds: ( mouseX: " . mouseX . ", mouseY: " . mouseY . ")"

    ; 디버그 정보 (절대 좌표와 AHK 좌표 비교)
    ;  virtualScreenLeft := DllCall("GetSystemMetrics", "Int", 76)
    ;  virtualScreenTop := DllCall("GetSystemMetrics", "Int", 77)
    ;  debugInfo := "ABS: (" . mouseX . "," . mouseY . ") AHK: (" . ahkX . "," . ahkY . ") Norm: (" . normalized.x . "," . normalized.y . ")`n"
    ;  debugInfo .= "VirtScreen: (" . virtualScreenLeft . "," . virtualScreenTop . ") Mon:" . currentMonitor . "`n"
    ;  debugInfo .= "Bounds: (" . left . "," . top . "," . right . "," . bottom . ") GUI: (" . x . "," . y . ")"

    ; 기존 GUI 제거
    if (guiTooltip) {
        try {
            guiTooltip.Destroy()
        }
        guiTooltip := ""
    }

    ; 새 GUI 생성
    guiTooltip := Gui()
    guiTooltip.Opt("-Caption +ToolWindow +AlwaysOnTop -Border")

    guiTooltip.BackColor := "White"
    guiTooltip.SetFont("s20 cFF00FF", "D2Coding")  ; 라임색으로 시인성 향상
    ; WinSetTransparent(0, guiTooltip.Hwnd)  ; 투명도 200 (0-255)
    ; 텍스트에 따라 색상 결정
    if (text = "A") {
        guiTooltip.SetFont("s20 cLime Bold", "D2Coding")  ; 영어는 노란색
        text := "•"
    } else if (text = "가") {
        guiTooltip.SetFont("s20 cFF00FF Bold", "D2Coding")     ; 한글은 빨간색
        text := "•"
    } else {
        text := ""
    } 

    ; 디버깅용 출력
    ; guiTooltip.SetFont("s8 cRed", "Hack")
    ; displayText := text . "`n" . debugInfo
    ; guiTooltip.Add("Text", "x5 y2 BackgroundTrans", displayText)
    guiTooltip.Add("Text", "x8 y8 BackgroundTrans Center", text)
    
    ; GUI 투명도 설정을 안전하게 처리
    try {
        if (guiTooltip && guiTooltip.Hwnd) {
            WinSetTransColor("White", guiTooltip.Hwnd)
            guiTooltip.Show("NoActivate x" . x . " y" . y . " AutoSize")
        }
    } catch {
        ; 오류 발생 시 아무 동작하지 않음
    }
}

; IME 상태 확인 함수 (개선)
GetImeState() {
    activeWin := WinExist("A")
    if (!activeWin)
        return 0

    try {
        imeWnd := DllCall("imm32.dll\ImmGetDefaultIMEWnd", "ptr", activeWin, "ptr")
        if (imeWnd) {
            return DllCall("SendMessage", "ptr", imeWnd, "uint", 0x283, "ptr", 0x005, "ptr", 0, "ptr")
        }
    }
    return 0
}

; 토글 기능 (Win + ScrollLock)
#ScrollLock:: {
global isActive, guiTooltip
isActive := !isActive
if (!isActive) {
if (guiTooltip) {
try {
guiTooltip.Destroy()
}
guiTooltip := ""
}
}
}

; 메인 루프 (개선)
Loop {
    global isActive, lastMouseX, lastMouseY, lastImeState, lastCacheUpdate
    if (!isActive) {
        Sleep(100)
        continue
    }

    ; 절대 좌표로 마우스 위치 가져오기
    mousePos := GetAbsoluteMousePos()
    mouseX := mousePos.x
    mouseY := mousePos.y
    imeState := GetImeState()

    ; 좌표나 IME 상태가 변경되었을 때만 업데이트
    if (mouseX != lastMouseX || mouseY != lastMouseY || imeState != lastImeState) {
        ; 모니터 정보 주기적으로 갱신 (해상도 변경 대응)
        if (A_TickCount - lastCacheUpdate > 5000) {  ; 5초마다
            CacheMonitorInfo()
            lastCacheUpdate := A_TickCount
        }
        
        ; 한영 상태 표시
        tooltipText := (imeState = 1) ? "가" : "A"
        ShowCustomTooltip(tooltipText)
        lastMouseX := mouseX
        lastMouseY := mouseY
        lastImeState := imeState
    }
    Sleep(50)
}

; 종료 시 정리
OnExit(CleanupOnExit)

CleanupOnExit(*) {
global guiTooltip
if (guiTooltip) {
try {
guiTooltip.Destroy()
}
}
}