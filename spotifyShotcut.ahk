; ########################################
; Control+Shift+Win+F1
; ^+#F1:: SendInput {Media_Play_Pause}

; Control+Shift+Win+F2
; ^+#F3:: SendInput {Media_Prev}
; #F2:: SendInput {Media_Next}

; Control+Shift+Win+F3
;^+#F3:: SendInput {Media_Next}
    
; #F2:: Send {Media_Next}
#F2::Send("{Media_Next}")
; #F3:: SaveSongToSpotifyLibrary()
#F3:: SaveSongToSpotifyLike()

SaveSongToSpotifyLike() {
    spotify := "ahk_exe spotify.exe"

    if WinExist(spotify) {

        ; 현재 창 ID와 마우스 위치 저장
        x := 0
        y := 0
        startingWinId := WinGetID("A")

        ; 마우스 위치 가져오기
        MouseGetPos(&x, &y)
        ; Spotify 활성화
        ; WinActivate(spotify)
        ; WinWaitActive(spotify)

        Send("#2")  ; # = Window

        WinWaitActive(spotify)

        ; MouseMove(360, 900)
        Sleep(200)
        ; Click(360, 900)

        clickX := 100
        clickY := 955
        Click(clickX, clickY, "Left", 2)

        ; Alt+Shift+b 전송
        ; Send("!+B")  ; ! = Alt, + = Shift

        Sleep(300)
        Send("{Alt Down}{Shift Down}b{Shift Up}{Alt Up}")

        Sleep(300)

        ; 원래 창과 마우스 위치 복원
        WinActivate("ahk_id " startingWinId)
        MouseMove(x, y)

        WinMinimize(spotify)

    }
}

; Loop {
;     ; 현재 마우스 좌표 가져오기
;     MouseGetPos(&x, &y)
; 
;     ; Tooltip 표시
;     ToolTip("마우스 위치: X=" x " Y=" y, x+20, y+20)
; 
;     ; 0.1초 대기
;     Sleep(100)
; }

SaveSongToSpotifyLibrary() {
    spotify := "ahk_exe spotify.exe"
    if WinExist(spotify) {
        ; 현재 창 ID와 마우스 위치 저장
        x := 0
        y := 0
        startingWinId := WinGetID("A")

        ; 마우스 위치 가져오기
        MouseGetPos(&x, &y)

        ; Spotify 활성화
        WinActivate(spotify)
        WinWaitActive(spotify)

        saveToYourLibraryIcon := A_WorkingDir "\apps\SpotifyController\SaveToYourLibraryIcon.png"

        ; ImageSearch 호출 시 참조 변수 사용
        ErrorLevel := ImageSearch(&FoundX, &FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, saveToYourLibraryIcon)

        if (ErrorLevel == 0) {
            Click(FoundX, FoundY)
        } else if (ErrorLevel == 2) {
            MsgBox("Problem conducting image search. Is the saveToYourLibraryIcon in the correct location?")
        } else if (ErrorLevel == 1) {
            MsgBox("Unable to save song. Can't find the Add button.")
        }

        ; 원래 창과 마우스 위치 복원
        WinActivate("ahk_id " startingWinId)
        MouseMove(x, y)
    }
}
