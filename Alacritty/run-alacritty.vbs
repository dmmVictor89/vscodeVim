Set WshShell = CreateObject("WScript.Shell")
WshShell.Run Chr(34) & "run-alacritty.bat" & Chr(34), 0
Set WshShell = Nothing
