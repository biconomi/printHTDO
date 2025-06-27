@echo off
setlocal

set "FOLDER=C:\print"
set "URL=https://raw.githubusercontent.com/biconomi/printHTDO/main%%29/installPrintHTDO.bat"
set "FILE=%FOLDER%\installPrintHTDO.bat"

:: Tạo thư mục nếu chưa có
if not exist "%FOLDER%" mkdir "%FOLDER%"

:: Tải file từ GitHub
powershell -Command "Invoke-WebRequest -Uri '%URL%' -OutFile '%FILE%'"

:: Kiểm tra nếu tải thành công
if exist "%FILE%" (
    echo Dang chay script cai dat...
    call "%FILE%"

    echo Dang xoa thu muc tam...
    rmdir /s /q "%FOLDER%"
) else (
    echo Loi: Khong tai duoc file script.
)

pause
