#!/bin/bash
set -e

echo "
    ___   ______ ______ _   __ ____ 
   /   | /_  __// ____// | / // __ \\
  / /| |  / /  / __/  /  |/ // / / /
 / ___ | / /  / /___ / /|  // /_/ / 
/_/  |_|/_/  /_____//_/ |_/ \____/  
"
echo "🚀 Initializing Ateno Spatial Design Environment..."

# 1. Detect OS
OS="$(uname -s)"
if [[ "$OS" != "Darwin" && "$OS" != "Linux" ]]; then
    echo "❌ This script is for macOS or Linux. For Windows, use https://ateno.co/win"
    exit 1
fi

# 2. Check for Homebrew
if ! command -v brew &> /dev/null; then
    echo "📦 Homebrew not found. Installing Homebrew first..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)" || eval "$(/usr/local/bin/brew shellenv)"
fi

# 3. Interactive Choice
echo "------------------------------------------------"
echo "Which Ateno SDKs would you like to install?"
echo "1) 📦 Both (Python & JS) - Recommended"
echo "2) 🐍 Python only (ateno)"
echo "3) ⚡ JavaScript only (ateno-js)"
echo "------------------------------------------------"

# Use /dev/tty to ensure it works with curl | bash
read -p "Select an option [1-3]: " choice < /dev/tty

brew tap Atenotech/ateno-homebrew --quiet

# 4. Installation and dynamic instruction prep
case $choice in
    2)
        echo "🐍 Fetching Ateno Python SDK..."
        brew install ateno
        INSTRUCTIONS="Run 'ateno --version' to begin."
        ;;
    3)
        echo "⚡ Fetching Ateno JavaScript SDK..."
        brew install ateno-js
        INSTRUCTIONS="Run 'ateno-js --version' to begin."
        ;;
    *)
        echo "📦 Fetching both SDKs..."
        brew install ateno ateno-js
        INSTRUCTIONS="Run 'ateno --version' or 'ateno-js --version' to begin."
        ;;
esac

echo "------------------------------------------------"
echo "✅ Success! Ateno is now globally available."
echo "👉 $INSTRUCTIONS"
echo "------------------------------------------------"