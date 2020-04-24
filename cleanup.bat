@echo off
title Jancox Tool 2.0 (Cleanup)
cls
echo                           Jancox Tool by wahyu6070
echo.
echo              Cleanup
echo.
echo - Cleaning
if exist editor rd /s /q editor
if exist bin\tmp rd /s /q bin\tmp
if exist new_rom.zip del new_rom.zip
echo - Done
echo.
pause