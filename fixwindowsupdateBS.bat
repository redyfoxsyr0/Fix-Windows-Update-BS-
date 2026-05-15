@echo off
title Aggressive Windows Update Reset

echo Killing update processes first...
taskkill /f /im TiWorker.exe >nul 2>&1
taskkill /f /im TrustedInstaller.exe >nul 2>&1
taskkill /f /im UsoClient.exe >nul 2>&1
taskkill /f /im MoUsoCoreWorker.exe >nul 2>&1
taskkill /f /im svchost.exe /fi "services eq wuauserv" >nul 2>&1
taskkill /f /im svchost.exe /fi "services eq bits" >nul 2>&1
taskkill /f /im svchost.exe /fi "services eq cryptsvc" >nul 2>&1

timeout /t 2 /nobreak >nul

echo Stopping services...
net stop wuauserv /y
net stop bits /y
net stop cryptsvc /y
net stop appidsvc /y

timeout /t 2 /nobreak >nul

echo Renaming update folders...
takeown /f "%windir%\SoftwareDistribution" /r /d y >nul 2>&1
icacls "%windir%\SoftwareDistribution" /grant administrators:F /t >nul 2>&1

takeown /f "%windir%\System32\catroot2" /r /d y >nul 2>&1
icacls "%windir%\System32\catroot2" /grant administrators:F /t >nul 2>&1

ren "%windir%\SoftwareDistribution" SoftwareDistribution.old
ren "%windir%\System32\catroot2" catroot2.old

echo Restarting services...
net start cryptsvc
net start bits
net start wuauserv
net start appidsvc

echo Done.
pause
