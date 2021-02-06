Installation
Dependencies
Required
Bash
nb works perfectly with Zsh, fish, and any other shell set as your primary login shell, the system just needs to have Bash available on it.
Git
A text editor with command line support, such as:
Vim,
Emacs,
Visual Studio Code,
Sublime Text,
micro,
nano,
Atom,
TextMate,
MacDown,
some of these,
and many of these.
Optional
nb leverages standard command line tools and works in standard Linux / Unix environments. nb also checks the environment for some additional optional tools and uses them to enhance the experience whenever they are available.

Recommended:

bat
Pandoc
rg / ripgrep
tig
w3m
Also supported for various enhancements:

Ack, afplay, Ag - The Silver Searcher, exa, ffplay, ImageMagick, GnuPG, highlight, imgcat, kitty's icat kitten, Lynx, Midnight Commander, mpg123, MPlayer, note-link-janitor (via plugin), pdftotext, Pygments, Ranger, readability-cli, rga / ripgrep-all, termpdf.py, vifm

macOS / Homebrew
To install with Homebrew:

brew tap xwmx/taps
brew install nb
Installing nb with Homebrew also installs the recommended dependencies above and completion scripts for Bash and Zsh.

Ubuntu, Windows WSL, and others
npm
To install with npm:

npm install -g nb.sh
After npm installation completes, run sudo "$(which nb)" completions install to install Bash and Zsh completion scripts (recommended).

On Ubuntu and WSL, you can run sudo "$(which nb)" env install to install the optional dependencies.

nb is also available under its original package name, notes.sh, which comes with an extra notes executable wrapping nb.

Download and Install
To install as an administrator, copy and paste one of the following multi-line commands:

# install using wget
sudo wget https://raw.github.com/xwmx/nb/master/nb -O /usr/local/bin/nb &&
  sudo chmod +x /usr/local/bin/nb &&
  sudo nb completions install

# install using curl
sudo curl -L https://raw.github.com/xwmx/nb/master/nb -o /usr/local/bin/nb &&
  sudo chmod +x /usr/local/bin/nb &&
  sudo nb completions install
On Ubuntu and WSL, you can run sudo nb env install to install the optional dependencies.

User-only Installation
To install with just user permissions, simply add the nb script to your $PATH. If you already have a ~/bin directory, for example, you can use one of the following commands:

# download with wget
wget https://raw.github.com/xwmx/nb/master/nb -O ~/bin/nb && chmod +x ~/bin/nb

# download with curl
curl -L https://raw.github.com/xwmx/nb/master/nb -o ~/bin/nb && chmod +x ~/bin/nb
Installing with just user permissions doesn't include the optional dependencies or completions, but nb works without them. If you have sudo access and want to install the completion scripts and dependencies, run the following command:

sudo nb env install
Make
To install with Make, clone this repository, navigate to the clone's root directory, and run:

sudo make install
This will also install the completion scripts on all systems and the recommended dependencies on Ubuntu and WSL.

bpkg
To install with bpkg:

bpkg install xwmx/nb