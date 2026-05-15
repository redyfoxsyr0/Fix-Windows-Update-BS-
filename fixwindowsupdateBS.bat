@echo off
title Windows Update Repair Fuck you windows ;)
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
echo Removing old backup folders...
rd /s /q "%windir%\SoftwareDistribution.old" >nul 2>&1
rd /s /q "%windir%\System32\catroot2.old" >nul 2>&1
echo Taking ownership...
takeown /f "%windir%\SoftwareDistribution" /r /d y >nul 2>&1
icacls "%windir%\SoftwareDistribution" /grant administrators:F /t >nul 2>&1
takeown /f "%windir%\System32\catroot2" /r /d y >nul 2>&1
icacls "%windir%\System32\catroot2" /grant administrators:F /t >nul 2>&1
echo Renaming update folders...
ren "%windir%\SoftwareDistribution" SoftwareDistribution.old
ren "%windir%\System32\catroot2" catroot2.old
echo Setting Delivery Optimization bypass mode...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization" ^
/v DODownloadMode ^
/t REG_DWORD ^
/d 100 ^
/f >nul 2>&1

echo Restarting services...

echo Restarting services...

net start cryptsvc
net start bits
net start wuauserv
net start appidsvc
echo Done. Restarting your PC...
timeout /t 2 /nobreak >nul
shutdown /r /f /t 0
pause
