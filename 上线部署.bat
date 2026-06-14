@echo off
chcp 65001 >nul
cd /d "%~dp0"
echo Aureon Global · Deploying...
echo.

:: Push to GitHub
curl -s -o nul -w "%%{http_code}" --connect-timeout 3 https://github.com >nul 2>&1
if %errorlevel%==0 (
    echo [OK] GitHub connected
    git init >nul 2>&1
    git checkout -b main >nul 2>&1
    git add -A >nul 2>&1
    git config user.email "deploy@aureon-trading.com" >nul 2>&1
    git config user.name "Aureon Deploy" >nul 2>&1
    git commit -m "deploy %date%" >nul 2>&1
    git remote remove origin >nul 2>&1
    git remote add origin https://github.com/fhao40002-jpg/aureon.git >nul 2>&1
    git push -u origin main --force >nul 2>&1
    if %errorlevel%==0 (
        echo [OK] LIVE: https://fhao40002-jpg.github.io/aureon/
    ) else (
        echo [FAIL] Push failed, try Netlify backup...
        goto netlify
    )
) else (
    echo [!] GitHub unreachable, try Netlify...
    goto netlify
)
goto end

:netlify
echo [!] Register Netlify first (free)
echo     Open: https://app.netlify.com/signup
start https://app.netlify.com/drop
echo     Drag this folder into the browser window -> 30s online
echo     Folder: %~dp0
pause
goto end

:end
echo.
echo Done!
pause
