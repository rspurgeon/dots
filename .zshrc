export DOTS_DIR="${DOTS_DIR:-$HOME/dev/rspurgeon/dots}"
export DOTS_HOSTNAME="${DOTS_HOSTNAME_OVERRIDE:-$(hostname)}"

case "$(uname -s)" in
    Darwin) export DOTS_OS="macos" ;;
    Linux) export DOTS_OS="linux" ;;
    *) export DOTS_OS="unknown" ;;
esac

dots_profiles() {
    if [ -n "${DOTS_PROFILES_OVERRIDE:-}" ]; then
        printf '%s\n' "$DOTS_PROFILES_OVERRIDE"
        return
    fi

    local hosts_file="$DOTS_DIR/bootstrap/hosts.tsv"
    [ -f "$hosts_file" ] || return 0

    local host profiles
    while IFS=$'\t' read -r host profiles; do
        if [ -z "${host:-}" ] || [[ "$host" == \#* ]]; then
            continue
        fi

        if [ "$host" = "$DOTS_HOSTNAME" ]; then
            printf '%s\n' "${profiles:-}"
            return
        fi
    done < "$hosts_file"
}

export DOTS_PROFILES="${DOTS_PROFILES_OVERRIDE:-$(dots_profiles)}"

for fragment in \
    "$DOTS_DIR/shell/zshrc.shared" \
    "$DOTS_DIR/shell/zshrc.$DOTS_OS" \
    ${(s:,:)DOTS_PROFILES/#/$DOTS_DIR/shell/zshrc.profile.} \
    "$DOTS_DIR/shell/zshrc.host.$DOTS_HOSTNAME" \
    "$HOME/.config/rspurgeon/local.zsh"
do
    if [ -f "$fragment" ]; then
        source "$fragment"
    fi
done
