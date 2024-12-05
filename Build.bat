@echo off
call "%~dp0\tools\build\build.bat" %*
rem pause
rem pausing is just annoying, don't

:: Below code added by Lucky on 12/5/24, to let me review errors and delay window closing.
echo Press any key to close this window.
pause > nul
