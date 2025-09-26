#!/bin/bash

# MCP MSSQL Node - Installation and Build Script for Linux/macOS
# This script installs Node.js, npm dependencies, builds the project, and shows the output path

set -e  # Exit on any error

echo "🚀 MCP MSSQL Node - Installation and Build Script"
echo "=================================================="

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check if Node.js is installed
if ! command_exists node; then
    echo "❌ Node.js is not installed!"
    echo "Please install Node.js from https://nodejs.org/ or use a package manager:"
    echo ""
    echo "macOS (using Homebrew):"
    echo "  brew install node"
    echo ""
    echo "Ubuntu/Debian:"
    echo "  curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -"
    echo "  sudo apt-get install -y nodejs"
    echo ""
    echo "CentOS/RHEL/Fedora:"
    echo "  curl -fsSL https://rpm.nodesource.com/setup_lts.x | sudo bash -"
    echo "  sudo yum install -y nodejs"
    echo ""
    exit 1
fi

# Check Node.js version
NODE_VERSION=$(node --version)
echo "✅ Node.js found: $NODE_VERSION"

# Check if npm is installed
if ! command_exists npm; then
    echo "❌ npm is not installed!"
    echo "npm usually comes with Node.js. Please reinstall Node.js."
    exit 1
fi

NPM_VERSION=$(npm --version)
echo "✅ npm found: $NPM_VERSION"

echo ""
echo "📦 Installing dependencies..."
npm install

echo ""
echo "🔨 Building the project..."
npm run build

echo ""
echo "✅ Build completed successfully!"
echo ""
echo "📄 Main executable file location:"
echo "   $(pwd)/dist/index.js"
echo ""
echo "🎯 You can copy this file to your desired location:"
echo "   cp $(pwd)/dist/index.js /your/destination/path/"
echo ""
echo "🚀 To run the server:"
echo "   node $(pwd)/dist/index.js"
echo ""
echo "📝 VS Code MCP Configuration:"
echo "Copy the following configuration to your VS Code .vscode/mcp.json file:"
echo ""
echo "{"
echo "  \"servers\": {"
echo "    \"mssql-nodejs\": {"
echo "      \"type\": \"stdio\","
echo "      \"command\": \"node\","
echo "      \"args\": [\"$(pwd)/dist/index.js\"],"
echo "      \"env\": {"
echo "        \"SERVER_NAME\": \"your-server-name.database.windows.net\","
echo "        \"DATABASE_NAME\": \"your-database-name\","
echo "        \"USERNAME\": \"your-username\","
echo "        \"PASSWORD\": \"your-password\","
echo "        \"READONLY\": \"false\""
echo "      }"
echo "    }"
echo "  }"
echo "}"
echo ""