# Minimal non-interactive zsh environment.
# Keep this quiet: it is read by every zsh invocation, including ssh host command.

typeset -U path
path=("$HOME/.local/share/mise/shims" "$HOME/.local/bin" $path)
export PATH
