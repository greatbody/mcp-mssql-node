@echo off
REM MCP MSSQL Node - Installation and Build Script for Windows
REM This script installs npm dependencies, builds the project, and shows the output path

echo.
echo 🚀 MCP MSSQL Node - Installation and Build Script
echo ==================================================

REM Check if Node.js is installed
where node >nul 2>nul
if %errorlevel% neq 0 (
    echo ❌ Node.js is not installed!
    echo Please install Node.js from https://nodejs.org/
    echo.
    echo Windows installation options:
    echo   1. Download installer from https://nodejs.org/
    echo   2. Using Chocolatey: choco install nodejs
    echo   3. Using Winget: winget install OpenJS.NodeJS
    echo.
    pause
    exit /b 1
)

REM Get Node.js version
for /f "tokens=*" %%i in ('node --version') do set NODE_VERSION=%%i
echo ✅ Node.js found: %NODE_VERSION%

REM Check if npm is installed
where npm >nul 2>nul
if %errorlevel% neq 0 (
    echo ❌ npm is not installed!
    echo npm usually comes with Node.js. Please reinstall Node.js.
    pause
    exit /b 1
)

REM Get npm version
for /f "tokens=*" %%i in ('npm --version') do set NPM_VERSION=%%i
echo ✅ npm found: %NPM_VERSION%

echo.
echo 📦 Installing dependencies...
call npm install
if %errorlevel% neq 0 (
    echo ❌ Failed to install dependencies!
    pause
    exit /b 1
)

echo.
echo 🔨 Building the project...
call npm run build
if %errorlevel% neq 0 (
    echo ❌ Build failed!
    pause
    exit /b 1
)

echo.
echo ✅ Build completed successfully!
echo.
echo 📄 Main executable file location:
echo    %cd%\dist\index.js
echo.
echo 🎯 You can copy this file to your desired location:
echo    copy "%cd%\dist\index.js" "C:\your\destination\path\"
echo.
echo 🚀 To run the server:
echo    node "%cd%\dist\index.js"
echo.
echo 📝 VS Code MCP Configuration:
echo Copy the following configuration to your VS Code .vscode/mcp.json file:
echo.
echo {
echo   "servers": {
echo     "mssql-nodejs": {
echo       "type": "stdio",
echo       "command": "node",
echo       "args": ["%cd%\dist\index.js"],
echo       "env": {
echo         "SERVER_NAME": "your-server-name.database.windows.net",
echo         "DATABASE_NAME": "your-database-name",
echo         "USERNAME": "your-username",
echo         "PASSWORD": "your-password",
echo         "READONLY": "false"
echo       }
echo     }
echo   }
echo }
echo.

pause