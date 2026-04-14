# Mise

Use `mise` as the default package manager for CLI tools whenever it supports the
tool you want. That gives the dots repo one shared, reproducible command-line
baseline across machines.

The shared config should be small and curated. Do not treat it as a dumping
ground for every possible CLI.

## Recommendation

Use `mise` for:

- shells and prompt tools like `starship` and `zoxide`
- editors and terminal tools like `neovim`, `tmux`, `fzf`, `ripgrep`, `fd`, `eza`, `yazi`
- common dev CLIs like `gh`, `terraform`, `kubectl`, `gcloud`, `vale`
- language runtimes and language-scoped CLIs where `mise` support is good

Do not force everything into `mise`. Keep using the platform package manager for:

- GUI apps like iTerm2, Ghostty, Arc
- fonts
- tools that `mise` does not support well
- services, drivers, and OS integrations

## Shared vs local

Shared baseline:

- [mise/config.toml](/Users/rick.spurgeon/dev/rspurgeon/dots/mise/config.toml)
- anything every machine should have by default
- pin versions after they are proven to install cleanly

Machine-local:

- `mise use -g <tool>@<version>`
- anything you are trialing, or anything specific to one machine only
- work-in-progress or work-only entries can live in [mise/work.toml.example](/Users/rick.spurgeon/dev/rspurgeon/dots/mise/work.toml.example)

## Workflow

1. Install or try a tool locally, and prefer an exact pinned version once it is working:

```bash
mise use -g --pin neovim@0.12.1
```

2. If the tool should become part of the shared baseline, add it to
[mise/config.toml](/Users/rick.spurgeon/dev/rspurgeon/dots/mise/config.toml).

3. Sync the machine to the shared config:

```bash
bin/mise-sync install
```

`bin/mise-sync` first copies the repo-managed config into
`~/.config/mise/config.toml`, then runs `mise` against `$HOME`.

This is intentional: `mise` does not behave reliably when its global config is a
symlink back into the active repo. For `mise`, a copied global config is more
stable than a symlink.

4. Verify current state:

```bash
bin/mise-sync status
```

5. Commit the config update in the dots repo.

## Shared baseline policy

Only put a tool into `mise/config.toml` when all of these are true:

- it is needed on almost every machine
- it installs cleanly on the target platforms you care about
- the chosen backend is stable
- the version is pinned intentionally

If any of those are false, keep it out of the shared baseline for now.

## Rule of thumb

- Start local with `mise use -g`
- Promote to shared when you want the tool on future machines by default

That keeps the shared config intentional instead of turning it into a log of
one-off experiments.
