
@echo off
title FIXTOOL AIO - Cong cu sua loi may tinh
color 0a
mode con: cols=85 lines=30

:MENU
cls
echo ================== FIXTOOL AIO ====================
echo [1] Cong cu sua loi MAY IN
echo [2] Cong cu sua loi MANG LAN & INTERNET
echo [3] Cong cu HE THONG (System Tools)
echo [0] Thoat chuong trinh
echo ===================================================
set /p menuChoice=Nhap lua chon: 
if "%menuChoice%"=="1" goto PRINTER_MENU
if "%menuChoice%"=="2" goto NETWORK_MENU
if "%menuChoice%"=="3" goto SYSTEM_MENU
if "%menuChoice%"=="0" exit
goto MENU

:PRINTER_MENU
cls
echo -------- CONG CU MAY IN ----------
echo [1] Xoa tat ca may in tren may tinh
echo [2] Restart dich vu may in
echo [9] Quay lai menu chinh
echo ----------------------------------
set /p printerChoice=Nhap lua chon: 
if "%printerChoice%"=="1" goto RemovePrinters
if "%printerChoice%"=="2" goto RestartPrinterSpooler
if "%printerChoice%"=="9" goto MENU
goto PRINTER_MENU

:RemovePrinters
echo Dang xoa may in...
cscript /nologo C:\Windows\System32\Printing_Admin_Scripts\en-US\prnmngr.vbs -x
echo Da xoa tat ca may in.
pause
goto PRINTER_MENU

:RestartPrinterSpooler
echo Dang khoi dong lai dich vu Print Spooler...
net stop spooler
net start spooler
echo Da restart xong dich vu in.
pause
goto PRINTER_MENU

:NETWORK_MENU
cls
echo -------- CONG CU MANG LAN --------
echo [1] Reset cau hinh mang
echo [2] Flush DNS va renew IP
echo [3] Mo trang cau hinh router
echo [9] Quay lai menu chinh
echo ----------------------------------
set /p networkChoice=Nhap lua chon: 
if "%networkChoice%"=="1" goto ResetNetwork
if "%networkChoice%"=="2" goto FlushDNS
if "%networkChoice%"=="3" start http://192.168.1.1 && goto NETWORK_MENU
if "%networkChoice%"=="9" goto MENU
goto NETWORK_MENU

:ResetNetwork
echo Dang reset cau hinh mang...
ipconfig /release
ipconfig /renew
netsh winsock reset
netsh int ip reset
echo Da reset xong mang LAN.
pause
goto NETWORK_MENU

:FlushDNS
echo Dang flush DNS...
ipconfig /flushdns
echo Da flush xong.
pause
goto NETWORK_MENU

:SYSTEM_MENU
cls
echo ------------- CONG CU HE THONG ----------------
echo [1] Don rac he thong (temp, prefetch)
echo [2] Tat phan mem khoi dong cung Windows
echo [3] Kiem tra va sua loi he thong (SFC/DISM)
echo [4] Restart dich vu Windows co ban
echo [5] Tat Windows Update vinh vien
echo [6] Vo hieu hoa Windows Defender
echo [9] Quay lai menu chinh
echo -----------------------------------------------
set /p sysChoice=Nhap lua chon: 

if "%sysChoice%"=="1" goto CleanJunk
if "%sysChoice%"=="2" goto DisableStartup
if "%sysChoice%"=="3" goto RepairSystem
if "%sysChoice%"=="4" goto RestartServices
if "%sysChoice%"=="5" goto DisableUpdate
if "%sysChoice%"=="6" goto DisableDefender
if "%sysChoice%"=="9" goto MENU
goto SYSTEM_MENU

:CleanJunk
echo Dang xoa cac file rac...
del /s /f /q "%temp%\*.*"
del /s /f /q "%windir%\Temp\*.*"
del /s /f /q "%SystemRoot%\Prefetch\*.*"
echo Da xoa rac xong.
pause
goto SYSTEM_MENU

:DisableStartup
echo Dang mo cau hinh startup...
start msconfig
echo Ban hay chon tab Startup de tat cac ung dung.
pause
goto SYSTEM_MENU

:RepairSystem
echo Dang chay SFC & DISM...
sfc /scannow
DISM /Online /Cleanup-Image /RestoreHealth
echo Da thuc hien xong viec kiem tra.
pause
goto SYSTEM_MENU

:RestartServices
echo Dang restart cac dich vu...
net stop wuauserv >nul
net start wuauserv >nul
net stop bits >nul
net start bits >nul
net stop cryptsvc >nul
net start cryptsvc >nul
echo Da restart xong cac dich vu co ban.
pause
goto SYSTEM_MENU

:DisableUpdate
echo Dang tat Windows Update...
net stop wuauserv
sc config wuauserv start= disabled
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v NoAutoUpdate /t REG_DWORD /d 1 /f
echo Da tat Windows Update thanh cong.
pause
goto SYSTEM_MENU

:DisableDefender
echo Dang vo hieu hoa Windows Defender...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v DisableAntiSpyware /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v DisableRealtimeMonitoring /t REG_DWORD /d 1 /f
sc stop WinDefend
sc config WinDefend start= disabled
echo Da vo hieu hoa Windows Defender.
pause
goto SYSTEM_MENU
