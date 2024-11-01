#Requires AutoHotkey v2.0

; Capslock을 Ctrl로 재맵핑
Capslock::Ctrl

; Ctrl을 Enter로 재맵핑
Ctrl::Enter

; Tab 키를 단독으로 사용할 때 정상적으로 작동하도록 설정
; Tab::Send("{Tab}")
;Tab::Send("{ESC}")
;ESC::Send("{Tab}")

; Tab + d 키 조합 핫키 정의
Tab & d::Send("{Del}")
Tab & u::Send("{Home}")
Tab & i::Send("{End}")
Tab & j::Send("{Left}")
Tab & k::Send("{Down}")
Tab & l::Send("{Up}")
Tab & `;::Send("{Right}")
Tab & 7::Send("{PgUp}")
Tab & 8::Send("{PgDn}")
Tab & Del::Send("{Capslock}")
Tab & 9::Send("{BS}")
Tab & 0::Send("{Del}")

; SPACE + d 키 조합 핫키 정의
;SPACE::Send("{SPACE}")

;SPACE & d::Send("{Del}")
;SPACE & u::Send("{Home}")
;SPACE & i::Send("{End}")
;SPACE & j::Send("{Left}")
;SPACE & k::Send("{Down}")
;SPACE & l::Send("{Up}")
;SPACE & `;::Send("{Right}")
;SPACE & 7::Send("{PgUp}")
;SPACE & 8::Send("{PgDn}")
;SPACE & Del::Send("{Capslock}")
;SPACE & 9::Send("{BS}")
;SPACE & 0::Send("{Del}")


!Tab::
{
    Send("{Alt down}{Tab}{Alt up}")
}
return