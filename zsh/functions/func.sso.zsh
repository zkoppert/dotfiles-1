SSO_SET() {
    for sso_set in "$HOME/.dotfiles/**/.sso_set/*"; do
        if [ -r "$sso_set" ]; then
            source "$sso_set" || return 0
        fi
    done
    unset sso_set
}
SSO_LOAD() {
    for sso_load in "$HOME/.dotfiles/**/.sso_load/*"; do
        if [ -r "$sso_load" ]; then
            source "$sso_load" || return 0
        fi
    done
    unset sso_load
}
