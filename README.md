# dots
A repository containing instructions and dotfiles for tools I use across multiple development machines.

The intended model is:

* one `main` branch
* shared tracked config
* OS-specific tracked overlays
* host-specific tracked overlays
* untracked local/private overrides

The repo now includes a layered bootstrap flow for symlinking managed files into
a machine:

* `bin/bootstrap plan`
* `bin/bootstrap status`
* `bin/bootstrap apply`

See [docs/BOOTSTRAP.md](/Users/rick.spurgeon/dev/rspurgeon/dots/docs/BOOTSTRAP.md)
for the manifest layout, backup behavior, and the shared/OS/host overlay model.

For CLI tool installation policy, see [docs/MISE.md](/Users/rick.spurgeon/dev/rspurgeon/dots/docs/MISE.md).

The repo is intended to keep one `main` branch that supports machine diversity
through overlays rather than long-lived machine branches.

The shell config is layered:

* `.zshrc` is a thin loader
* `shell/zshrc.shared` contains the common baseline
* `shell/zshrc.macos` or `shell/zshrc.linux` contains OS-specific setup
* `shell/zshrc.host.<hostname>` is for tracked host-specific overrides
* `~/.config/rspurgeon/local.zsh` is the untracked local include for secrets and machine-private paths
* `local/local.zsh.example` and `local/git-config.local.example` show the intended local-only shape

The bootstrap manifests are also layered:

* `bootstrap/manifest.d/00-shared.tsv`
* `bootstrap/manifest.d/10-macos.tsv`
* `bootstrap/manifest.d/10-linux.tsv`
* `bootstrap/manifest.d/20-host-<hostname>.tsv`

## New Machine Workflow

For a new machine or a major refactor migration, use this order:

1. Clone the repo to `$HOME/dev/rspurgeon/dots`
2. Install base OS packages and fonts
3. Install `oh-my-zsh`
4. Run `bin/mise-sync install`
5. Run `bin/setup-nvim`
6. Run `bin/setup-tmux`
7. Create local-only files as needed:
* `~/.config/rspurgeon/local.zsh`
* `~/.config/git/config.local`
8. Run `bin/bootstrap plan`
9. Run `bin/bootstrap apply`
10. Open a new shell and verify the machine with:
* `bin/bootstrap status`
* `bin/mise-sync status`

## Overlay Rules

Use this rule of thumb when deciding where config belongs:

* Shared defaults used on most machines belong in shared tracked config.
* OS-specific behavior belongs in `shell/zshrc.<os>` or `bootstrap/manifest.d/10-<os>.tsv`.
* Stable host-specific behavior belongs in `shell/zshrc.host.<hostname>` or `bootstrap/manifest.d/20-host-<hostname>.tsv`.
* Secrets, private tokens, personal aliases, and machine-private paths belong in untracked local files.

Examples of local-only files:

* `~/.config/rspurgeon/local.zsh`
* `~/.config/git/config.local`

Do not use long-lived machine branches for normal setup. Prefer extending the
overlay model on `main`.

I use the `zsh` shell which is the default on macOS Monterey, the current OS of choice. The `brew install` commands below could be replaced with a `Brewfile` solutions, I just haven't take the time yet.

Clone *this* repo 
* `git clone git@github.com:rspurgeon/dots.git $HOME/dev/rspurgeon/`

