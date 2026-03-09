#!/bin/bash
# Detect OS and Architecture (Standard for high-performance 3D tools)
OS="$(uname -s)"
ARCH="$(uname -m)"

if [[ "$OS" == "Darwin" ]]; then
    # Use Homebrew if they have it; it's cleaner for Mac users
    if command -v brew &> /dev/null; then
        echo "Installing via Homebrew..."
        brew tap AtenoTech/ateno
        brew install ateno
    else
        echo "Installing standalone binary for macOS..."
        # Logic to download binary and move to /usr/local/bin
    fi
else
    echo "Installing for Linux..."
    # Linux logic here
fi