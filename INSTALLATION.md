# Installation and Build Scripts

This project includes automated installation and build scripts for different platforms.

## Quick Start

### Linux/macOS
```bash
./install-and-build.sh
```

### Windows (Command Prompt)
```cmd
install-and-build.bat
```

### Windows (PowerShell)
```powershell
.\install-and-build.ps1
```

## What the scripts do

1. **Check prerequisites**: Verify that Node.js and npm are installed
2. **Install dependencies**: Run `npm install` to install all required packages
3. **Build project**: Run `npm run build` to compile TypeScript to JavaScript
4. **Show output path**: Display the location of the built `index.js` file
5. **Generate VS Code config**: Output ready-to-copy JSON configuration for VS Code

## Output Location

After successful build, the main executable will be located at:
- **Linux/macOS**: `./dist/index.js`
- **Windows**: `.\dist\index.js`

## Prerequisites

### Node.js Installation

If Node.js is not installed, the scripts will provide installation instructions:

#### macOS
```bash
# Using Homebrew
brew install node
```

#### Ubuntu/Debian
```bash
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt-get install -y nodejs
```

#### CentOS/RHEL/Fedora
```bash
curl -fsSL https://rpm.nodesource.com/setup_lts.x | sudo bash -
sudo yum install -y nodejs
```

#### Windows
- Download installer from [nodejs.org](https://nodejs.org/)
- Using Chocolatey: `choco install nodejs`
- Using Winget: `winget install OpenJS.NodeJS`

## Manual Build Process

If you prefer to build manually:

```bash
# Install dependencies
npm install

# Build the project
npm run build

# The output will be in ./dist/index.js
```

## Using the Built Server

After building, you can run the MCP server:

```bash
node ./dist/index.js
```

For MCP client configuration, use the full path to `dist/index.js`.