Install the [xcode command line tools](https://mac.install.guide/commandlinetools/4.html)
* `xcode-select –install`

Install [Homebrew](https://brew.sh/)
* `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`

Install fonts
* `brew tap homebrew/cask-fonts
brew search '/font-.*-nerd-font/' | awk '{ print $1 }' | xargs -I{} brew install --cask {} || true`
* https://github.com/rspurgeon/nerd-fonts#patched-fonts

Install [JetBrains Mono Nerd Font](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/JetBrainsMono)
* Use your platform package manager or install from the Nerd Fonts project
* The active Ghostty, Neovim GUI, and iTerm2 configs use `JetBrainsMono Nerd Font Mono`

Install various tools
* `brew install wget zsh-syntax-highlighting`

Install shared CLI tools from the repo-managed `mise` config
* `bin/mise-sync install`

Install [iTerm2](https://iterm2.com/)
* Once installed, import the profile in `$HOME/dev/rspurgeon/dots/iterm2-default-profile.json` and switch to iTerm 

Install [NeoVim](https://github.com/vim/vim)
* `brew install neovim`

Install NeoVim Packer
* `bin/setup-nvim`
* Then run `nvim +PackerSync`

Install nvm
* `curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash`

Install [pyenv](https://github.com/pyenv/pyenv)
* `brew install openssl readline sqlite3 xz zlib pyenv pyenv-virtualenv`
* `pyenv install 3.8.13`
* `pyenv global 3.8.13`

Install [sdkman](https://sdkman.io/install)
* `curl -s "https://get.sdkman.io" | bash`
* `source "$HOME/.sdkman/bin/sdkman-init.sh"`
* `sdk install java 11.0.14-zulu`

Install [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh)
* `sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"`

Install Starship
* https://starship.rs/guide/#%F0%9F%9A%80-installation

Install [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md)
* `git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions`

Install [tmux](https://github.com/tmux/tmux/wiki)
* `brew install tmux`

Install [.tmux](https://github.com/gpakosz/.tmux), which is a nice base tmux configuration
* `bin/setup-tmux`
* This installs the gpakosz base config at `~/dev/gpakosz/.tmux`, links `~/.tmux.conf`, installs TPM, and prepares tmux plugins

Install [tmuxinator](https://github.com/tmuxinator/tmuxinator)
* `brew install tmuxinator`

Install tmux plugins
* `bin/setup-tmux`
* If tmux is already running, the script reloads the base and local config and installs TPM plugins
* Otherwise start tmux and run `~/.tmux/plugins/tpm/bin/install_plugins`, or press `prefix + I`

Install [powerline status bar](), which I use in vim and tmux
* `pip install powerline-status`

Enable the environment by creating symbolic links to the dotfiles in this repository 
* `bin/bootstrap plan`
* `bin/bootstrap apply`
* Managed paths currently include `.zshrc`, `.vimrc`, `.tmux.conf.local`, `.config/alacritty`, `.config/git/config`, `.config/nvim`, `.config/powerline`, `.config/starship.toml`, `.config/starship-simple.toml`, `.config/tmux-powerline`, `.config/tmux-powerline-segments`, `.config/ghostty`, `.local/bin/pitch`, `.local/bin/pitch-mcp`, and the iTerm2 dynamic profile on macOS
* `mise` is handled by `bin/mise-sync`, which copies `mise/config.toml` into `~/.config/mise/config.toml` instead of symlinking it

## Linux Host Notes

Some Linux hosts may also have host-specific tracked entries such as:

* Hyprland config in `.config/hypr`
* Waybar config in `.config/waybar`
* host-specific helper configs like `.config/pitch`, `.config/codex/guest`, or `nono/profiles`
* host-specific theme assets under `.config/omarchy/themes/...`

These should normally be introduced through `bootstrap/manifest.d/20-host-<hostname>.tsv`.

For `systemd --user` units on Linux:

* Keep the tracked unit file contents in the repo under `.config/systemd/user/*.service` and `*.timer`.
* Reload and activate them with `systemctl --user daemon-reload` and the appropriate `enable` or `start` commands.
* Avoid assuming repo-managed `*.wants` symlinks belong in Git or bootstrap manifests unless you have verified that behavior on the target host.

Install [exa](https://github.com/ogham/exa) for better file listing
* `brew install exa`

Install [fzf](https://github.com/junegunn/fzf) for powerful search
* `brew install fzf`
* Install shell integrations with `/opt/homebrew/opt/fzf/install`

Install [ag](https://github.com/ggreer/the_silver_searcher), the silver searcher 
* `brew install the_silver_searcher`

Install [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl-macos/#install-with-homebrew-on-macos)
* `brew install kubectl`
