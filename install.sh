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
    echo "❌ This script is for macOS or Linux. For Windows, use: iex (iwr ateno.co/win).Content"
    exit 1
fi

# 2. Check for Homebrew
if ! command -v brew &> /dev/null; then
    echo "📦 Homebrew not found. Installing Homebrew first..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)" || eval "$(/usr/local/bin/brew shellenv)"
fi

# 3. Interactive Multi-Select Menu
echo "------------------------------------------------"
echo "Which Ateno tools would you like to install?"
echo "Enter numbers separated by spaces (e.g., '2 4 5')"
echo ""
echo "1) 🌐 Full Suite (Installs all applicable tools below)"
echo "2) 💻 CLI Tools (ateno & ateno-js via Homebrew)"
echo "3) 🐍 Python SDK (ateno via pip)"
echo "4) ⚛️ React UI (@atenotech/react via npm)"
echo "5) 📱 Flutter UI (ateno_flutter via pub)"
echo "------------------------------------------------"

read -p "Select options [Default: 1]: " input_choices < /dev/tty
input_choices=${input_choices:-1}

# Initialize flags
INSTALL_CLI=false
INSTALL_PY=false
INSTALL_REACT=false
INSTALL_FLUTTER=false

# Parse choices
for choice in $input_choices; do
    case $choice in
        1) INSTALL_CLI=true; INSTALL_PY=true; INSTALL_REACT=true; INSTALL_FLUTTER=true ;;
        2) INSTALL_CLI=true ;;
        3) INSTALL_PY=true ;;
        4) INSTALL_REACT=true ;;
        5) INSTALL_FLUTTER=true ;;
    esac
done

INSTRUCTIONS=""

# 4. Execution
if [ "$INSTALL_CLI" = true ]; then
    echo "💻 Installing CLI Tools..."
    brew tap Atenotech/ateno-homebrew --quiet
    brew install ateno ateno-js
    INSTRUCTIONS="$INSTRUCTIONS\n- CLI: Run 'ateno --version' or 'ateno-js --version'"
fi

if [ "$INSTALL_PY" = true ]; then
    echo "🐍 Installing Python SDK..."
    pip install ateno
    INSTRUCTIONS="$INSTRUCTIONS\n- Python: Import 'ateno' in your environment"
fi

if [ "$INSTALL_REACT" = true ]; then
    echo "⚛️ Installing React UI Components..."
    npm install -g @atenotech/react
    INSTRUCTIONS="$INSTRUCTIONS\n- React: Import { AtenoViewer } from '@atenotech/react'"
fi

if [ "$INSTALL_FLUTTER" = true ]; then
    echo "📱 Evaluating Flutter environment..."
    if command -v flutter &> /dev/null && [ -f "pubspec.yaml" ]; then
        echo "Adding ateno_flutter to project..."
        flutter pub add ateno_flutter
        INSTRUCTIONS="$INSTRUCTIONS\n- Flutter: Added 'ateno_flutter' to your pubspec.yaml"
    else
        echo "⏭️  Skipped Flutter UI (Command not run inside a Flutter project with a pubspec.yaml)"
    fi
fi

echo "------------------------------------------------"
echo "✅ Ateno setup complete!"
echo -e "$INSTRUCTIONS"
echo "------------------------------------------------"