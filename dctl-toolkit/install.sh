#!/usr/bin/env bash
# install.sh - Symlink DCTL files into DaVinci Resolve's LUT directory
# Usage: ./install.sh [--uninstall]
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TOOLKIT_NAME="DCTL-Toolkit"

# Detect platform and set LUT directory
case "$(uname -s)" in
    Darwin)
        LUT_DIR="$HOME/Library/Application Support/Blackmagic Design/DaVinci Resolve/LUT"
        ;;
    Linux)
        LUT_DIR="$HOME/.local/share/DaVinciResolve/LUT"
        ;;
    MINGW*|MSYS*|CYGWIN*)
        : "${APPDATA:?Error: APPDATA environment variable is not set}"
        LUT_DIR="$APPDATA/Blackmagic Design/DaVinci Resolve/Support/LUT"
        ;;
    *)
        echo "Error: Unsupported platform $(uname -s)"
        exit 1
        ;;
esac

TARGET_DIR="$LUT_DIR/$TOOLKIT_NAME"

if [[ "${1:-}" == "--uninstall" ]]; then
    echo "Uninstalling $TOOLKIT_NAME..."
    if [[ -d "$TARGET_DIR" ]]; then
        rm -rf "$TARGET_DIR"
        echo "Removed $TARGET_DIR"
    else
        echo "Nothing to uninstall (directory not found)"
    fi
    echo "Done. Restart Resolve or right-click -> Update Lists in the DCTL picker."
    exit 0
fi

echo "Installing $TOOLKIT_NAME into DaVinci Resolve..."
echo "LUT directory: $LUT_DIR"

# Create LUT directory if it doesn't exist
if [[ ! -d "$LUT_DIR" ]]; then
    echo "Creating LUT directory..."
    mkdir -p "$LUT_DIR"
fi

# Create toolkit subdirectory
mkdir -p "$TARGET_DIR/transforms"
mkdir -p "$TARGET_DIR/visualization"
mkdir -p "$TARGET_DIR/diagnostic"
mkdir -p "$TARGET_DIR/grading"

# Symlink all DCTL files
link_dctl() {
    local src="$1"
    local dest="$2"
    local filename
    filename="$(basename "$src")"

    if [[ -L "$dest/$filename" ]]; then
        rm "$dest/$filename"
    fi

    ln -s "$src" "$dest/$filename"
    echo "  Linked: $filename"
}

echo ""
echo "Transforms:"
for f in "$SCRIPT_DIR"/transforms/*.dctl; do
    [[ -f "$f" ]] && link_dctl "$f" "$TARGET_DIR/transforms"
done

echo "Visualization:"
for f in "$SCRIPT_DIR"/visualization/*.dctl; do
    [[ -f "$f" ]] && link_dctl "$f" "$TARGET_DIR/visualization"
done

echo "Diagnostic:"
for f in "$SCRIPT_DIR"/diagnostic/*.dctl; do
    [[ -f "$f" ]] && link_dctl "$f" "$TARGET_DIR/diagnostic"
done

echo "Grading:"
for f in "$SCRIPT_DIR"/grading/*.dctl; do
    [[ -f "$f" ]] && link_dctl "$f" "$TARGET_DIR/grading"
done

echo ""
echo "Installation complete!"
echo "Files linked to: $TARGET_DIR"
echo ""
echo "To use in Resolve:"
echo "  1. Open a project in DaVinci Resolve"
echo "  2. Go to the Color page"
echo "  3. Right-click a node -> Add DCTL"
echo "  4. Navigate to $TOOLKIT_NAME/ subfolder"
echo "  5. If files don't appear, right-click -> Update Lists"
