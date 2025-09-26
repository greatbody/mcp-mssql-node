# MCP MSSQL Node - Installation and Build Script for Windows PowerShell
# This script installs npm dependencies, builds the project, and shows the output path

Write-Host ""
Write-Host "🚀 MCP MSSQL Node - Installation and Build Script" -ForegroundColor Cyan
Write-Host "==================================================" -ForegroundColor Cyan

# Function to check if command exists
function Test-CommandExists {
    param($Command)
    $null = Get-Command $Command -ErrorAction SilentlyContinue
    return $?
}

# Check if Node.js is installed
if (-not (Test-CommandExists "node")) {
    Write-Host "❌ Node.js is not installed!" -ForegroundColor Red
    Write-Host "Please install Node.js from https://nodejs.org/" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Windows installation options:" -ForegroundColor Yellow
    Write-Host "  1. Download installer from https://nodejs.org/" -ForegroundColor White
    Write-Host "  2. Using Chocolatey: choco install nodejs" -ForegroundColor White
    Write-Host "  3. Using Winget: winget install OpenJS.NodeJS" -ForegroundColor White
    Write-Host "  4. Using Scoop: scoop install nodejs" -ForegroundColor White
    Write-Host ""
    Read-Host "Press Enter to exit"
    exit 1
}

# Get Node.js version
$nodeVersion = node --version
Write-Host "✅ Node.js found: $nodeVersion" -ForegroundColor Green

# Check if npm is installed
if (-not (Test-CommandExists "npm")) {
    Write-Host "❌ npm is not installed!" -ForegroundColor Red
    Write-Host "npm usually comes with Node.js. Please reinstall Node.js." -ForegroundColor Yellow
    Read-Host "Press Enter to exit"
    exit 1
}

# Get npm version
$npmVersion = npm --version
Write-Host "✅ npm found: $npmVersion" -ForegroundColor Green

Write-Host ""
Write-Host "📦 Installing dependencies..." -ForegroundColor Yellow
try {
    npm install
    if ($LASTEXITCODE -ne 0) {
        throw "npm install failed"
    }
}
catch {
    Write-Host "❌ Failed to install dependencies!" -ForegroundColor Red
    Read-Host "Press Enter to exit"
    exit 1
}

Write-Host ""
Write-Host "🔨 Building the project..." -ForegroundColor Yellow
try {
    npm run build
    if ($LASTEXITCODE -ne 0) {
        throw "npm run build failed"
    }
}
catch {
    Write-Host "❌ Build failed!" -ForegroundColor Red
    Read-Host "Press Enter to exit"
    exit 1
}

$currentPath = Get-Location
$distPath = Join-Path $currentPath "dist\index.js"

Write-Host ""
Write-Host "✅ Build completed successfully!" -ForegroundColor Green
Write-Host ""
Write-Host "📄 Main executable file location:" -ForegroundColor Cyan
Write-Host "   $distPath" -ForegroundColor White
Write-Host ""
Write-Host "🎯 You can copy this file to your desired location:" -ForegroundColor Cyan
Write-Host "   Copy-Item '$distPath' 'C:\your\destination\path\'" -ForegroundColor White
Write-Host ""
Write-Host "🚀 To run the server:" -ForegroundColor Cyan
Write-Host "   node '$distPath'" -ForegroundColor White
Write-Host ""
Write-Host "📝 VS Code MCP Configuration:" -ForegroundColor Cyan
Write-Host "Copy the following configuration to your VS Code .vscode/mcp.json file:" -ForegroundColor Yellow
Write-Host ""
Write-Host "{" -ForegroundColor White
Write-Host '  "servers": {' -ForegroundColor White
Write-Host '    "mssql-nodejs": {' -ForegroundColor White
Write-Host '      "type": "stdio",' -ForegroundColor White
Write-Host '      "command": "node",' -ForegroundColor White
Write-Host "      `"args`": [`"$($distPath.Replace('\', '\\'))`"]," -ForegroundColor White
Write-Host '      "env": {' -ForegroundColor White
Write-Host '        "SERVER_NAME": "your-server-name.database.windows.net",' -ForegroundColor White
Write-Host '        "DATABASE_NAME": "your-database-name",' -ForegroundColor White
Write-Host '        "USERNAME": "your-username",' -ForegroundColor White
Write-Host '        "PASSWORD": "your-password",' -ForegroundColor White
Write-Host '        "READONLY": "false"' -ForegroundColor White
Write-Host '      }' -ForegroundColor White
Write-Host '    }' -ForegroundColor White
Write-Host '  }' -ForegroundColor White
Write-Host "}" -ForegroundColor White
Write-Host ""

Read-Host "Press Enter to exit"