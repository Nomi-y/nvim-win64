@echo off
setlocal
set "NVIMBIN=%~dp0bin"

if not exist "%NVIMBIN%\nvim.exe" (
    echo Could not find "%NVIMBIN%\nvim.exe".
    echo Keep this file inside the nvim-win64 folder.
    echo.
    pause
    exit /b 1
)

powershell -NoLogo -NoProfile -Command "$bin = $env:NVIMBIN; $user = [Environment]::GetEnvironmentVariable('Path', 'User'); if (-not $user) { $user = '' }; if (($user -split ';') -contains $bin) { Write-Host ('Already on PATH: ' + $bin) } else { [Environment]::SetEnvironmentVariable('Path', ($user.TrimEnd(';') + ';' + $bin), 'User'); Write-Host ('Added to PATH: ' + $bin) }"

if errorlevel 1 (
    echo.
    echo PowerShell did not run. Use method B or method C in README.txt.
    echo.
    pause
    exit /b 1
)

echo.
echo Close every terminal window. Open a new one.
echo Then type: nvim --version
echo.
pause
