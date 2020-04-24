@echo off
title Jancox Tool 2.0 (Repack)
cls
if not exist editor\system (
echo - Please Unpack !!!
exit
)
cls
echo                           Jancox Tool by wahyu6070
echo.
echo              Repack
echo.
if exist editor\system (
bin\windows\busybox sh ./bin/windows/utility.sh rom-info
echo.
)
if exist new_rom.zip del new_rom.zip
if exist bin\tmp rd /s /q bin\tmp
mkdir bin\tmp

set /p systemsize=<"editor\system_size.txt"
echo - Repack system
bin\windows\make_ext4fs -s -L system -T -1 -S editor\system_file_contexts -C editor\system_fs_config -l %systemsize% -a system bin\tmp\system.img editor\system\ >nul
)

echo - Repack vendor
set /p vendorsize=<"editor\vendor_size.txt"
bin\windows\make_ext4fs -s -L vendor -T -1 -S editor\vendor_file_contexts -C editor\vendor_fs_config -l %vendorsize% -a vendor bin\tmp\vendor.img editor\vendor\ >nul

if exist bin\tmp\system.img (
echo - Repack system.img
bin\windows\img2sdat bin\tmp\system.img -o bin\tmp -v 4 >nul 2>nul
del bin\tmp\system.img
)

if exist bin\tmp\vendor.img (
echo - Repack vendor.img
bin\windows\img2sdat bin\tmp\vendor.img -o bin\tmp -v 4 -p vendor >nul 2>nul
del bin\tmp\vendor.img
)

if exist bin\tmp\system.new.dat (
echo - Repack system.new.dat
bin\windows\brotli -1 -j -w 24 bin\tmp\system.new.dat >nul
)

if exist bin\tmp\vendor.new.dat (
echo - Repack vendor.new.dat
bin\windows\brotli -1 -j -w 24 bin\tmp\vendor.new.dat >nul
)

set tmp=bin\tmp
if exist editor\boot.img copy /y editor\boot.img %tmp%\ >nul 2>nul
if exist editor\compatibility.zip copy /y editor\compatibility.zip %tmp% >nul
if exist editor\compatibility_no_nfc.zip copy /y editor\compatibility_no_nfc.zip %tmp% >nul
if exist editor\install xcopy /i /e /y editor\install %tmp%\install >nul 2>nul
if exist editor\firmware-update xcopy /i /e editor\firmware-update %tmp%\firmware-update >nul 2>nul
if exist editor\META-INF xcopy /i /e /y editor\META-INF %tmp%\META-INF >nul 2>nul
if exist editor\system2 xcopy /i /e /y editor\system2 %tmp%\system >nul 2>nul

if exist bin\tmp\META-INF (
echo - Zipping
bin\windows\7za a -tzip new_rom.zip ./bin/tmp/*  >nul 2>nul
)
if exist new_rom.zip echo - Done
if exist new_rom.zip rd /s /q bin\tmp
pause