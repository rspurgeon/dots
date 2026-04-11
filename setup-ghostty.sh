#!/usr/bin/env bash
#
# Ghostty Configuration Setup Script
# Links ghostty config from dots repo to ~/.config/ghostty

set -e

DOTS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
GHOSTTY_CONFIG_DIR="$HOME/.config/ghostty"
GHOSTTY_DOTS_DIR="$DOTS_DIR/.config/ghostty"

echo "🚀 Setting up Ghostty configuration..."

# Check if ghostty config exists
if [ -e "$GHOSTTY_CONFIG_DIR" ] && [ ! -L "$GHOSTTY_CONFIG_DIR" ]; then
    echo "⚠️  Warning: $GHOSTTY_CONFIG_DIR already exists and is not a symlink."
    echo "   Backing up to $GHOSTTY_CONFIG_DIR.backup"
    mv "$GHOSTTY_CONFIG_DIR" "$GHOSTTY_CONFIG_DIR.backup"
fi

# Remove existing symlink if present
if [ -L "$GHOSTTY_CONFIG_DIR" ]; then
    echo "📝 Removing existing symlink..."
    rm "$GHOSTTY_CONFIG_DIR"
fi

# Create .config directory if it doesn't exist
mkdir -p "$HOME/.config"

# Create symlink
echo "🔗 Creating symlink: $GHOSTTY_CONFIG_DIR -> $GHOSTTY_DOTS_DIR"
ln -s "$GHOSTTY_DOTS_DIR" "$GHOSTTY_CONFIG_DIR"

echo "✅ Ghostty configuration linked successfully!"
echo ""
echo "📚 Available themes:"
echo "   - tokyo-night (default)"
echo "   - catppuccin-mocha"
echo "   - nord"
echo "   - gruvbox-dark"
echo ""
echo "💡 To switch themes, edit ~/.config/ghostty/config and change the 'theme' line"
echo ""
echo "🔤 Font setup:"
echo "   The config uses JetBrainsMono Nerd Font Mono."
echo "   Install a JetBrains Mono Nerd Font package for your platform if needed."
echo ""
echo "🔄 Reload ghostty config with: Cmd+Comma or restart Ghostty"
