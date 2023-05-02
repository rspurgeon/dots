# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export XDG_CONFIG_HOME="$HOME/.config"

fpath=(/usr/local/share/zsh-completions $fpath)
#fpath+=(~/bin/functions "${fpath[@]}" )
fpath+=( ~/bin/functions )
fpath+=( "$(brew --prefix)/share/zsh/site-functions" )

# colors, a lot of colors!
function clicolors() {
    i=1
    for color in {000..255}; do;
        c=$c"$FG[$color]$color✔$reset_color  ";
        if [ `expr $i % 8` -eq 0 ]; then
            c=$c"\n"
        fi
        i=`expr $i + 1`
    done;
    echo $c | sed 's/%//g' | sed 's/{//g' | sed 's/}//g' | sed '$s/..$//';
    c=''
}

function weather() {
  curl wttr.in/$1;
}

ZSH_THEME="spaceship"

# tm - create new tmux session, or switch to existing one. Works from within tmux too
# `tm` will allow you to select your tmux session via fzf.
# `tm irc` will attach to the irc session (if it exists), else it will create it.
tm() {
  [[ -n "$TMUX" ]] && change="switch-client" || change="attach-session"
  if [ $1 ]; then
    tmux $change -t "$1" 2>/dev/null || (tmux new-session -d -s $1 && tmux $change -t "$1"); return
  fi
  session=$(tmux list-sessions -F "#{session_name}" 2>/dev/null | fzf --exit-0) &&  tmux $change -t "$session" || echo "No sessions found."
}

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

plugins=(
  vi-mode
  git
  colored-man-pages
  copypath
  macos
  wd
  zsh-autosuggestions
  kubectl
  docker
  docker-compose
)

export AWS_DEFAULT_REGION=us-west-2
export AWS_PROFILE=sandbox
export AWS_PAGER=

function cfgkong() {
  export KONG_GW_HOST=${1:-localhost}
  export KONG_ADMIN_PORT=${2:-8001}
  export KONG_DATA_PORT=${3:-8000}
  export KONG_GW_SCHEME=http
  export KONG_CP="$KONG_GW_SCHEME://$KONG_GW_HOST:$KONG_ADMIN_PORT"
  export kcp=$KONG_CP
  export KONG_DP="$KONG_GW_SCHEME://$KONG_GW_HOST:$KONG_DATA_PORT"
  export kdp=$KONG_DP
	export PROXY_IP=$kdp
}
cfgkong

function cfgkongfromk8s() {
	NAMESPACE="${NAMESPACE:-kong}"
	PROXY_NAME="${PROXY_NAME:-kong-proxy}"
	cfgkong $(kubectl get -o jsonpath="{.status.loadBalancer.ingress[0].ip}" service -n "$NAMESPACE" "$PROXY_NAME") 80 80
}
function cfgkongfromk8slb() {
	NAMESPACE="${NAMESPACE:-kong}"
	PROXY_NAME="${PROXY_NAME:-kong-proxy}"
	cfgkong $(kubectl get -o jsonpath="{.status.loadBalancer.ingress[0].hostname}" service -n "$NAMESPACE" "$PROXY_NAME") 80 80
}

# source ~/.local/bin/license --no-update
export KONG_LICENSE_FILE=/Users/rick.spurgeon@konghq.com/.kong-license-data/license.json
export KONG_LICENSE_DATA=$(cat $KONG_LICENSE_FILE)

export GIT_PAGER=

source $ZSH/oh-my-zsh.sh
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=240"

alias browse='open -a "Arc"'
alias b='browse'

alias m='make'

# alias vim='vim -O'
alias vim=nvim
alias e='vim'
alias v='vim'
alias vf='vim $(fzf --height 40% --reverse)'
bindkey -s "^f" 'vf^M'
export EDITOR=nvim

alias mux='tmuxinator'
alias wmip='dig @resolver4.opendns.com myip.opendns.com +short'

alias copy='pbcopy'
alias tf='terraform'
alias tfp='terraform plan -out plan'
alias tfa='terraform apply plan'
alias tfgo='tfp && tfa'
alias tfd='terraform destroy'
alias tfv='terraform validate'

alias ll='exa --long --header --git -F --no-user --icons'
alias lld='exa --long --header --git -F --no-user --icons -s modified -r'
alias l=ll
alias la='ll -a'
alias lli='ll -i'
alias lt='exa --tree'
alias ltt='exa --tree --level=2'
alias lttt='exa --tree --level=3'
alias ltttt='exa --tree --level=4'
alias lttttt='exa --tree --level=5'

alias tmake='make --dry-run'
alias makep='make -n'

alias lol='lolcat'
alias hunt='ag'
alias hunta='ag -A5 -B5'
alias spot='find . -name'

alias s='ag --nobreak --nonumbers --noheading . | fzf --delimiter=: --nth=2..'
#bindkey -s "^a" 'vc^M'
bindkey -M vicmd v edit-command-line

alias tmp=' directory=$(mktemp -d) && cd $directory'

alias k8=kubectl
alias kk='kubectl -n kong'
alias ks='kubectl -n kube-system'
alias kco='kubectl config unset current-context'

