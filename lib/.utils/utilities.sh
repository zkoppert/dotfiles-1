#!/usr/bin/env bash
# ============================================================================= #
#  ➜ ➜ ➜ IMPORTS
# ============================================================================= #
#current_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

CONTINUE() {
    tput bold && tput setaf 1
    read -r -p "$1* [y/N]" response
    tput sgr0
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
SET_BOO() {
    set -eE
    trap 'printf "\e[31m%s: %s\e[m\n" "BOO!" $?' ERR
}
ERROR() {
    tput bold
    tput setaf 1
    echo "$@" >&2
    tput sgr0
    exit 1
}
SUCCESS() {
    tput bold
    tput setaf 2
    echo "Success!"
    tput sgr0
}
FINISHED() {
    tput bold
    tput setaf 8
    echo "$@"
    tput sgr0
    exit 0
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
NO_ROOT() {
    tput bold
    tput setaf 1
    if [[ $USER == "root" ]]; then
        ERROR "Do not run as root"
    fi
    tput sgr0
}
ONLY_ROOT() {
    if [[ $USER == "root" ]]; then
        echo "Not running as root"
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
EXEC() { type -fP "$1" >/dev/null 2>&1; }

MAKE_DIR() { [[ ! -d "$1" ]] && mkdir -p "$1"; }
EXEC_SUDO() { [[ "$(whoami)" != "root" ]] && exec sudo -- "$0" "$@"; }

BASHRC_RELOAD() { cd "${HOME}" && source .bashrc && cd - >/dev/null 2>&1; }
ZSHRC_RELOAD() { cd "${HOME}" && source .zshrc && cd - >/dev/null 2>&1; }

DMY_HMS() { date "+%d-%m-%Y+%H-%M-%S"; }

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
