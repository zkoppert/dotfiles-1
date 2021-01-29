#!/usr/bin/env bash
# ============================================================================= #
#  ➜ ➜ ➜ IMPORTS
# ============================================================================= #
current_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# Load files
#shellcheck disable=SC1073,SC1090
. "$current_dir/colors.sh"
#shellcheck disable=SC1073,SC1090
. "$current_dir/msg_control.sh"
#shellcheck disable=SC1090
. "$current_dir/progress_bar.sh"
# .env loading in the shell

BAR() {
    enable_trapping
    # Create progress bar
    setup_scroll_area
    for i in {1..99}; do
        #if [ $i = 50 ]; then
        #    echo "waiting for user input"
        #    block_progress_bar $i
        #    read -p "User input: "
        #else
        draw_progress_bar "$i"
        sleep 0.5
        #fi
    done
    destroy_scroll_area
}
CONTINUE() {
    read -r -p "${1:-[y/N]}" response
    case $response in
    [yY][eE][sS] | [yY])
        true
        ;;
    *)
        false
        ;;
    esac
}
# ============================================================================= #
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do
    ABSOLUTE_PATH="$(cd -P "$(dirname "$SOURCE")" && pwd)"
    SOURCE="$(readlink "$SOURCE")"
    [[ $SOURCE != /* ]] && SOURCE="$ABSOLUTE_PATH/$SOURCE"
done
ABSOLUTE_PATH="$(cd -P "$(dirname "$SOURCE")" && pwd)"
# ============================================================================= #

# ============================================================================= #
#  ➜ ➜ ➜ FUNCTIONS & UTILITIES
# ============================================================================= #
#FIXME:
TRAP_CTRL() {

    trap SIGINT SIGQUIT SIGTSTP
    ctrlc_count=0
    ((ctrlc_count++))
    if [[ $ctrlc_count == 1 ]]; then
        echo "Stop that."
    elif [[ $ctrlc_count == 2 ]]; then
        echo "Once more and I quit."
    else
        echo "That's it.  I quit."
        exit 0
    fi
}

SET_BOO() {
    set -eE
    trap 'printf "\e[31m%s: %s\e[m\n" "BOO!" $?' ERR
}

FINISH() {
    MSGOK "All Done | Exiting..."
    exit 0
}
ERROR() {
    MSGERROR "$@" >&2
    exit 1
}
### !FIXME:
DOCONFIRM() {
    unset SKIP
    unset CONFIRM
    until [[ ${CONFIRM} =~ ^(y|n|s|Y|N|S|yes|no|skip|Yes|No|Skip|YES|NO|SKIP)$ ]]; do
        #echo -ne "[y/n]\n"
        read -r CONFIRM
        case $CONFIRM in
        y | Y | yes | Yes | YES) true ;;
        n | N | no | No | NO) false ;;
        s | S | skip | Skip | SKIP) MSGINFO "Skipped" && exit 0 ;;
        *)
            MSGERROR "Must answer"
            ;;
        esac
    done
}

CONTINUE() {
    read -r -p "${1:-[y/N]}" response
    case $response in
    [yY][eE][sS] | [yY])
        true
        ;;
    *)
        false
        ;;
    esac
}
# ============================================================================= #
WGET() { wget "${1}" --quiet --show-progress; }
CURL() {
    printf '..s%..' "Downloading: $1 ----> $2"
    sudo curl -fSL "$1" -o "$2"
}

ONLY_ROOT() {
    if [[ $USER == "root" ]]; then
        echo "Not running as root"
        exit 1
    fi
}
NEVER_ROOT() {
    if [[ "$EUID" -eq 0 ]]; then
        #shellcheck disable=SC2154
        printf '..s%..' "${On_Red}Please do not run this script as root (no su or sudo)! ${NC}"
        exit 1
    fi
}
MAKE_SURE_NOT_ROOT() {
    if [ "$(id -u)" -ne 0 ]; then
        printf '..s%..' "You must be root user to continue"
        exit 1
    fi
    RID=$(id -u root 2>/dev/null)
    if [ "$#" -ne 0 ]; then
        printf '..s%..' "User root no found. You should create it to continue"
        exit 1
    fi
    if [ "$RID" -ne 0 ]; then
        printf '..s%..' "User root UID not equals 0. User root must have UID 0"
        exit 1
    fi
}
# ============================================================================= #
CMD() { command -v "$1" >/dev/null 2>&1; }
CMD_EXISTS() {
    if [ -z "$(command -v "$@" 2>/dev/null)" ] || [ -z "$(command -v "$@" 2>/dev/null)" ]; then
        return 1
    else
        return 0
    fi
}
EXEC() { type -fP "$1" >/dev/null 2>&1; }
### !REMINDER: NOT TESTED
###
FUNC_EXISTS() {
    declare -f -F "$1" >/dev/null
}

MAKE_DIR() { [[ ! -d "$1" ]] && mkdir -p "$1"; }
EXEC_SUDO() { [[ "$(whoami)" != "root" ]] && exec sudo -- "$0" "$@"; }

BASHRC_RELOAD() { cd ${HOME} && source .bashrc && cd - >/dev/null 2>&1; }
ZSHRC_RELOAD() { cd ${HOME} && source .zshrc && cd - >/dev/null 2>&1; }

DMY_HMS() { date "+%d-%m-%Y+%H-%M-%S"; }

GETHELP() {
    #TODO: Implement
    local DESCRIPTION="Usage support"
    local OPTIONS='show options'
    if [ -n "$*" ]; then
        echo "$*" >&2
        echo >&2
    fi
    cat >&2 <<EOF
# ============================================================================= #
$DESCRIPTION
# ============================================================================= #
usage: ${0##*/} $OPTIONS
# ============================================================================= #
-h --help                                               Print usage help and exit
EOF
    exit 0
}

