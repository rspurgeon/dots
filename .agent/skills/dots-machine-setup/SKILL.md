---
name: dots-machine-setup
description: Set up, repair, and evolve machines managed by the rspurgeon dots repo. Use when onboarding a new machine after cloning the dots repo, reconciling differences between hosts such as macOS and omarchy Linux, applying repo changes onto a live machine, fixing broken shell/tmux/neovim/bootstrap behavior, or porting repo changes back onto the omarchy machine.
---

# Dots Machine Setup

Work from the repo root. Assume the repo lives at `~/dev/rspurgeon/dots` unless the user says otherwise.

## Goals

Use the repo as the source of truth for shared configuration.

Keep the split clean:
- `bin/bootstrap` manages symlinked dotfiles and directories
- `bin/mise-sync` manages the copied `mise` config and installs CLI tools
- `~/.config/rspurgeon/local.zsh` is for truly local or secret values only

Do not use branches as machine profiles. Prefer shared config plus OS and host overlays.

## First Checks

Inspect:
- `git status --short --branch`
- `bin/bootstrap status`
- `test -L ~/.config/mise/config.toml && echo bad-symlink || echo ok`
- `tmux show-options -g prefix` if tmux is running

Read these files before changing behavior:
- `bootstrap/manifest.tsv`
- `shell/zshrc.shared`
- `shell/zshrc.macos`
- `.tmux.conf.local`
- `mise/config.toml`

## Bootstrap Rules

Use `bin/bootstrap plan` before `apply`.

`bin/bootstrap` should manage repo-backed symlinks such as:
- `~/.zshrc`
- `~/.tmux.conf.local`
- `~/.config/nvim`
- `~/.config/tmux-powerline`
- `~/.config/tmux-powerline-segments`
- `~/.local/bin/pitch`
- `~/.local/bin/pitch-mcp`

Do not put `mise` in the bootstrap manifest. `~/.config/mise/config.toml` must be a regular copied file, not a symlink into the repo. When `mise` was symlinked into the repo, tool resolution changed depending on the current working directory.

## Mise Rules

Source of truth in the repo is `mise/config.toml`.

Use:
- `bin/mise-sync install`
- `bin/mise-sync status`

Keep the shared `mise` baseline small and pinned. Prefer this process:
1. Trial a CLI locally with `mise use -g --pin tool@version`
2. If it is reliable and should exist on future machines, add the pinned version to `mise/config.toml`
3. Run `bin/mise-sync install`

Use `mise` for CLI tools when possible. Do not use `mise` for GUI apps, fonts, or macOS app setup.

## Shell Rules

Load order matters:
1. `.zshrc` loads tracked repo files
2. `shell/zshrc.shared` defines common behavior
3. `shell/zshrc.macos` handles macOS-specific setup and `mise activate`
4. local file `~/.config/rspurgeon/local.zsh` loads last

Keep shared-safe workflow helpers in tracked config, not in `local.zsh`. The shared workflow aliases and `lazyworktree` helper now live in `shell/zshrc.workflows`.

Use `local.zsh` only for:
- secrets
- machine-only environment variables
- volatile host-specific paths
- short-term experiments

### Known Shell Gotchas

Starship only works if it is initialized after `mise activate zsh --shims`. If the prompt falls back to the plain `%n@%m %1~ %#` prompt, check `shell/zshrc.macos`.

Export `STARSHIP_CONFIG="$HOME/.config/starship.toml"` explicitly. Do not rely on implicit lookup.

If `zsh-syntax-highlighting` is missing, install it with Homebrew and source it via `brew --prefix`, not a hardcoded `/opt/homebrew` path.

## Tmux Rules

This setup uses:
- gpakosz base config at `~/.tmux.conf`
- repo-managed `.tmux.conf.local`
- TPM under `~/.tmux/plugins/tpm`
- `tmux-powerline` plugin
- repo-managed theme files under `~/.config/tmux-powerline`

The `rick` theme is tracked in:
- `.config/tmux-powerline/config.sh`
- `.config/tmux-powerline/themes/rick.sh`
- `.config/tmux-powerline-segments/pitch_status.sh`

Do not create a standalone symlink for `themes/rick.sh`; the parent directory symlink is enough.

