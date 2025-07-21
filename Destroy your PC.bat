@echo off
title Destroy Your PC Launcher
color 0C

echo WARNING: You are about to run Destroy Your PC. Made by Klaas2811.
echo It will install the payload and activate it after reboot.
echo.
set /p answer=Are you sure? Type "yes" to continue: 

if /i not "%answer%"=="yes" (
    echo Cancelled. No damage done.
    pause
    exit
)

echo Installing payload...
copy "%~dp0payload.bat" "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\payload.bat" >nul

echo.
echo Payload installed successfully.
echo Rebooting system to activate it...
shutdown -r -t 3 -c "Destroy Your PC is now active"
exit
