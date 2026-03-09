#!/bin/bash
set -e

# Ateno Installation Script (Premium Edition)
# Custom domain: ateno.co/install

echo "🚀 Initializing Ateno Spatial Design Environment..."

# 1. Detect OS
OS="$(uname -s)"
if [[ "$OS" != "Darwin" && "$OS" != "Linux" ]]; then
    echo "❌ This script is for macOS or Linux. For Windows, use install.ps1"
    exit 1
fi

# 2. Check for Homebrew
if ! command -v brew &> /dev/null; then
    echo "📦 Homebrew not found. Installing Homebrew first..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    # Add brew to path for the current session
    eval "$(/opt/homebrew/bin/brew shellenv)" || eval "$(/usr/local/bin/brew shellenv)"
fi

# 3. Silent Tap and Install
echo "📥 Fetching Ateno SDKs (Python & JS)..."
brew tap Atenotech/ateno-homebrew --quiet
brew install ateno ateno-js

echo "✅ Success! Ateno is now globally available."
echo "   Run 'ateno --version' or 'ateno-js --version' to begin."