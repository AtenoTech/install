# Ateno Windows Setup Script (Premium Edition)
# Run via: iex (iwr https://ateno.co/win).Content

Clear-Host
Write-Host @"
    ___   ______ ______ _   __ ____ 
   /   | /_  __// ____// | / // __ \
  / /| |  / /  / __/  /  |/ // / / /
 / ___ | / /  / /___ / /|  // /_/ / 
/_/  |_|/_/  /_____//_/ |_/ \____/  
"@ -ForegroundColor Cyan

Write-Host "🚀 Initializing Ateno Spatial Design Environment..." -ForegroundColor Cyan

# 1. Interactive Choice
Write-Host "`n------------------------------------------------"
Write-Host "Which Ateno SDKs would you like to install?"
Write-Host "1) 📦 Both (Python & JS) - Recommended"
Write-Host "2) 🐍 Python only (ateno)"
Write-Host "3) ⚡ JavaScript only (ateno-js)"
Write-Host "------------------------------------------------"
$choice = Read-Host "Select an option [1-3]"

$installPython = $false
$installJS = $false
$instructions = ""

# 2. Logic Mapping
switch ($choice) {
    "2" { 
        $installPython = $true
        $instructions = "Run 'ateno --version' to begin."
    }
    "3" { 
        $installJS = $true
        $instructions = "Run 'ateno-js --version' to begin."
    }
    Default { 
        $installPython = $true
        $installJS = $true
        $instructions = "Run 'ateno --version' or 'ateno-js --version' to begin."
    }
}

# 3. Execution: Python
if ($installPython) {
    if (Get-Command pip -ErrorAction SilentlyContinue) {
        Write-Host "`n🐍 Installing Ateno Python SDK..." -ForegroundColor Yellow
        pip install git+https://github.com/AtenoTech/ateno-py.git --upgrade
    } else {
        Write-Host "`n⚠️ Warning: Pip not found. Please install Python to use 'ateno'." -ForegroundColor Red
    }
}

# 4. Execution: JS
if ($installJS) {
    if (Get-Command npm -ErrorAction SilentlyContinue) {
        Write-Host "`n⚡ Installing Ateno JavaScript SDK..." -ForegroundColor Yellow
        npm install -g git+https://github.com/AtenoTech/ateno-js.git
    } else {
        Write-Host "`n⚠️ Warning: NPM not found. Please install Node.js to use 'ateno-js'." -ForegroundColor Red
    }
}

# 5. Final Feedback
Write-Host "`n------------------------------------------------"
Write-Host "✅ Ateno installation complete!" -ForegroundColor Green
Write-Host "👉 $instructions" -ForegroundColor Green
Write-Host "------------------------------------------------"