@echo off
setlocal
cd /d "%~dp0"
python run_openplane.py
if errorlevel 1 (
  echo.
  echo openPLANE exited with an error.
  pause
)
