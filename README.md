
zsh shell, default on macOS Monteray

[install xcode command line tools](https://mac.install.guide/commandlinetools/4.html)

[Powerline Fonts](https://github.com/powerline/fonts) run `install.sh` script
[Homebrew](https://brew.sh/)

[iTerm2](https://iterm2.com/)
Use `iterm2-default-profile.json` profile for iterm2

clone `vim` locally:
`git clone git@github.com:vim/vim.git $DEV/vim/`

[pyenv](https://github.com/pyenv/pyenv)
`brew install openssl readline sqlite3 xz zlib`
`pyenv install 3.8.13`
`pyenv global 3.8.13`

[sdkman](https://sdkman.io/install)
`sdk install java 11.0.14-zulu`

`brew install wget`
`brew install zsh-syntax-highlighting`

`brew install vim`
Restart shell for updated `$PATH`

[Spectacle](https://www.spectacleapp.com/)

[oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh)
`sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"`

[spaceship prompt](https://github.com/spaceship-prompt/spaceship-prompt)
`git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1`
`ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"`

[zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md)
`git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions`

[tmux](https://github.com/tmux/tmux/wiki)
[.tmux](https://github.com/gpakosz/.tmux)
`ln -s -f $DEV/gpakosz/.tmux/.tmux.conf ~/.tmux.conf`

[zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md)

clone *this* repo to `$HOME/dev/rspurgeon/dots`

sym links 
`ln -s $DEV/rspurgeon/dots/.zshrc ~/.zshrc`
`ln -s $DEV/rspurgeon/dots/.vimrc $HOME/.vimrc`
`ln -s $DEV/rspurgeon/dots/.tmux.conf.local $HOME/.tmux.conf.local`
`ln -s powerline config....`

[powerline]()
`pip install powerline-status`

Modify the `.vimrc` file to load the run time path to the installed powerline site packages (TODO: Figure out how to auto-detect this from `pyenv`):
set rtp+=$HOME/.pyenv/versions/3.8.13/lib/python3.8/site-packages/powerline/bindings/vim/

[exa](https://github.com/ogham/exa)
`brew install exa`

[fzf](https://github.com/junegunn/fzf)
`brew install fzf`
`/opt/homebrew/opt/fzf/install`

[ag](https://github.com/ggreer/the_silver_searcher)
`brew install the_silver_searcher`

