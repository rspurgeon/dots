# Minimal non-interactive zsh environment.
# Keep this quiet: it is read by every zsh invocation, including ssh host command.

typeset -U path
path=("$HOME/.local/bin" $path)
export PATH

if [ -z "${SSH_AUTH_SOCK:-}" ] && [ -n "${XDG_RUNTIME_DIR:-}" ] && [ -S "$XDG_RUNTIME_DIR/ssh-agent.socket" ]; then
    export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
fi
