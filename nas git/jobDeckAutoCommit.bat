@echo off
setlocal EnableDelayedExpansion

:: 작업 디렉토리 설정 및 확인
cd /d "C:\Users\이진표\Documents\jobDeck\"
if %ERRORLEVEL% neq 0 (
    echo Failed to change directory to C:\Users\이진표\Documents\jobDeck\ >> C:\git_log.txt
    exit /b %ERRORLEVEL%
)
echo Current directory: %cd% >> C:\git_log.txt

:: 날짜 설정 (공백 제거)
for /f "tokens=*" %%i in ('powershell -command "Get-Date -Format yyyy-MM-dd"') do set TODAY=%%i
set TODAY=%TODAY: =%
echo Commit date: %TODAY% >> C:\git_log.txt

:: Git 명령어 실행
git add .
if %ERRORLEVEL% neq 0 (
    echo git add failed >> C:\git_log.txt
    exit /b %ERRORLEVEL%
)
echo git add completed >> C:\git_log.txt

git commit -am "%TODAY%"
if %ERRORLEVEL% neq 0 (
    echo git commit failed >> C:\git_log.txt
    exit /b %ERRORLEVEL%
)
echo git commit completed >> C:\git_log.txt

git push
if %ERRORLEVEL% neq 0 (
    echo git push failed >> C:\git_log.txt
    exit /b %ERRORLEVEL%
)
echo git push completed >> C:\git_log.txt

:: 커밋 상태 확인
git status >> C:\git_log.txt