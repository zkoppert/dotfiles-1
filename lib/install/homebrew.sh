Install
Instructions for a supported install of Homebrew on Linux are on the homepage.

The installation script installs Homebrew to /home/linuxbrew/.linuxbrew using sudo if possible and in your home directory at ~/.linuxbrew otherwise. Homebrew does not use sudo after installation. Using /home/linuxbrew/.linuxbrew allows the use of more binary packages (bottles) than installing in your personal home directory.

The prefix /home/linuxbrew/.linuxbrew was chosen so that users without admin access can ask an admin to create a linuxbrew role account and still benefit from precompiled binaries. If you do not yourself have admin privileges, consider asking your admin staff to create a linuxbrew role account for you with home directory /home/linuxbrew.

Follow the Next steps instructions to add Homebrew to your PATH and to your bash shell profile script, either ~/.profile on Debian/Ubuntu or ~/.bash_profile on CentOS/Fedora/Red Hat.

test -d ~/.linuxbrew && eval $(~/.linuxbrew/bin/brew shellenv)
test -d /home/linuxbrew/.linuxbrew && eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
test -r ~/.bash_profile && echo "eval \$($(brew --prefix)/bin/brew shellenv)" >>~/.bash_profile
echo "eval \$($(brew --prefix)/bin/brew shellenv)" >>~/.profile
You’re done! Try installing a package:

brew install hello
If you’re using an older distribution of Linux, installing your first package will also install a recent version of glibc and gcc. Use brew doctor to troubleshoot common issues.

Requirements
GCC 4.7.0 or newer
Linux 2.6.32 or newer
Glibc 2.13 or newer
64-bit x86_64 CPU
Paste at a terminal prompt:

Debian or Ubuntu
sudo apt-get install build-essential curl file git
Fedora, CentOS, or Red Hat
sudo yum groupinstall 'Development Tools'
sudo yum install curl file git
sudo yum install libxcrypt-compat # needed by Fedora 30 and up
ARM
Homebrew can run on 32-bit ARM (Raspberry Pi and others) and 64-bit ARM (AArch64), but no binary packages (bottles) are available. Support for ARM is on a best-effort basis. Pull requests are welcome to improve the experience on ARM platforms.

You may need to install your own Ruby using your system package manager, a PPA, or rbenv/ruby-build as we no longer distribute a Homebrew Portable Ruby for ARM.

32-bit x86
Homebrew does not currently support 32-bit x86 platforms. It would be possible for Homebrew to work on 32-bit x86 platforms with some effort. An interested and dedicated person could maintain a fork of Homebrew to develop support for 32-bit x86.

Alternative Installation
Extract or git clone Homebrew wherever you want. Use /home/linuxbrew/.linuxbrew if possible (to enable the use of binary packages).

git clone https://github.com/Homebrew/brew ~/.linuxbrew/Homebrew
mkdir ~/.linuxbrew/bin
ln -s ~/.linuxbrew/Homebrew/bin/brew ~/.linuxbrew/bin
eval $(~/.linuxbrew/bin/brew shellenv)

#/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