GIT_STRAP() {
    local repo="$1"
    local dest="$2"
    local name=''
    name=$(basename "$repo")
    if [ ! -d "$dest/.git" ]; then
        log_info "Installing $name..."
        #    mkdir -p "$dest"
        git clone --depth 1 "$repo" "$dest"
    else
        NOTIFY "Pulling $name..."
        (
            builtin cd "$dest" && git pull --depth 1 --rebase origin "$(git symbolic-ref refs/remotes/origin/HEAD | awk -F'[/]' '{print $NF}')" ||
                MSGINFO "Exec in compatibility mode [git pull --rebase]" &&
                builtin cd "$dest" && git fetch --unshallow && git rebase origin/"$(git symbolic-ref refs/remotes/origin/HEAD | awk -F'[/]' '{print $NF}')"
        )
    fi
}
SYMLINK() {
    local src="$1" dst="$2"
    local overwrite='' backup='' skip=''
    local action=''
    #shellcheck disable=SC2166
    if [ -f "$dst" -o -d "$dst" -o -L "$dst" ]; then
        if [ "$overwrite_all" == "false" ] && [ "$backup_all" == "false" ] && [ "$skip_all" == "false" ]; then
            currentSrc="$(readlink "$dst")"
            if [ "$currentSrc" == "$src" ]; then
                skip=true
            else
                CUTLINE
                BOLDBLUE "File $dst ($(basename "$src")) already exists, what do you want to do?"
                CWHITE "[s]kip, [S]kip all, [o]verwrite, [O]verwrite all, [b]ackup, [B]ackup all?"
                echo && CUTLINE && echo
                read -n 1 action
                case "$action" in
                o)
                    overwrite=true
                    ;;
                O)
                    overwrite_all=true
                    ;;
                b)
                    backup=true
                    ;;
                B)
                    backup_all=true
                    ;;
                s)
                    skip=true
                    ;;
                S)
                    skip_all=true
                    ;;
                *) ;;
                esac
            fi
        fi
        overwrite=${overwrite:-$overwrite_all}
        backup=${backup:-$backup_all}
        skip=${skip:-$skip_all}
        if [ "$overwrite" == "true" ]; then
            CUTLINE
            rm -rf "$dst" && MSGINFO "Removed $dst"
        fi
        if [ "$backup" == "true" ]; then
            CUTLINE
            mv "$dst" "${dst}.backup" && MSGINFO "Backup made - ${dst}.backup"

        fi
        if [ "$skip" == "true" ]; then
            CUTLINE
            MSGINFO "Skipped $src"
        fi
    fi
    if [ "$skip" != "true" ]; then
        CUTLINE
        ln -fs "$1" "$2" && MSGOK "Linked $1 to $2"
    fi
}

# ============================================================================= #
#  ➜ ➜ ➜
# ============================================================================= #
