@echo off
title Jancox Tool 2.0 (Unpack)
cls
echo                           Jancox Tool by wahyu6070
echo.
echo              Unpack
echo.
if exist bin\tmp rd /s /q bin\tmp
if exist editor rd /s /q editor
if not exist bin\tmp mkdir bin\tmp
if not exist editor mkdir editor
if exist input.zip (
echo - Unpack input.zip
bin\windows\busybox unzip -o input.zip -d bin\tmp >nul
) else (
echo input.zip not found
)

if exist bin\tmp\system.new.dat.br (
echo - Unpack system.new.dat.br
bin\windows\brotli -d bin\tmp\system.new.dat.br >nul
del bin\tmp\system.new.dat.br
)
if exist bin\tmp\vendor.new.dat.br (
echo - Unpack vendor.new.dat.br
bin\windows\brotli -d bin\tmp\vendor.new.dat.br >nul
del bin\tmp\vendor.new.dat.br
)

if exist bin\tmp\system.new.dat (
echo - Unpack system.new.dat
bin\windows\sdat2img bin\tmp\system.transfer.list bin\tmp\system.new.dat bin\tmp\system.img >nul 2>nul
del bin\tmp\system.new.dat
del bin\tmp\system.transfer.list
del bin\tmp\system.patch.dat
)

if exist bin\tmp\vendor.new.dat (
echo - Unpack vendor.new.dat
bin\windows\sdat2img bin\tmp\vendor.transfer.list bin\tmp\vendor.new.dat bin\tmp\vendor.img >nul 2>nul
del bin\tmp\vendor.new.dat
del bin\tmp\vendor.transfer.list
del bin\tmp\vendor.patch.dat
)

if exist bin\tmp\system.img (
echo - Unpack system.img
bin\windows\imgextractor bin\tmp\system.img editor\system >nul 2>nul
del bin\tmp\system.img
)

if exist bin\tmp\vendor.img (
echo - Unpack vendor.img
bin\windows\imgextractor bin\tmp\vendor.img editor\vendor >nul 2>nul
del bin\tmp\vendor.img
)

set tmp=bin\tmp
if exist %tmp%\system_file_contexts move /y %tmp%\system_file_contexts editor\  >nul 2>nul
if exist %tmp%\vendor_file_contexts move /y %tmp%\vendor_file_contexts editor\  >nul 2>nul
if exist %tmp%\system_fs_config move /y %tmp%\system_fs_config editor\  >nul 2>nul
if exist %tmp%\vendor_fs_config move /y %tmp%\vendor_fs_config editor\  >nul 2>nul
if exist %tmp%\boot.img move /y %tmp%\boot.img editor\  >nul 2>nul
if exist %tmp%\compatibility.zip move /y %tmp%\compatibility.zip editor  >nul 2>nul
if exist %tmp%\compatibility_no_nfc.zip move /y %tmp%\compatibility_no_nfc.zip editor\  >nul 2>nul
if exist %tmp%\install move /y %tmp%\install editor\install  >nul 2>nul
if exist %tmp%\firmware-update move /y %tmp%\firmware-update editor\  >nul 2>nul
if exist %tmp%\META-INF move /y %tmp%\META-INF editor\  >nul 2>nul
if exist %tmp%\system move /y %tmp%\system editor\system2  >nul 2>nul

if exist editor\system (
echo - Unpack Done
echo.
bin\windows\busybox sh ./bin/windows/utility.sh rom-info
bin\windows\busybox sh ./bin/windows/utility.sh rom-info >> editor/rom-info
echo.
)
if exist editor rd /s /q bin\tmp
pause