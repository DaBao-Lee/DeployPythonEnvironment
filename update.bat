@echo off
setlocal enableextensions
cd /d "%~dp0"

rem Publish the deployment script: stage everything, commit with a dated
rem message, then push. Safe to re-run - a clean tree just skips the commit.
git add -A || goto :fail

set "STAMP="
for /f "usebackq delims=" %%i in (`powershell -NoProfile -Command "Get-Date -Format 'yyyy-MM-dd HH:mm'"`) do set "STAMP=%%i"
if not defined STAMP set "STAMP=manual"

git diff --cached --quiet
if errorlevel 1 (
    git commit -m "Update environment script (%STAMP%)" || goto :fail
) else (
    echo No local changes since the last commit, skipping commit.
)

git push origin HEAD || goto :fail

echo.
echo Published:
echo https://github.com/DaBao-Lee/DeployPythonEnvironment
echo Run setup.bat as administrator after the push finishes.
goto :end

:fail
echo.
echo Publish failed. Read the messages above, fix the cause, then run this file again.

:end
echo.
pause
