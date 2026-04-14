export DOTS_DIR="${DOTS_DIR:-$HOME/dev/rspurgeon/dots}"
export DOTS_HOSTNAME="${DOTS_HOSTNAME:-$(hostname)}"

case "$(uname -s)" in
    Darwin) export DOTS_OS="macos" ;;
    Linux) export DOTS_OS="linux" ;;
    *) export DOTS_OS="unknown" ;;
esac

for fragment in \
    "$DOTS_DIR/shell/zshrc.shared" \
    "$DOTS_DIR/shell/zshrc.$DOTS_OS" \
    "$DOTS_DIR/shell/zshrc.host.$DOTS_HOSTNAME" \
    "$HOME/.config/rspurgeon/local.zsh"
do
    [ -f "$fragment" ] && source "$fragment"
done
