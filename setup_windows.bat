@echo off
setlocal
cd /d "%~dp0"
if not exist .venv (
  py -m venv .venv 2>nul
  if errorlevel 1 python -m venv .venv
)
call .venv\Scripts\activate
python -m pip install --upgrade pip
pip install -r requirements.txt
echo.
echo Setup complete.
echo Run the app with: run_openplane.bat
pause