If tmux does not match expectations, verify all of:
- `~/.tmux.conf` exists and points to the gpakosz base config
- `~/.tmux.conf.local` points into dots
- `~/.config/tmux-powerline` points into dots
- `~/.config/tmux-powerline-segments` points into dots
- `~/.tmux/plugins/tpm` exists

Reload with:
```tmux
source-file ~/.tmux.conf
source-file ~/.tmux.conf.local
```

Current intended prefixes:
- primary: `C-Space`
- secondary: `C-a`

If `C-Space` stops working, check macOS keyboard shortcuts before changing tmux config. Confirm tmux sees the intended prefix with:
```tmux
show-options -g prefix
show-options -g prefix2
```

If `tm` shows numbers in `fzf`, that is not a bug in `tm`. It means tmux sessions are actually named `1`, `2`, etc. The gpakosz setting `tmux_conf_new_session_prompt=false` allows unnamed sessions. Rename sessions or enable the prompt if needed.

## Neovim Rules

This repo currently uses `packer.nvim`.

Bootstrap:
- ensure `packer.nvim` exists under `~/.local/share/nvim/site/pack/packer/start/packer.nvim`
- then run `nvim +PackerSync`

Guard `after/plugin/*.lua` files so first-run startup does not crash when plugins are missing. Use `pcall(require, ...)` and return early when appropriate.

If a plugin was removed from `packer.lua` but errors still appear, check whether it still exists under `~/.local/share/nvim/site/pack/packer/start/`. A stale installed plugin can continue loading even after it is removed from the repo config.

## Fonts And Terminals

Standard font is `JetBrainsMono Nerd Font Mono`.

On macOS, install it with Homebrew:
```bash
brew install --cask font-jetbrains-mono-nerd-font
```

Keep terminal configs aligned around that font:
- Alacritty
- Ghostty
- iTerm2

If glyphs still look wrong, fully quit and relaunch the terminal app instead of only reloading the shell.

## Omarchy Sync Rules

When the user wants the omarchy machine to adopt repo changes made during a macOS session, do not assume the live omarchy machine matches the repo.

Process:
1. Inspect the repo changes first
2. Separate shared changes from Linux-only or macOS-only changes
3. Use SSH to inspect live omarchy files when behavior differs from the repo
4. Apply only the relevant changes on the omarchy machine

When syncing this session’s changes back onto omarchy, pay special attention to:
- `tmux-powerline` theme and segment files
- `~/.config/tmux-powerline-segments`
- `~/.local/bin/pitch` and `~/.local/bin/pitch-mcp`
- the shell split between shared workflows and local secrets
- the fact that omarchy may already have uncommitted drift

Prefer comparing live omarchy files against:
- `.config/tmux-powerline/config.sh`
- `.config/tmux-powerline/themes/rick.sh`
- `.config/tmux-powerline-segments/pitch_status.sh`
- `.tmux.conf.local`

Do not blindly overwrite Linux-specific files from a macOS pass.

## Repair Checklist

Use these checks when setup is broken:

### Shell looks wrong

Check:
- `command -v starship`
- `echo $STARSHIP_CONFIG`
- `mise ls --current`
- `zsh -n shell/zshrc.shared shell/zshrc.macos shell/zshrc.workflows`

### Commands missing after shell startup

Check:
- `eval "$(mise activate zsh --shims)"` is present in `shell/zshrc.macos`
- `~/.config/mise/config.toml` is a real file, not a symlink
- the tool is installed via `bin/mise-sync install`

### Tmux layout or theme looks wrong

Check:
- `show-options -g prefix`
- `readlink ~/.tmux.conf`
- `readlink ~/.tmux.conf.local`
- `readlink ~/.config/tmux-powerline`
- `readlink ~/.config/tmux-powerline-segments`
- plugin installation under `~/.tmux/plugins`

### Neovim startup errors

Check:
- `packer.nvim` is installed
- removed plugins are not still present under `.../pack/packer/start`
- plugin-backed `after/plugin` files are guarded

## Editing Discipline

Use `apply_patch` for file edits.

Do not revert unrelated user changes in a dirty worktree.

When importing from another branch, inspect only the relevant files and adapt paths for the current OS. This repo contains both shared and host-specific concerns; copying branch deltas wholesale is usually wrong.
