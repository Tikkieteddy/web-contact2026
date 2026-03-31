@echo off
chcp 65001 >nul
echo ============================================
echo   Setup and Push to GitHub
echo   web-contact2026
echo ============================================
echo.

cd /d "%~dp0"

echo [1/6] Copying images from original folder...
set "SRC=C:\Users\TIKKIE\Desktop\web_contact_K.Ongard-20260330T035608Z-1-001\web_contact_K.Ongard\image_ndc57_abc7"

if not exist "%SRC%" (
    echo ERROR: Source image folder not found!
    echo Expected: %SRC%
    pause
    exit /b 1
)

xcopy "%SRC%\abc7\*.*" "image_ndc57_abc7\abc7\" /E /I /Y /Q
xcopy "%SRC%\ndc57\*.*" "image_ndc57_abc7\ndc57\" /E /I /Y /Q
echo Images copied successfully!
echo.

echo [2/6] Initializing git repository...
git init
echo.

echo [3/6] Adding all files...
git add .
echo.

echo [4/6] Creating commit...
git commit -m "Initial commit: ABC7 and NDC57 Contact Directory"
echo.

echo [5/6] Setting up remote...
git branch -M main
git remote add origin https://github.com/Tikkieteddy/web-contact2026.git 2>nul
git remote set-url origin https://github.com/Tikkieteddy/web-contact2026.git
echo.

echo [6/6] Pushing to GitHub...
git push -u origin main
echo.

echo ============================================
echo   DONE! All files uploaded to GitHub.
echo.
echo   Next step - Enable GitHub Pages:
echo   1. Open: https://github.com/Tikkieteddy/web-contact2026/settings/pages
echo   2. Source: Deploy from a branch
echo   3. Branch: main  /  root
echo   4. Click Save
echo.
echo   Your site will be live at:
echo   https://tikkieteddy.github.io/web-contact2026/
echo ============================================
echo.
pause
