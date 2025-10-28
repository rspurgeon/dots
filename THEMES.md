# Theme Switching System

This repository includes a unified theme switching system that keeps your terminal environment visually consistent across ghostty, neovim, and tmux.

## Quick Start

```bash
# List available themes
./switch-theme list

# Switch to a theme (automatically creates backup)
./switch-theme switch gruvbox-dark

# Show current theme
./switch-theme current
```

## Available Themes

- **gruvbox-dark** - Classic warm theme with high contrast
- **tokyo-night** - Modern, popular dark theme
- **catppuccin-mocha** - Warm, pastel-toned theme
- **nord** - Cool, minimal arctic-inspired theme

## How It Works

The `switch-theme` script updates configurations for:

1. **Ghostty** (.config/ghostty/config) - Changes the `theme` setting
2. **Neovim** (.config/nvim/after/plugin/colors.lua) - Updates the colorscheme
3. **Tmux** (.tmux.conf.local) - Sources theme-specific color overrides
4. **tmux-powerline** (.config/tmux-powerline/themes/rick.sh) - Copies theme-specific powerline colors

### Tmux Theme Safety

Tmux themes are **color-only** overrides that preserve:
- ✅ Your status bar layout and content
- ✅ All key bindings
- ✅ All plugins and functionality
- ✅ All other configuration settings

Theme files only modify color variables like `tmux_conf_theme_status_bg`, etc.

### True Color Support

All themes use **24-bit RGB hex colors** (e.g., `#282828`) for perfect color matching:
- ✅ Ghostty: Full RGB support
- ✅ Neovim: Full RGB support
- ✅ Tmux: True color enabled (`tmux_conf_theme_24b_colour=true`)
- ✅ tmux-powerline: RGB hex color support

This ensures themes look identical across all tools with no color approximation.

## Backup & Restore

### Automatic Backups

Every time you switch themes, an automatic backup is created:

```bash
./switch-theme switch tokyo-night
# Creates backup at .theme-backups/20251028_123456
```

### Manual Backup

Create a backup before experimenting:

```bash
./switch-theme backup
```

### Restore Previous Configuration

Undo your theme changes and restore the most recent backup:

```bash
./switch-theme restore
```

### List All Backups

```bash
./switch-theme restore-list
```

Backups are stored in `.theme-backups/` (gitignored by default).

## After Switching Themes

After running `switch-theme`, reload each tool:

**Ghostty:**
- Press `Cmd+Comma` (opens settings and reloads)
- Or restart the app

**Neovim:**
- Restart nvim
- Or run `:colorscheme <theme-name>` in an open session

**Tmux & tmux-powerline:**
```bash
tmux source-file ~/.tmux.conf
```
The powerline status bar should change immediately.

## First-Time Setup

### 1. Install Neovim Theme Plugins

Open nvim and run:
```vim
:PackerSync
```

This installs the theme plugins added to `packer.lua`:
- ellisonleao/gruvbox.nvim
- folke/tokyonight.nvim
- catppuccin/nvim
- shaunsingh/nord.nvim

### 2. Install Font (Optional)

The ghostty config uses JetBrains Mono:
```bash
brew install --cask font-jetbrains-mono
```

### 3. Create Initial Backup

```bash
./switch-theme backup
```

## Adding New Themes

To add a new theme:

1. Create theme file in `.config/ghostty/themes/new-theme`
2. Create theme file in `.config/tmux/themes/new-theme.conf`
3. Add neovim plugin to `packer.lua`
4. Update `switch-theme` script's `AVAILABLE_THEMES` and `NVIM_THEMES` arrays
5. Run `:PackerSync` in neovim

## Directory Structure

```
dots/
├── .config/
│   ├── ghostty/
│   │   ├── config                    # Main config
│   │   └── themes/
│   │       ├── gruvbox-dark
│   │       ├── tokyo-night
│   │       ├── catppuccin-mocha
│   │       └── nord
│   ├── tmux/
│   │   └── themes/
│   │       ├── gruvbox-dark.conf     # Color-only overrides
│   │       ├── tokyo-night.conf
│   │       ├── catppuccin-mocha.conf
│   │       └── nord.conf
│   ├── tmux-powerline/
│   │   └── themes/
│   │       ├── rick.sh               # Active theme (copied by script)
│   │       ├── rick-gruvbox-dark.sh
│   │       ├── rick-tokyo-night.sh
│   │       ├── rick-catppuccin-mocha.sh
│   │       └── rick-nord.sh
│   └── nvim/
│       └── after/plugin/colors.lua   # Colorscheme loader
├── .tmux.conf.local                  # Your main tmux config
├── switch-theme                      # Theme switcher script
└── .theme-backups/                   # Automatic backups (gitignored)
```

## Troubleshooting

**Themes don't match perfectly:**
- Each tool's theme is crafted specifically for that tool
- Colors are matched as closely as possible across tools
- Some variation is normal due to different rendering contexts

**Tmux theme not applying:**
```bash
# Reload tmux config
tmux source-file ~/.tmux.conf
```

**Neovim theme errors:**
```vim
" Make sure plugins are installed
:PackerSync
```

**Restore isn't working:**
- Check `.theme-backups/` exists and has backup directories
- Run `./switch-theme restore-list` to see available backups
- Manually copy from backup if needed

## Safety Features

- ✅ **Automatic backups** before every theme switch
- ✅ **Manual backup** option available
- ✅ **Easy restore** with single command
- ✅ **Non-destructive** - only modifies color settings in tmux
- ✅ **Reversible** - all changes can be undone
