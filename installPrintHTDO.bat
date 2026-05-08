@echo off
title CAI MAY IN TU DONG QUA IP
setlocal EnableDelayedExpansion

:: === KIEM TRA QUYEN ADMIN ===
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo VUI LONG CHAY FILE NAY BANG QUYEN ADMIN!
    pause
    exit /b
)

:: === CAU HINH MAY IN ===
set "printer1.name=MAY IN PHU KIEN"
set "printer1.ip=192.168.12.151"
set "printer1.link=https://github.com/biconomi/printHTDO/releases/download/v1.0/HL-L2360DW.zip"
set "printer1.zip=HL-L2360DW.zip"
set "printer1.folder=HL-L2360DW"
set "printer1.inf=HL-L2360DW\HL-L2360DW\32_64\BROHL13A.INF"
set "printer1.model=Brother HL-L2360D series"

set "printer2.name=MAY IN KINH DOANH"
set "printer2.ip=192.168.12.68"
set "printer2.link=https://github.com/biconomi/printHTDO/releases/download/v1.0/rico3353_z04162L16.zip"
set "printer2.zip=rico3353_z04162L16.zip"
set "printer2.folder=rico3353_z04162L16"
set "printer2.inf=rico3353_z04162L16\z04162L16\disk1\MPC3003_.inf"
set "printer2.model=RICOH MP C3003 PCL 6"

set "printer3.name=MAY IN DICH VU"
set "printer3.ip=192.168.12.9"
set "printer3.link=https://github.com/biconomi/printHTDO/releases/download/v1.0/rico3353_z04162L16.zip"
set "printer3.zip=rico3353_z04162L16.zip"
set "printer3.folder=rico3353_z04162L16"
set "printer3.inf=rico3353_z04162L16\z04162L16\disk1\MPC3003_.inf"
set "printer3.model=RICOH MP C3003 PCL 6"

set "printer4.name=KE TOAN MF260"
set "printer4.ip=192.168.12.150"
set "printer4.link=https://github.com/biconomi/printHTDO/releases/download/v1.0/MF260MFDriverV6101WP.zip"
set "printer4.zip=MF260MFDriverV6101WP.zip"
set "printer4.folder=MF260MFDriverV6101WP"
set "printer4.inf=MF260MFDriverV6101WP\MF260MFDriverV6101WP\CNLB0MA64.INF"
set "printer4.model=Canon MF260 Series UFRII LT"

:: === MAY IN MARKETING ===
set "printer5.name=MAY IN MARKETING"
set "printer5.ip=10.0.0.11"
set "printer5.link=https://github.com/biconomi/printHTDO/releases/download/v1.0/HL-L2360DW.zip"
set "printer5.zip=HL-L2360DW.zip"
set "printer5.folder=HL-L2360DW"
set "printer5.inf=HL-L2360DW\HL-L2360DW\32_64\BROHL13A.INF"
set "printer5.model=Brother HL-L2360D series"

set DOWNLOAD_DIR=C:\temp

:MAIN_MENU
echo.
echo =============================
echo  CHON CHUC NANG:
echo =============================
echo 1. Cai dat may in
echo 2. Xoa may in
echo 0. Thoat
echo =============================
set /p mainChoice=Nhap so [0-2]:

if "%mainChoice%"=="1" goto INSTALL_MENU
if "%mainChoice%"=="2" goto DELETE_PRINTER
if "%mainChoice%"=="0" exit /b

echo Lua chon khong hop le.
pause
goto MAIN_MENU

:INSTALL_MENU
echo.
echo =============================
echo  CHON MAY IN DE CAI DAT:
echo =============================
echo 1. MAY IN PHU KIEN (KHOA)
echo 2. MAY IN KINH DOANH (PHOTO)
echo 3. MAY IN DICH VU (PHOTO)
echo 4. MAY IN KE TOAN (MF260)
echo 5. MAY IN MARKETING
echo 0. Quay lai
echo =============================
set /p choice=Nhap so [0-5]:

