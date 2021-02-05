declare REPO_HOME="${REPO_HOME:-${XDG_DATA_HOME:-$HOME/.local/share}/repositories}"
declare REPO_LIST=()

__cut_URL() {
    printf '%s' "$1" | awk -F '/' '{
    if (match($0, /^(git|https?):\/\//)) {
        print $0
        } else {
        print "https://github.com/" $0
        }
    }'
}
__cut_NAME() {
    printf '%s' "$1" | awk -F '/' '{ print $(NF - 1) "/" $NF }'
}
GET_REPO_LIST() {
    local repo_init="$1"
    REPO_LIST+=("repo_init")
}
REPO_INSTALL() {
    local repo_init plugin_name clone_url clone_dest
    mkdir -p "$REPO_HOME"
    for repo_init in ${REPO_LIST[*]}; do
        plugin_name="$(__cut_NAME "$repo_init")"
        # Because URL is not always full, we need to resolve it first
        clone_url="$(__cut_URL "$repo_init")"
        clone_dest="$REPO_HOME/$plugin_name"
        # Skip plugin if destination already exists
        if [ -d "$clone_dest" ]; then
            printf '%s is already installed, skipping' "$repo_init"
            continue
        fi
        printf 'Cloning %s ...\n' "$repo_init"
        git clone "$clone_url" "$clone_dest" -q --depth 1 || (
            printf 'Failed to install %s, exiting' "$repo_init"
            return 1
        )
    done
}
sso_add() {
    case "$1" in
    repo) GET_REPO_LIST "$2" ;;
    install) REPO_INSTALL ;;
    esac
}
