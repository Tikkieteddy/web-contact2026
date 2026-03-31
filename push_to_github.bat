@echo off
chcp 65001 >/dev/null
echo ============================================
echo   Push to GitHub - web-contact2026
echo ============================================
echo.

cd /d "%~dp0"

echo [1/5] Initializing git repository...
git init
echo.

echo [2/5] Adding all files...
git add .
echo.

echo [3/5] Creating first commit...
git commit -m "Initial commit: ABC7 and NDC57 Contact Directory"
echo.

echo [4/5] Setting up remote...
git branch -M main
git remote add origin https://github.com/Tikkieteddy/web-contact2026.git 2>/dev/null
git remote set-url origin https://github.com/Tikkieteddy/web-contact2026.git
echo.

echo [5/5] Pushing to GitHub...
git push -u origin main
echo.

echo ============================================
echo   DONE!
echo.
echo   Next: Enable GitHub Pages
echo   1. Go to: https://github.com/Tikkieteddy/web-contact2026/settings/pages
echo   2. Source: Deploy from a branch
echo   3. Branch: main  /  / (root)
echo   4. Click Save
echo.
echo   Your site will be at:
echo   https://tikkieteddy.github.io/web-contact2026/
echo ============================================
echo.
pause
