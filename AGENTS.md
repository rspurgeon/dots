# Repository Guidelines

## Read This First
Before making machine-setup or repo-structure changes, read these files in this order:

1. `README.md`
2. `docs/BOOTSTRAP.md`
3. `docs/MISE.md`

`README.md` is the human-facing overview and setup guide. `docs/BOOTSTRAP.md`
defines the managed symlink model. `docs/MISE.md` defines the CLI tool policy.
Prefer updating those docs over restating them elsewhere.

Terminal note: Alacritty is the primary terminal across machines. Treat
`.config/alacritty/alacritty.toml` as the authoritative source for terminal
font size, padding, and terminal-local behavior unless a task explicitly
references Ghostty. Keep `.config/ghostty` usable, but treat it as secondary.

## Project Structure & Module Organization
The repo root stores shared dotfiles (`.zshrc`, `.vimrc`, `.tmux.conf.local`) plus iTerm2 and Starship profiles. Tool-specific assets live under `.config/<tool>/` so the layout mirrors the eventual host: Ghostty themes, Neovim Lua, tmux and powerline segments, and Starship presets. Utility scripts (`switch-theme`, `tmux-sessionizer`, `setup-ghostty.sh`) coordinate theme changes, tmux session bootstraps, and symlink setup; treat them as canonical and link into `$HOME` after local edits.

Machine diversity is handled in `main` through overlays, not long-lived
branches:

- shared tracked config
- OS-specific tracked overlays
- host-specific tracked overlays
- untracked local/private overrides

Relevant layout:

- `shell/zshrc.shared`, `shell/zshrc.<os>`, `shell/zshrc.host.<hostname>`
- `bootstrap/manifest.d/00-shared.tsv`, `10-<os>.tsv`, `20-host-<hostname>.tsv`
- `local/local.zsh.example`, `local/git-config.local.example`
- `mise/config.toml`

## Build, Test, and Development Commands
- `./setup-ghostty.sh` — links `.config/ghostty` into `~/.config/ghostty`; rerun after Ghostty tweaks.
- `./bin/bootstrap plan` — preview managed links for the current host and OS.
- `./bin/bootstrap status` — verify current machine links match repo expectations.
- `./bin/bootstrap apply` — back up conflicting paths to `~/.dots-backups/` and apply managed symlinks.
- `./bin/mise-sync install` — copy `mise/config.toml` into `~/.config/mise/config.toml` and install/update shared CLI tools.
- `./bin/mise-sync status` — show current and outdated `mise` tools.
- `./switch-theme list` — lists registered themes; extend `AVAILABLE_THEMES` and mapping tables when adding new ones.
- `./switch-theme switch tokyo-night` — syncs Ghostty, Neovim, tmux, and tmux-powerline while snapshotting to `.theme-backups/`.
- `./switch-theme restore` — restores the most recent backup during theme experiments.

## Coding Style & Naming Conventions
Scripts are POSIX-friendly `bash` with `set -e`; keep four-space indentation inside conditionals and functions. Use descriptive, kebab-case filenames for executables and mirror runtime layouts by grouping `.toml`, `.lua`, and `.sh` under the appropriate `.config/<tool>/` directory. Preserve existing comment style and align key/value pairs to keep diffs tight.

## Testing Guidelines
There is no automated test suite; rely on targeted manual checks. After shell edits, run `bash -n` and exercise the primary flows (`./switch-theme current`, `./switch-theme restore`). For Neovim updates, start `nvim` to confirm Lua config loads; for tmux changes, run `tmux source-file ~/.tmux.conf.local`. When adjusting theme assets, verify a new snapshot appears under `.theme-backups/` and the reload guidance in script output still matches reality.

For bootstrap or machine-setup work, also verify:

- `./bin/bootstrap plan`
- `./bin/bootstrap status`
- `zsh -ic 'echo $DOTS_OS $DOTS_HOSTNAME'`
- `./bin/mise-sync status`

If you change host-specific Linux desktop config, verify the real target paths in
`$HOME/.config/...` after `bin/bootstrap apply`.

## Commit & Pull Request Guidelines
Git history favors tight subjects like `themes` or date-stamped entries (`20251029`). Follow that pattern: concise, imperative subject, optional context in the body, and manual verification notes. Squash unrelated tweaks, link any tracking issue, and flag required follow-up commands (for example rerunning `setup-ghostty.sh`). Add screenshots or terminal captures whenever theme output changes.

## Environment & Configuration Tips
Ensure host machines are clean before re-running symlink scripts to avoid overwriting local overrides. Never store secrets in this repo; prefer environment variables or credential stores. When you add tooling, document installation in `README.md` and ship matching config under `.config/<tool>/` so the bootstrap flow stays reproducible.

When deciding where a change belongs:

- Put cross-machine defaults in shared tracked config.
- Put OS-specific behavior in `shell/zshrc.<os>` or `bootstrap/manifest.d/10-<os>.tsv`.
- Put stable host-specific behavior in `shell/zshrc.host.<hostname>` or `bootstrap/manifest.d/20-host-<hostname>.tsv`.
- Put secrets, personal tokens, and machine-private paths in `~/.config/rspurgeon/local.zsh` or `~/.config/git/config.local`.

Do not create long-lived machine branches unless explicitly asked. Prefer one
`main` branch plus overlays.

Treat `mise` specially: the intended model is a copied global config at
`~/.config/mise/config.toml`, not a symlink back into the repo.

Treat `systemd --user` carefully on Linux:

- Keep repo-managed unit file contents in `.config/systemd/user/*.service` and `*.timer`.
- Prefer runtime activation with `systemctl --user daemon-reload` plus `enable`/`start`.
- Do not assume `default.target.wants` symlinks should be committed or managed by bootstrap.
- If symlinked unit files cause `systemctl` issues on a host, prefer copying the unit files into `~/.config/systemd/user` for runtime use while keeping the repo files authoritative.

For new machine onboarding or refactors, the safest sequence is:

1. Inspect `git status`, current branch, and `origin/main`.
2. Compare local changes against `origin/main`.
3. Integrate changes onto `origin/main`, not onto an old machine branch.
4. Run `bin/bootstrap plan`, then `bin/bootstrap apply`.
5. Run `bin/mise-sync install`.
6. Verify shell, tmux, Neovim, and any host-specific Linux desktop/service paths.
