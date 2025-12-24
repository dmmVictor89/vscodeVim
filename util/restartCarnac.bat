@echo off
echo Carnac ended
taskkill /f /im carnac.exe >nul 2>&1
echo Carnac restarting
start "" "C:\Users\jinpyo\AppData\Local\carnac\Carnac.exe"
echo Carnac restarted
exit