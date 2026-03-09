# Ateno Windows Setup Script
# Run via: iex (iwr https://ateno.co/install.ps1)

Write-Host "🚀 Initializing Ateno for Windows..." -ForegroundColor Cyan

# 1. Check for Python/Pip
if (Get-Command pip -ErrorAction SilentlyContinue) {
    Write-Host "🐍 Installing Ateno Python SDK..."
    pip install git+https://github.com/AtenoTech/ateno-py.git --upgrade
} else {
    Write-Host "⚠️ Warning: Python/Pip not found. Please install Python to use the 'ateno' CLI." -ForegroundColor Yellow
}

# 2. Check for Node/NPM
if (Get-Command npm -ErrorAction SilentlyContinue) {
    Write-Host "📦 Installing Ateno JavaScript SDK..."
    npm install -g git+https://github.com/AtenoTech/ateno-js.git
} else {
    Write-Host "⚠️ Warning: Node.js/NPM not found. Please install Node.js to use 'ateno-js'." -ForegroundColor Yellow
}

Write-Host "✅ Ateno installation complete! Please restart your terminal." -ForegroundColor Green