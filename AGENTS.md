# Repository Guidelines

## Project Structure & Module Organization
The repo root stores shared dotfiles (`.zshrc`, `.vimrc`, `.tmux.conf.local`) plus iTerm2 and Starship profiles. Tool-specific assets live under `.config/<tool>/` so the layout mirrors the eventual host: Ghostty themes, Neovim Lua, tmux and powerline segments, and Starship presets. Utility scripts (`switch-theme`, `tmux-sessionizer`, `setup-ghostty.sh`) coordinate theme changes, tmux session bootstraps, and symlink setup; treat them as canonical and link into `$HOME` after local edits.

## Build, Test, and Development Commands
- `./setup-ghostty.sh` — links `.config/ghostty` into `~/.config/ghostty`; rerun after Ghostty tweaks.
- `./switch-theme list` — lists registered themes; extend `AVAILABLE_THEMES` and mapping tables when adding new ones.
- `./switch-theme switch tokyo-night` — syncs Ghostty, Neovim, tmux, and tmux-powerline while snapshotting to `.theme-backups/`.
- `./switch-theme restore` — restores the most recent backup during theme experiments.

## Coding Style & Naming Conventions
Scripts are POSIX-friendly `bash` with `set -e`; keep four-space indentation inside conditionals and functions. Use descriptive, kebab-case filenames for executables and mirror runtime layouts by grouping `.toml`, `.lua`, and `.sh` under the appropriate `.config/<tool>/` directory. Preserve existing comment style and align key/value pairs to keep diffs tight.

## Testing Guidelines
There is no automated test suite; rely on targeted manual checks. After shell edits, run `bash -n` and exercise the primary flows (`./switch-theme current`, `./switch-theme restore`). For Neovim updates, start `nvim` to confirm Lua config loads; for tmux changes, run `tmux source-file ~/.tmux.conf.local`. When adjusting theme assets, verify a new snapshot appears under `.theme-backups/` and the reload guidance in script output still matches reality.

## Commit & Pull Request Guidelines
Git history favors tight subjects like `themes` or date-stamped entries (`20251029`). Follow that pattern: concise, imperative subject, optional context in the body, and manual verification notes. Squash unrelated tweaks, link any tracking issue, and flag required follow-up commands (for example rerunning `setup-ghostty.sh`). Add screenshots or terminal captures whenever theme output changes.

## Environment & Configuration Tips
Ensure host machines are clean before re-running symlink scripts to avoid overwriting local overrides. Never store secrets in this repo; prefer environment variables or credential stores. When you add tooling, document installation in `README.md` and ship matching config under `.config/<tool>/` so the bootstrap flow stays reproducible.