alias ping='prettyping --nolegend'
alias du="ncdu --color dark -rr -x --exclude .git --exclude node_modules"
alias help='tldr'

alias d='docker'
alias dc='docker compose'
alias dcud='docker compose up -d'
alias dcdv='docker compose down -v'
alias dps="docker ps --format 'table {{.Names}}\t{{.Status}}\t{{.ID}}'"
alias dpp="docker ps --format 'table {{.Names}}\t{{.Status}}\t{{.ID}}\t{{.Ports}}'"
alias dpa='docker ps -a'
alias dry='docker run --rm -it -v /var/run/docker.sock:/var/run/docker.sock -e DOCKER_HOST=$DOCKER_HOST moncho/dry'
alias ctop='docker run --rm -ti --name=ctop -v /var/run/docker.sock:/var/run/docker.sock quay.io/vektorlab/ctop:latest'

alias h='http --print=b'
alias hh='http --print=hH'
alias hhh='http --print=HhBb'
alias ht='http --offline'

function hdp() {
  if [[ $# -eq 0 ]]; then
    verb="get"
    url="/"
  elif [[ $# -eq 1 ]]; then
    verb="get"
    url="$@"
  else 
    verb="$1"
    shift 1
    url="$@"
  fi
  http --print=b $verb "$KONG_DP/$url"
}
function hhdp() {
  if [[ $# -eq 0 ]]; then
    verb="get"
    url="/"
  elif [[ $# -eq 1 ]]; then
    verb="get"
    url="$@"
  else 
    verb="$1"
    shift 1
    url="$@"
  fi
  http --print=hH $verb "$KONG_DP/$url"
}
function hhhdp() {
  if [[ $# -eq 0 ]]; then
    verb="get"
    url="/"
  elif [[ $# -eq 1 ]]; then
    verb="get"
    url="$@"
  else 
    verb="$1"
    shift 1
    url="$@"
  fi
  http --print=hbHB $verb "$KONG_DP/$url"
}

function hcp() {
  if [[ $# -eq 0 ]]; then
    verb="get"
    url="/"
  elif [[ $# -eq 1 ]]; then
    verb="get"
    url="$@"
  else 
    verb="$1"
    shift 1
    url="$@"
  fi

  http --print=b $verb "$KONG_CP/$url"
}
function hhcp() {
  if [[ $# -eq 0 ]]; then
    verb="get"
    url="/"
  elif [[ $# -eq 1 ]]; then
    verb="get"
    url="$@"
  else 
    verb="$1"
    shift 1
    url="$@"
  fi

  http --print=hH $verb "$KONG_CP/$url"
}
function hhhcp() {
  if [[ $# -eq 0 ]]; then
    verb="get"
    url="/"
  elif [[ $# -eq 1 ]]; then
    verb="get"
    url="$@"
  else 
    verb="$1"
    shift 1
    url="$@"
  fi

  http --print=hbHB $verb "$KONG_CP/$url"
}

function get_service_id() {
  http --print=b $kcp/services | jq -r '.data | .[] | select(.name == "'"$1"'") | .id'
}
function get_services() {
  http --print=b $kcp/services | jq -r '.data | .[]'
}
function get_consumers() {
  http --print=b $kcp/consumers | jq -r '.data | .[]'
}
function get_consumer_id() {
  http --print=b $kcp/consumers | jq -r '.data | .[] | select(.username == "'"$1"'") | .id'
}

alias g='git --no-pager'
alias gf='git fetch -P --tags -f'
alias gs='git status'
alias gd='git diff'
alias gdc='git diff --cached'
alias gc='git commit -m'
alias gpu='git pull'
alias ga='git add'
alias gl='git --no-pager log --oneline --abbrev-commit --graph --decorate --color -n 10'
alias gla='git --no-pager log --oneline --abbrev-commit --graph --decorate --color -n 10 --all'
alias gll='gl -n 20'
alias glll='gl -n 30'
alias grpo='git remote prune origin'
alias gout='git checkout'
alias ggo='git checkout'
alias gsa='git --no-pager stash list'

alias lg=lazygit

alias awsl='saml2aws --username=$SAML2AWS_USERNAME --password=$SAML2AWS_PASSWORD --skip-prompt --role $SAML2AWS_ROLE login'
alias awso='AWS_PROFILE='
awso

cheat() { q="$1" ; curl https://cheat.sh/$q }

export PS1="$PS1"

export DEV=$HOME/dev

export HISTSIZE=20000000
export HISTFILE=$HOME/.zsh_history

export FZF_DEFAULT_OPTS='--layout=reverse'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Enable zsh completions
autoload -U compinit && compinit
autoload -U +X bashcompinit && bashcompinit

complete -F __start_kubectl k
complete -o nospace -C /opt/homebrew/bin/terraform terraform

eval "$(pyenv init --path)"
eval "$(pyenv virtualenv-init -)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

eval "$(rbenv init - zsh)"

eval "$(starship init zsh)"

export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
export PATH=~/.local/bin:$PATH
export PATH=~/bin:$PATH

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

