#!/usr/bin/env bash
# ============================================================================= #
# Install if dependencies specified
#shellcheck disable=SC2034
DEB_DEPENDS=(figlet chroma)
#REDHAT_DEPENDS=""
ARCH_DEPENDS=(figlet chromaprint)
# ============================================================================= #
# ➜ ➜ ➜ IMPORT
# ============================================================================= #
current_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# Load files
#shellcheck disable=SC1073,SC1090
. "$current_dir/utilities.sh"
#shellcheck disable=SC1073,SC1090
#. "$current_dir/installer.sh"
CONT() {
    echo "Proceed? [y/N]"
    read -r response
    case $response in
    y/Y) return 0 ;;
    *) exit 0 ;;
    esac
}
### !Define to install if missing
#INSTALL_DEPENDS
SET_BOO
### ?TRAP_CTRL
# ============================================================================= #
# ➜ ➜ ➜ LOCAL
# ============================================================================= #
userExpect='Salvydas'
upSeconds="$(/usr/bin/cut -d. -f1 /proc/uptime)"
secs="$((upSeconds % 60))"
mins="$((upSeconds / 60 % 60))"
hours=$((upSeconds / 3600 % 24))
days=$((upSeconds / 86400))
UPTIME=$(printf "%d days, %02dh%02dm%02ds" "$days" "$hours" "$mins" "$secs")
# get the load averages
read -r one five fifteen rest </proc/loadavg

GET_INFO() {
    if [ ! -d "$ABSOLUTE_PATH/.info" ]; then
        git clone https://github.com/ss-o/info.git "$ABSOLUTE_PATH/.info"
    else
        MSGOK "Info repository exists, do you wish to remove?"
        if CONTINUE; then
            sudo rm -r "$ABSOLUTE_PATH/.info"
        fi
    fi
}

GET_KEYS() {
    if [ ! -d "$ABSOLUTE_PATH/.keys" ]; then
        git clone https://github.com/ss-o/keys.git "$ABSOLUTE_PATH/.keys"
    else
        MSGOK "Private repository exists, do you wish to remove?"
        if CONTINUE; then
            sudo rm -r "$ABSOLUTE_PATH/.keys"
        fi
    fi
}

GET_PRIVATE() {
    if [ ! -d "$ABSOLUTE_PATH/.private" ]; then
        git clone https://github.com/ss-o/private.git "$ABSOLUTE_PATH/.private"
    else
        MSGOK "Private repository exists, do you wish to remove?"
        if CONTINUE; then
            sudo rm -r "$ABSOLUTE_PATH/.private"
        fi
    fi
}

DO_REPOS() {
    MSGOK "Wish to manage repositories?"
    if CONTINUE ''; then
        GET_INFO
        GET_KEYS
        GET_PRIVATE
        MSGOK "Repositories done"
    fi
}

DO_COVER() {
    echo -e "$(tput bold)$(tput setaf 1)"
    figlet "Anonymous"
    echo -e "$(tput sgr0)➜ ➜ ➜"
    if CONTINUE; then
        return
    else
        exit 0
    fi
}

DO_TASKS() {
    clear
    TITLE "Welcome, $userExpect"
    MSGOK "Path: $ABSOLUTE_PATH"
    MSGOK "Initiating"
    DO_REPOS "$@"
    if [[ -f "$ABSOLUTE_PATH/.info/time_to_shine.sh" ]]; then
        MSGINFO "Time file found, initiate?"
        if CONTINUE; then
            clear
            #shellcheck disable=SC1090
            . "$ABSOLUTE_PATH/.info/time_to_shine.sh"
        fi
    fi
    if [[ -f "$ABSOLUTE_PATH/.info/msg.txt" ]]; then
        MSGINFO "Identified, view status?"
        if CONTINUE; then
            clear
            #BAR
            echo -e "$(tput bold)$(tput setaf 4)"
            cat "$ABSOLUTE_PATH/.info/msg.txt"
            sleep 2
        fi
    fi
    MSGOK "Finished"
}

DO_MOTTO() {
    echo "$(tput bold)$(tput setaf 1) - Who Speak Out Against..."
    sleep 2
    echo "$(tput sgr0)          Will Be silenced."
    sleep 2
    echo "$(tput bold)$(tput setaf 1) - Those Who Lie..."
    sleep 2
    echo "$(tput sgr0)          Will Vanish."
    echo "$(tput bold)$(tput setaf 2)"
    sleep 2
    echo "$(tput bold)$(tput setaf 2)          We are anonymous"
    sleep 1
    echo "$(tput setaf 2)          We are legion"
    sleep 1
    echo "$(tput setaf 2)          We do not forgive"
    sleep 1
    echo "$(tput setaf 2)          We do not forget"
    sleep 1
    echo "$(tput sgr0)          EXPECT US"
}
DO_SYS_INFO() {
    if CMD_EXISTS neofetch; then
        neofetch --disable title cols resolution term DE WM theme icons --crop_mode fit
    else
        #    $(tput sgr0)- IP Addresses.......: $(hostname | /usr/bin/cut -d " " -f 1) and $(wget -q -O - http://icanhazip.com/ | tail)
        echo "$(tput setaf 2)
$(date +"%A, %e %B %Y, %r")
$(uname -srmo)
$(tput sgr0)- Uptime.............: ${UPTIME}
$(tput sgr0)- Memory.............: $(free | grep Mem | awk '{print $3/1024}') MB (Used) / $(cat /proc/meminfo | grep MemTotal | awk {'print $2/1024'}) MB (Total)
$(tput sgr0)- Load Averages......: ${one}, ${five}, ${fifteen} (1, 5, 15 min)
$(tput sgr0)- Running Processes..: $(ps ax | wc -l | tr -d " ")
$(tput sgr0)"
    fi
}

MAIN() {
    DO_COVER "$@"
    sleep 3
    clear
    DO_TASKS "$@"
    sleep 5
    clear
    DO_MOTTO "$@"
    sleep 5
    clear
    DO_SYS_INFO "$@"
    exit 0
}

while true; do
    MAIN "$@"
done
