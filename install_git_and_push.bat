@echo off
chcp 65001 >nul
echo ============================================
echo   Install Git + Push to GitHub
echo ============================================
echo.

:: Check if Git is already installed
where git >nul 2>nul
if %ERRORLEVEL%==0 (
    echo Git is already installed!
    goto :DO_PUSH
)

echo Git is not installed. Downloading Git for Windows...
echo.

:: Download Git installer using PowerShell
powershell -Command "& {[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -Uri 'https://github.com/git-for-windows/git/releases/download/v2.47.1.windows.2/Git-2.47.1.2-64-bit.exe' -OutFile '%TEMP%\GitInstaller.exe' -UseBasicParsing}"

if not exist "%TEMP%\GitInstaller.exe" (
    echo Download failed. Please install Git manually:
    echo https://git-scm.com/download/win
    pause
    exit /b 1
)

echo Download complete! Installing Git silently...
echo (This may take 1-2 minutes)
echo.

:: Silent install
"%TEMP%\GitInstaller.exe" /VERYSILENT /NORESTART /NOCANCEL /SP- /CLOSEAPPLICATIONS /RESTARTAPPLICATIONS /COMPONENTS="icons,ext\reg\shellhere,assoc,assoc_sh"

:: Wait for install to finish
timeout /t 5 /nobreak >nul

:: Refresh PATH
set "PATH=%PATH%;C:\Program Files\Git\cmd;C:\Program Files\Git\bin"

:: Verify
where git >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    set "PATH=%PATH%;C:\Program Files\Git\cmd"
)

echo Git installed successfully!
echo.

:DO_PUSH
cd /d "%~dp0"

echo [1/6] Copying images from original folder...
set "SRC=C:\Users\TIKKIE\Desktop\web_contact_K.Ongard-20260330T035608Z-1-001\web_contact_K.Ongard\image_ndc57_abc7"

if exist "%SRC%" (
    xcopy "%SRC%\abc7\*.*" "image_ndc57_abc7\abc7\" /E /I /Y /Q
    xcopy "%SRC%\ndc57\*.*" "image_ndc57_abc7\ndc57\" /E /I /Y /Q
    echo Images copied!
) else (
    echo Warning: Source images not found at %SRC%
    echo Skipping image copy...
)
echo.

echo [2/6] Initializing git repository...
"C:\Program Files\Git\cmd\git.exe" init
echo.

echo [3/6] Configuring git...
"C:\Program Files\Git\cmd\git.exe" config user.email "tkkithman@gmail.com"
"C:\Program Files\Git\cmd\git.exe" config user.name "Tikkieteddy"
echo.

echo [4/6] Adding all files...
"C:\Program Files\Git\cmd\git.exe" add .
echo.

echo [5/6] Creating commit...
"C:\Program Files\Git\cmd\git.exe" commit -m "Initial commit: ABC7 and NDC57 Contact Directory"
echo.

echo [6/6] Pushing to GitHub...
"C:\Program Files\Git\cmd\git.exe" branch -M main
"C:\Program Files\Git\cmd\git.exe" remote add origin https://github.com/Tikkieteddy/web-contact2026.git 2>nul
"C:\Program Files\Git\cmd\git.exe" remote set-url origin https://github.com/Tikkieteddy/web-contact2026.git
"C:\Program Files\Git\cmd\git.exe" push -u origin main
echo.

echo ============================================
echo   DONE!
echo.
echo   Next: Enable GitHub Pages
echo   1. Open: https://github.com/Tikkieteddy/web-contact2026/settings/pages
echo   2. Source: Deploy from a branch
echo   3. Branch: main / root
echo   4. Click Save
echo.
echo   Your site: https://tikkieteddy.github.io/web-contact2026/
echo ============================================
echo.
pause