if "%choice%"=="1" (
    set "PRINTER_NAME=!printer1.name!"
    set "PRINTER_IP=!printer1.ip!"
    set "PRINTER_LINK=!printer1.link!"
    set "PRINTER_ZIP=!printer1.zip!"
    set "PRINTER_FOLDER=!printer1.folder!"
    set "PRINTER_INF=!printer1.inf!"
    set "PRINTER_MODEL=!printer1.model!"
) else if "%choice%"=="2" (
    set "PRINTER_NAME=!printer2.name!"
    set "PRINTER_IP=!printer2.ip!"
    set "PRINTER_LINK=!printer2.link!"
    set "PRINTER_ZIP=!printer2.zip!"
    set "PRINTER_FOLDER=!printer2.folder!"
    set "PRINTER_INF=!printer2.inf!"
    set "PRINTER_MODEL=!printer2.model!"
) else if "%choice%"=="3" (
    set "PRINTER_NAME=!printer3.name!"
    set "PRINTER_IP=!printer3.ip!"
    set "PRINTER_LINK=!printer3.link!"
    set "PRINTER_ZIP=!printer3.zip!"
    set "PRINTER_FOLDER=!printer3.folder!"
    set "PRINTER_INF=!printer3.inf!"
    set "PRINTER_MODEL=!printer3.model!"
) else if "%choice%"=="4" (
    set "PRINTER_NAME=!printer4.name!"
    set "PRINTER_IP=!printer4.ip!"
    set "PRINTER_LINK=!printer4.link!"
    set "PRINTER_ZIP=!printer4.zip!"
    set "PRINTER_FOLDER=!printer4.folder!"
    set "PRINTER_INF=!printer4.inf!"
    set "PRINTER_MODEL=!printer4.model!"
) else if "%choice%"=="5" (
    set "PRINTER_NAME=!printer5.name!"
    set "PRINTER_IP=!printer5.ip!"
    set "PRINTER_LINK=!printer5.link!"
    set "PRINTER_ZIP=!printer5.zip!"
    set "PRINTER_FOLDER=!printer5.folder!"
    set "PRINTER_INF=!printer5.inf!"
    set "PRINTER_MODEL=!printer5.model!"
) else if "%choice%"=="0" (
    goto MAIN_MENU
) else (
    echo Loi: Lua chon khong hop le.
    pause
    goto INSTALL_MENU
)

echo.
echo May in: %PRINTER_NAME%
echo IP:     %PRINTER_IP%
echo ----------------------------
choice /M "Ban co muon tiep tuc cai may in nay khong?"
if errorlevel 2 (
    echo Da huy.
    pause
    goto INSTALL_MENU
)

:: === TAI DRIVER ===
echo Dang tai driver...
if exist "%DOWNLOAD_DIR%" rmdir /s /q "%DOWNLOAD_DIR%"
mkdir "%DOWNLOAD_DIR%"
powershell -Command "Invoke-WebRequest -Uri '%PRINTER_LINK%' -OutFile '%DOWNLOAD_DIR%\%PRINTER_ZIP%'"

if not exist "%DOWNLOAD_DIR%\%PRINTER_ZIP%" (
    echo Loi: Khong tai duoc driver.
    pause
    goto INSTALL_MENU
)

:: === GIAI NEN ===
echo Dang giai nen driver...
powershell -Command "Expand-Archive -Path '%DOWNLOAD_DIR%\%PRINTER_ZIP%' -DestinationPath '%DOWNLOAD_DIR%\%PRINTER_FOLDER%' -Force"

set "INF_PATH=%DOWNLOAD_DIR%\%PRINTER_INF%"
if not exist "!INF_PATH!" (
    echo Loi: Khong tim thay file INF: !INF_PATH!
    pause
    goto INSTALL_MENU
)

:: === TAO CONG IP ===
echo Tao cong IP: %PRINTER_IP%
cscript %WINDIR%\System32\Printing_Admin_Scripts\en-US\prnport.vbs -a -r IP_%PRINTER_IP% -h %PRINTER_IP% -o raw -n 9100

:: === CAI DRIVER ===
echo Dang dang ky driver...
pnputil /add-driver "!INF_PATH!" /install

echo Dang cai may in: %PRINTER_NAME%...
rundll32 printui.dll,PrintUIEntry /if /b "%PRINTER_NAME%" /f "!INF_PATH!" /r "IP_%PRINTER_IP%" /m "%PRINTER_MODEL%"

echo.
echo Da cai dat xong: %PRINTER_NAME% (IP: %PRINTER_IP%)

:: Xoa thu muc tam
rmdir /s /q "%DOWNLOAD_DIR%"

pause
goto MAIN_MENU

:DELETE_PRINTER
echo.
echo Dang lay danh sach may in...

setlocal enabledelayedexpansion
set count=0

for /f "delims=" %%i in ('powershell -Command "Get-Printer | Select-Object -ExpandProperty Name"') do (
    set /a count+=1
    set "printer[!count!]=%%i"
    echo !count!. %%i
)

if !count! EQU 0 (
    echo Khong tim thay may in nao.
    pause
    goto MAIN_MENU
)

echo.
set /p delChoice=Nhap so thu tu may in muon xoa [1-!count!]:
if not defined printer[%delChoice%] (
    echo Lua chon khong hop le.
    pause
    goto MAIN_MENU
)

set "printerToDelete=!printer[%delChoice%]!"
echo.
echo Ban da chon: !printerToDelete!

choice /M "Ban co muon xoa may in nay khong"
if errorlevel 2 (
    echo Da huy xoa.
    pause
    goto MAIN_MENU
)

echo Dang xoa may in...
rundll32 printui.dll,PrintUIEntry /dl /n "!printerToDelete!"
echo Da xoa xong.

pause
goto MAIN_MENU
