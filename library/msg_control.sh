#!/usr/bin/env bash

CHECK_COLOR_SUPPORT() {
    colors="$(tput colors)"
    if [ "$colors" -gt 1 ]; then
        COLORS_SUPPORTED=0
    else
        COLORS_SUPPORTED=1
    fi
}

MSG_INFO() {
    add_newline=''
    if [ "$2" == 0 ]; then
        add_newline='-n'
    fi

    if [ $COLORS_SUPPORTED -eq 0 ]; then
        echo -e ${add_newline} "[${Yellow}*${NC}] ${Green}$1${NC}"
    else
        echo -e ${add_newline} "[*] $1"
    fi
}

MSG_WARNING() {
    add_newline=''
    if [ "$2" == 0 ]; then
        add_newline='-n'
    fi

    if [ $COLORS_SUPPORTED -eq 0 ]; then
        echo -e ${add_newline} "[${Red}!${NC}] ${Yellow}$1${NC}"
    else
        echo -e ${add_newline} "[!] $1"
    fi
}

MSG_ERROR() {
    add_newline=''
    if [ "$2" == 0 ]; then
        add_newline='-n'
    fi

    if [ $COLORS_SUPPORTED -eq 0 ]; then
        echo -e ${add_newline} "[${Red}X${NC}] ${Yellow}$1${NC}"
    else
        echo -e ${add_newline} "[X] $1"
    fi
}

MSGOK() { echo -e "\e[0m[$(tput bold)$(tput setaf 2)✔\e[0m]::[$(tput setaf 2)$1\e[0m]"; }
MSGERROR() { echo -e "\e[0m[$(tput bold)$(tput setaf 1)x\e[0m]::[$(tput setaf 1)$1\e[0m]"; }
MSGINFO() { echo -e "\e[0m[$(tput bold)$(tput setaf 3)➜\e[0m]::[$(tput setaf 3)$1\e[0m]"; }

TITLE() {
    printf "\e[44m"
    printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' ' '
    printf '%-*s\n' "${COLUMNS:-$(tput cols)}" "  # $1" | tr ' ' ' '
    printf '%*s' "${COLUMNS:-$(tput cols)}" '' | tr ' ' ' '
    printf "\e[0m"
    printf "\n"
}
NOTIFY() {
    printf "\033[1;46m"
    printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' ' '
    printf '%-*s\n' "${COLUMNS:-$(tput cols)}" "  # $1" | tr ' ' ' '
    printf '%*s' "${COLUMNS:-$(tput cols)}" '' | tr ' ' ' '
    printf "\e[0m"
    printf "\n"
}

SUCCESS() {
    printf "\033[1;42m"
    printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' ' '
    printf '%-*s\n' "${COLUMNS:-$(tput cols)}" "  # $1" | tr ' ' ' '
    printf '%*s' "${COLUMNS:-$(tput cols)}" '' | tr ' ' ' '
    printf "\e[0m"
    printf "\n"
}

WARN() {
    printf "\e[41m"
    printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' ' '
    printf '%-*s\n' "${COLUMNS:-$(tput cols)}" "  # $1" | tr ' ' ' '
    printf '%*s' "${COLUMNS:-$(tput cols)}" '' | tr ' ' ' '
    printf "\e[0m"
    printf "\n"
}
CUTLINE() {
    printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -
    sleep .5
}
# shellcheck disable=SC2059,SC2068,SC2154
BOLDBLUE() { echo -e "${BBlue}$1${NC}"; }
# shellcheck disable=SC2059,SC2068,SC2154
CBLUE() { echo -e "${Blue}$1${NC}"; }
# shellcheck disable=SC2059,SC2068,SC2154
BOLDYELLOW() { echo -e "${BYellow}$1${NC}"; }
# shellcheck disable=SC2059,SC2068,SC2154
CYELLOW() { echo -e "${Yellow}$1${NC}"; }
# shellcheck disable=SC2059,SC2068,SC2154
BOLDCYAN() { echo -e "${BCyan}$1${NC}"; }
# shellcheck disable=SC2059,SC2068,SC2154
CCYAN() { echo -e "${Cyan}$1${NC}"; }
# shellcheck disable=SC2059,SC2068,SC2154
BOLDRED() { echo -e "${BBred}$1${NC}"; }
# shellcheck disable=SC2059,SC2068,SC2154
CRED() { echo -e "${Red}$1${NC}"; }
# shellcheck disable=SC2059,SC2068,SC2154
BOLDWHITE() { echo -e "${BWhite}$1${NC}"; }
# shellcheck disable=SC2059,SC2068,SC2154
CWHITE() { echo -e "${White}$1${NC}"; }
# shellcheck disable=SC2059,SC2068,SC2154
MSGOK() { echo -e "[${BGreen}✔${NC}]::[${Green}$1${NC}]"; }
# shellcheck disable=SC2154
MSGERROR() { echo -e "[${BRed}x${NC}]::[${Red}$1${NC}]"; }
MSGINFO() { echo -e "[${BYellow}!${NC}]::[${Yellow}$1${NC}]"; }

CBLINK() { echo -e "\033[5m$1\033[0m"; }
CCBLINK() { echo -e "\033[20;5m$1\033[0m"; }
ONBLINK() { echo -e "\033[20;5;7m$1\033[0m"; }
