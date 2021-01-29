#!/usr/bin/env bash
# ============================================================================= #
#  ➜ ➜ ➜ GET OS INFO
# ============================================================================= #
current_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
#shellcheck disable=SC1073,SC1090
. "$current_dir/utilities.sh"
# ============================================================================= #
#if [ "$(id -u)" != "0" ]; then
#    echo "This script must be run as root" 1>&2
#    exit 1
#fi
DISTRO=''
# ============================================================================= #

# ============================================================================= #
INSTALL_DEPENDS() {
    if command -v apt-get >/dev/null 2>&1; then
        MSGOK "Installing Debian packages..."
        for i in "${DEB_DEPENDS[@]}"; do
            if dpkg -s "$i" &>/dev/null; then
                MSGOK "Installing: $i"
                sudo apt-get install -y "$i"
            fi
        done
    # ============================================================================= #
    # ============================================================================= #
    elif command -v yum >/dev/null 2>&1; then
        MSGOK "Installing RedHat packages..."
        for i in "${REDHAT_DEPENDS[@]}"; do
            MSGOK "Installing: $i"
            sudo yum install "$i"
        done
    # ============================================================================= #
    # ============================================================================= #
    elif command -v pacman >/dev/null 2>&1; then
        for i in "${ARCH_DEPENDS[@]}"; do
            if pacman -Qi "$i" &>/dev/null; then
                MSGOK "Installing: $i"
                sudo pacman -S "$i" --noconfirm --needed
            fi
        done
    fi
}
# ============================================================================= #
GET_DISTRO() {
    #    DEB_DEPENDS="lsb-release"
    #    REDHAT_DEPENDS="redhat-lsb-core"
    #    ARCH_DEPENDS="lsb-release"
    INSTALL_DEPENDS
    if grep 'Debian' /etc/issue >/dev/null 2>&1; then
        DISTRO=debian
    else
        if [ -f "/etc/debian_version" ]; then
            DISTRO=debian
        fi
    fi

    if grep 'Ubuntu' /etc/issue >/dev/null 2>&1; then
        DISTRO=ubuntu
    fi

    if grep 'ubuntu' /etc/os-release >/dev/null 2>&1; then
        DISTRO=ubuntu
    fi

    if grep 'CentOS' /etc/issue >/dev/null 2>&1; then
        DISTRO=centos
    fi

    if grep 'CentOS' /etc/os-release >/dev/null 2>&1; then
        DISTRO=centos
    fi

    if grep 'Red' /etc/issue >/dev/null 2>&1; then
        DISTRO=redhat
    else
        if [ -f "/etc/redhat-release" ]; then
            DISTRO=redhat
        fi
    fi
    if [ -f "/etc/fedora-release" ]; then
        DISTRO=fedora
    elif [ -f "/etc/arch-release" ]; then
        DISTRO=arch
    elif [ -f "/etc/alpine-release" ]; then
        DISTRO=alpine
    elif [ -f "/etc/os-release" ]; then
        DISTRO=$(awk -F= '$1=="ID" { print $2 ;}' /etc/os-release)
    else
        DISTRO=unknown
    fi
}
# ============================================================================= #
LINUX_OS_VERSION() {
    GET_DISTRO
    ARCH_VER=$(uname -m)
    KERNEL_VER=$(uname -r)
}
# ============================================================================= #

# ============================================================================= #
# ============================================================================= #
GET_ARCH_VER() {
    do_arch="$(uname -m)"
    case "$do_arch" in
    *)
        echo "Unknown"
        "$1"
        ;;
    armv5)
        echo "armv5"
        "$1"
        ;;
    armv7h)
        echo "armv7h"
        "$1"
        ;;
    aarch64)
        echo "aarch64"
        "$1"
        ;;
    armv6h)
        echo "armv6h"
        "$1"
        ;;
    i686)
        echo "i686"
        "$1"
        ;;
    x86_64)
        echo "x86_64"
        "$1"
        ;;
    esac
}
