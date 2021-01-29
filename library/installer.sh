#!/usr/bin/env bash
# ============================================================================= #
#  ➜ ➜ ➜ IMPORT
# ============================================================================= #
current_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
#shellcheck disable=SC1073,SC1090
. "$current_dir/os.sh"
# From os.sh
# - $DISTRO
# - $ARCH_VER
# - $KERNEL_VER
#LINUX_OS_VERSION
# ============================================================================= #
# Install if dependencies specified
# - DEB_DEPENDS="lsb-release"
# - REDHAT_DEPENDS="redhat-lsb-core"
# - ARCH_DEPENDS="lsb-release"
#INSTALL_DEPENDS
# ============================================================================= #
IF_APT_NEEDS() {
    if [ ! -d "/var/lib/apt/lists" ] || [ "$(ls /var/lib/apt/lists/ | wc -l)" = "0" ]; then
        echo "Running apt-get update..."
        sudo apt-get update -y
    else
        echo "Skipping apt-get update."
    fi
}

OS=$(cat /etc/issue | cut -f 1 -d ' ')
case $OS in
'Arch')
    ARCH_INSTALL() { sudo pacman -S --needed "$@"; }
    UPDATE() { sudo pacman -Sy; }
    ;;
'Ubuntu')
    UBUNTU_INSTALL() { sudo apt install "$@" -y --allow-unauthenticated; }
    UPDATE() { sudo apt update; }
    ;;
'Debian')
    DEBIAN_INSTALL() { sudo apt install "$@" -y --allow-unauthenticated; }
    UPDATE() { sudo apt update; }
    ;;
'Raspian')
    RASPIAN_INSTALL() { sudo apt install "$@" -y --allow-unauthenticated; }
    UPDATE() { sudo apt update; }
    ;;
'Armbian')
    ARMBIAN_INSTALL() { sudo apt install "$@" -y --allow-unauthenticated; }
    UPDATE() { sudo apt update; }
    ;;
*)
    echo 'Your distribution has not implementd yet, please modify this command'
    exit 1
    ;;
esac
# ============================================================================= #
#  ➜ ➜ ➜ INSTALLER
# ============================================================================= #
ADD_KEYSERVERS() {
    [ -d $HOME"/.gnupg" ] || mkdir -p $HOME"/.gnupg"
    echo "Adding keyservers to your personal .gpg for future applications"
    echo '
keyserver hkp://pool.sks-keyservers.net:80
keyserver hkps://hkps.pool.sks-keyservers.net:443
keyserver hkp://ipv4.pool.sks-keyservers.net:11371' | tee --append ~/.gnupg/gpg.conf
    chmod 600 ~/.gnupg/gpg.conf
    chmod 700 ~/.gnupg
}
ADD_KEYSERVERS_PACMAN() {
    echo "Adding keyservers to the /etc/pacman.d/gnupg folder for the use with pacman"
    echo '
keyserver hkp://pool.sks-keyservers.net:80
keyserver hkps://hkps.pool.sks-keyservers.net:443
keyserver hkp://ipv4.pool.sks-keyservers.net:11371' | sudo tee --append /etc/pacman.d/gnupg/gpg.conf
}
