# Ateno Windows Setup Script
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

# 1. Interactive Multi-Select Menu
Write-Host "`n------------------------------------------------"
Write-Host "Which Ateno tools would you like to install?"
Write-Host "Enter numbers separated by spaces (e.g., '3 4 5')"
Write-Host ""
Write-Host "1) 🌐 Full Suite (Installs all applicable tools below)"
Write-Host "2) 💻 Core JS SDK (ateno-js via npm)"
Write-Host "3) 🐍 Python SDK (ateno via pip)"
Write-Host "4) ⚛️ React UI (@atenotech/react via npm)"
Write-Host "5) 📱 Flutter UI (ateno_flutter via pub)"
Write-Host "------------------------------------------------"

$inputChoices = Read-Host "Select options [Default: 1]"
if ([string]::IsNullOrWhiteSpace($inputChoices)) {
    $inputChoices = "1"
}

# Parse choices into an array
$choices = $inputChoices -split '\s+'

$installJS = $false
$installPy = $false
$installReact = $false
$installFlutter = $false

if ($choices -contains "1") {
    $installJS = $true
    $installPy = $true
    $installReact = $true
    $installFlutter = $true
} else {
    if ($choices -contains "2") { $installJS = $true }
    if ($choices -contains "3") { $installPy = $true }
    if ($choices -contains "4") { $installReact = $true }
    if ($choices -contains "5") { $installFlutter = $true }
}

$instructions = @()

# 2. Execution: Python
if ($installPy) {
    if (Get-Command pip -ErrorAction SilentlyContinue) {
        Write-Host "`n🐍 Installing Ateno Python SDK..." -ForegroundColor Yellow
        pip install ateno --upgrade
        $instructions += "- Python: Import 'ateno' in your scripts."
    } else {
        Write-Host "`n⚠️ Warning: Pip not found. Python install skipped." -ForegroundColor Red
    }
}

# 3. Execution: JS & React
if ($installJS -or $installReact) {
    if (Get-Command npm -ErrorAction SilentlyContinue) {
        if ($installJS) {
            Write-Host "`n⚡ Installing Ateno JavaScript SDK..." -ForegroundColor Yellow
            npm install -g ateno-js
            $instructions += "- JS: Run 'ateno-js --version' to verify."
        }
        if ($installReact) {
            Write-Host "`n⚛️ Installing Ateno React UI..." -ForegroundColor Yellow
            npm install -g @atenotech/react
            $instructions += "- React: Import { AtenoViewer } from '@atenotech/react'."
        }
    } else {
        Write-Host "`n⚠️ Warning: NPM not found. JS/React installs skipped." -ForegroundColor Red
    }
}

# 4. Execution: Flutter
if ($installFlutter) {
    Write-Host "`n📱 Evaluating Flutter environment..." -ForegroundColor Yellow
    if (Get-Command flutter -ErrorAction SilentlyContinue) {
        if (Test-Path "pubspec.yaml") {
            Write-Host "Adding ateno_flutter to project..." -ForegroundColor Yellow
            flutter pub add ateno_flutter
            $instructions += "- Flutter: Added 'ateno_flutter' to your pubspec.yaml."
        } else {
            Write-Host "⏭️ Skipped Flutter UI (Not inside a Flutter project folder)." -ForegroundColor DarkGray
        }
    } else {
        Write-Host "⚠️ Warning: Flutter SDK not found. Flutter install skipped." -ForegroundColor Red
    }
}

# 5. Final Feedback
Write-Host "`n------------------------------------------------"
Write-Host "✅ Ateno setup complete!" -ForegroundColor Green
foreach ($line in $instructions) {
    Write-Host $line -ForegroundColor Green
}
Write-Host "------------------------------------------------"