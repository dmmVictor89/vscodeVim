Set objShell = CreateObject("WScript.Shell")
strUserProfile = objShell.ExpandEnvironmentStrings("%USERPROFILE%")
strBatPath = strUserProfile & "\AppData\Local\nvim\Scrolling_Marquee\configure_screensaver.bat"
objShell.Run Chr(34) & strBatPath & Chr(34), 0, True