Set objShell = CreateObject("WScript.Shell")
strUserProfile = objShell.ExpandEnvironmentStrings("%USERPROFILE%")
strPath = strUserProfile & "\AppData\Local\nvim\Scrolling_Marquee\Scrolling Marquee.scr"
strCommand = Chr(34) & strPath & Chr(34) & " /c"
objShell.Run strCommand, 0, True