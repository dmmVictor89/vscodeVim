@echo off
setlocal EnableDelayedExpansion

:: �۾� ���丮 ���� �� Ȯ��
cd /d "C:\Users\����ǥ\Documents\jobDeck\"
if %ERRORLEVEL% neq 0 (
    echo Failed to change directory to C:\Users\����ǥ\Documents\jobDeck\ >> C:\git_log.txt
    exit /b %ERRORLEVEL%
)
echo Current directory: %cd% >> C:\git_log.txt

:: ��¥ ���� (���� ����)
for /f "tokens=*" %%i in ('powershell -command "Get-Date -Format yyyy-MM-dd"') do set TODAY=%%i
set TODAY=%TODAY: =%
echo Commit date: %TODAY% >> C:\git_log.txt

:: Git ��ɾ� ����
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

:: Ŀ�� ���� Ȯ��
git status >> C:\git_log.txt