@echo off
setlocal

REM bat 파일 위치로 작업 폴더 이동
cd /d "%~dp0"

REM Alacritty 실행
start "" "%~dp0Alacritty-v0.16.1-portable.exe" --config-file "%~dp0Alacritty.toml" --title "Alacritty"

endlocal
