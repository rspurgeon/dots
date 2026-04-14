# Bootstrap

This repo now includes a layered manifest-driven bootstrap flow for linking
managed files into the local machine.

CLI tool installation is handled separately through `mise`. See
[docs/MISE.md](/Users/rick.spurgeon/dev/rspurgeon/dots/docs/MISE.md).

## Goals

- Keep shared defaults in one branch instead of treating branches as host profiles.
- Make machine onboarding repeatable and backup-safe.
- Allow host- and OS-specific entries without hardcoding those rules into the script.
- Keep one repo that can represent multiple machine types cleanly.

## Commands

Run from the repo root:

```bash
bin/bootstrap plan
bin/bootstrap status
bin/bootstrap apply
```

`plan` shows the symlinks that would be created for the current host and OS.

`status` reports whether each managed path is already linked correctly.

`apply` creates symlinks and backs up any conflicting files or directories to
`~/.dots-backups/<timestamp>/...` before changing them.

## Manifest layout

Bootstrap reads manifests in this order:

- `DOTS_MANIFEST` if explicitly set
- otherwise every `*.tsv` file in [bootstrap/manifest.d](/Users/rick.spurgeon/dev/rspurgeon/dots/bootstrap/manifest.d)
- otherwise the legacy fallback [bootstrap/manifest.tsv](/Users/rick.spurgeon/dev/rspurgeon/dots/bootstrap/manifest.tsv)

This lets `main` keep one repo while separating:

- shared links
- OS-specific links
- host-specific links

Each non-comment row is tab-separated:

```text
source<TAB>target<TAB>os<TAB>host
```

- `source`: path relative to the repo root
- `target`: destination path, `~/...` supported
- `os`: `macos`, `linux`, `*`, or a comma-separated list
- `host`: exact hostname, `*`, or a comma-separated list

Example:

```text
.config/ghostty	~/.config/ghostty	*	*
.config/alacritty	~/.config/alacritty	*	*
iterm2-default-profile.json	~/Library/Application Support/iTerm2/DynamicProfiles/rspurgeon-dots-profile.json	macos	*
```

Recommended manifest split:

- `bootstrap/manifest.d/00-shared.tsv`
- `bootstrap/manifest.d/10-macos.tsv`
- `bootstrap/manifest.d/10-linux.tsv`
- `bootstrap/manifest.d/20-host-<hostname>.tsv`

`mise` is intentionally excluded from the bootstrap manifest. Use
`bin/mise-sync install` to copy [mise/config.toml](/Users/rick.spurgeon/dev/rspurgeon/dots/mise/config.toml)
into `~/.config/mise/config.toml` and then install/update tools from there.

Runtime/plugin managers are also handled outside bootstrap. For tmux, use
[bin/setup-tmux](/Users/rick.spurgeon/dev/rspurgeon/dots/bin/setup-tmux) to install TPM and then install tmux plugins.
For Neovim, use [bin/setup-nvim](/Users/rick.spurgeon/dev/rspurgeon/dots/bin/setup-nvim) to install `packer.nvim`, then run `nvim +PackerSync`.

## Overlay model

`main` is intended to support multiple machines from one repo.

Use this layering model:

- shared tracked config
- OS-specific tracked overlays
- host-specific tracked overlays
- untracked local/private overlays

Current shell overlay files:

- `.zshrc`
- `shell/zshrc.shared`
- `shell/zshrc.macos`
- `shell/zshrc.linux`
- `shell/zshrc.host.HL29YR2H3Q`
- `shell/zshrc.host.omarchy`
- `~/.config/rspurgeon/local.zsh`

That keeps Linux-specific files in the repo without forcing them onto macOS, and
keeps macOS-specific files in the repo without forcing them onto Linux.

## Local-only includes

Tracked config should stay free of secrets and machine-private paths. Prefer
optional local includes for values that should not be committed, for example:

- `~/.config/rspurgeon/local.zsh`
- `~/.config/git/config.local`

The shared tracked config can source those files when they exist.

Example starter files live in:

- [local/local.zsh.example](/Users/rick.spurgeon/dev/rspurgeon/dots/local/local.zsh.example)
- [local/git-config.local.example](/Users/rick.spurgeon/dev/rspurgeon/dots/local/git-config.local.example)

For the current shell setup, the loader order is:

1. `.zshrc`
2. `shell/zshrc.shared`
3. `shell/zshrc.<os>`
4. `shell/zshrc.host.<hostname>`
5. `~/.config/rspurgeon/local.zsh`
