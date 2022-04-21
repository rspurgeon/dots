# dots
A repository containing dotfiles and instructions for tools I use on my dev environment.

I use the `zsh` shell which is the default on macOS Monterey, the current OS of choice. The `brew install` commands below could be replaced with a `Brewfile`, just haven't take the time yet.

Clone *this* repo 
* `git clone git@github.com:rspurgeon/dots.git $HOME/dev/rspurgeon/`

Install the [xcode command line tools](https://mac.install.guide/commandlinetools/4.html)
* `xcode-select –install`

Install [Powerline Fonts](https://github.com/powerline/fonts)
* `git clone git@github.com:powerline/fonts.git $HOME/dev/powerline`
* `$HOME/dev/powerline/install.sh`

Install various tools
* `brew install wget`
* `brew install zsh-syntax-highlighting`

Install [Homebrew](https://brew.sh/)
* `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`

Install [iTerm2](https://iterm2.com/)
* Once installed, import the profile in `$HOME/dev/rspurgeon/dots/iterm2-default-profile.json` 

Install [vim](https://github.com/vim/vim)
* `brew install vim`
* Restart shell for updated `$PATH`
* Clone `vim` source locally 
	* I use the local directory for the `VIMRUNTIME` variable. This is probably optional and could be replaced by setting `VIMRUNTIME` to the installed location I just haven't taken the time to figure this out
	* `git clone git@github.com:vim/vim.git $HOME/dev/vim`

Install [pyenv](https://github.com/pyenv/pyenv)
* `brew install openssl readline sqlite3 xz zlib pyenv pyenv-virtualenv`
* `pyenv install 3.8.13`
* `pyenv global 3.8.13`

Install [sdkman](https://sdkman.io/install)
* `curl -s "https://get.sdkman.io" | bash`
* `source "$HOME/.sdkman/bin/sdkman-init.sh"`
* `sdk install java 11.0.14-zulu`

Install [Spectacle](https://www.spectacleapp.com/), which I use for window management.
* Spectacle is no longer maintained, so considering switching to another tool, like [Moom](https://manytricks.com/moom/)

Install [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh)
* `sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"`

Install [spaceship prompt](https://github.com/spaceship-prompt/spaceship-prompt)
* `git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1`
* `ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"`

Install [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md)
* `git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions`

Install [tmux](https://github.com/tmux/tmux/wiki)
* `brew install tmux`

Install [.tmux](https://github.com/gpakosz/.tmux), which is a nice base tmux configuration
* `git clone https://github.com/gpakosz/.tmux.git $HOME/dev/gpakosz`
* `ln -s -f $HOME/dev/gpakosz/.tmux/.tmux.conf ~/.tmux.conf`

Enable the environment by creating symbolic links to the dotfiles in this repository 
* `ln -s $DEV/rspurgeon/dots/.zshrc ~/.zshrc`
* `ln -s $DEV/rspurgeon/dots/.vimrc $HOME/.vimrc`
* `ln -s $DEV/rspurgeon/dots/.tmux.conf.local $HOME/.tmux.conf.local`
* `ln -s -f $DEV/rspurgeon/dots/.config/powerline ~/.config/powerline`

Install [powerline status bar](), which I use in vim and tmux
* `pip install powerline-status`

Modify `$HOME/.vimrc` file to load the run time path to the installed powerline site packages (TODO: Figure out how to auto-detect this from `pyenv`).
* `set rtp+=$HOME/.pyenv/versions/3.8.13/lib/python3.8/site-packages/powerline/bindings/vim/`

Install [exa](https://github.com/ogham/exa) for better file listing
* `brew install exa`

Install [fzf](https://github.com/junegunn/fzf) for powerful search
* `brew install fzf`
* Install shell integrations with `/opt/homebrew/opt/fzf/install`

Install [ag](https://github.com/ggreer/the_silver_searcher), the silver searcher 
* `brew install the_silver_searcher`

