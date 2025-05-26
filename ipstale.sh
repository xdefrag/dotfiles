#!/bin/sh

# Script to rebuild nix-darwin configuration for ipstale
set -e

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "Rebuilding nix-darwin configuration for ipstale..."
echo "Using flake from: $SCRIPT_DIR"

# Check if darwin-rebuild is available
if ! command -v darwin-rebuild >/dev/null 2>&1; then
    echo "darwin-rebuild not found in PATH, trying system path..."
    DARWIN_REBUILD="/nix/var/nix/profiles/system/sw/bin/darwin-rebuild"
    if [ ! -x "$DARWIN_REBUILD" ]; then
        echo "Error: darwin-rebuild not found. Please ensure nix-darwin is installed."
        exit 1
    fi
else
    DARWIN_REBUILD="darwin-rebuild"
fi

# Run the rebuild
sudo "$DARWIN_REBUILD" switch --flake "$SCRIPT_DIR#ipstale"

echo "Rebuild completed successfully!"
echo ""
echo "Applications are now available in:"
echo "  - /Applications/Nix Apps/ (for GUI access)"
echo "  - Command line: alacritty, tmux, etc."
echo ""
echo "You can find Alacritty in Spotlight by searching for 'Alacritty'" 