# Login-shell profile setup.

typeset -U path
path=("$HOME/.local/bin" $path)
export PATH

if [ -x "$HOME/.local/bin/mise" ]; then
    eval "$(env -u MISE_DATA_DIR "$HOME/.local/bin/mise" activate zsh --shims)"
fi
