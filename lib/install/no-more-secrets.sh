To install this project from source, you will need to have the tools git, gcc, and make to download and build it. Install them from your package manager if they are not already installed.

Install:
$ git clone https://github.com/bartobri/no-more-secrets.git
$ cd ./no-more-secrets
$ make nms
$ make sneakers             ## Optional
$ sudo make install
Uninstall:
$ sudo make uninstall
Install with Ncurses Support
If your terminal does not support ANSI/VT100 escape sequences, the effect may not render properly. This project provides a ncurses implementation for such cases. You will need the ncurses library installed. Install this library from your package manager. Next, follow these instructions:

$ git clone https://github.com/bartobri/no-more-secrets.git
$ cd ./no-more-secrets
$ make nms-ncurses
$ make sneakers-ncurses     ## Optional
$ sudo make install