# dots
A repository containing instructions and dotfiles for tools I use on my dev environment.

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

Install [Sauce Code Pro Nerd Font](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/SourceCodePro)
* `brew tap homebrew/cask-fonts`
* `brew install --cask font-sauce-code-pro-nerd-font`

Install various tools
* `brew install wget zsh-syntax-highlighting`

Install [iTerm2](https://iterm2.com/)
* Once installed, import the profile in `$HOME/dev/rspurgeon/dots/iterm2-default-profile.json` and switch to iTerm 

Install [NeoVim](https://github.com/vim/vim)
* `brew install neovim`

Install NeoVim Packer
* `git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim`

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
* `git clone https://github.com/gpakosz/.tmux.git $HOME/dev/gpakosz`
* `ln -s -f $HOME/dev/gpakosz/.tmux/.tmux.conf ~/.tmux.conf`

Install [tmuxinator](https://github.com/tmuxinator/tmuxinator)
* `brew install tmuxinator`

Install [powerline status bar](), which I use in vim and tmux
* `pip install powerline-status`

Enable the environment by creating symbolic links to the dotfiles in this repository 
* `ln -s $DEV/rspurgeon/dots/.zshrc ~/.zshrc`
* `ln -s $DEV/rspurgeon/dots/.vimrc $HOME/.vimrc`
* `ln -s $DEV/rspurgeon/dots/.tmux.conf.local $HOME/.tmux.conf.local`
* .config/nvim
* .config/powerline
* .config/starship.toml
* .config/tmux-powerline

Install [exa](https://github.com/ogham/exa) for better file listing
* `brew install exa`

Install [fzf](https://github.com/junegunn/fzf) for powerful search
* `brew install fzf`
* Install shell integrations with `/opt/homebrew/opt/fzf/install`

Install [ag](https://github.com/ggreer/the_silver_searcher), the silver searcher 
* `brew install the_silver_searcher`

Install [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl-macos/#install-with-homebrew-on-macos)
* `brew install kubectl`

