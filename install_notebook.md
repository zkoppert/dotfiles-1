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
  sudo nb completions install --download

# install using curl
sudo curl -L https://raw.github.com/xwmx/nb/master/nb -o /usr/local/bin/nb &&
  sudo chmod +x /usr/local/bin/nb &&
  sudo nb completions install --download
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
Tab Completion
Bash and Zsh tab completion should be enabled when nb is installed using the methods above, assuming you have the appropriate system permissions or installed with sudo. If completion isn't working after installing nb, see the completion installation instructions.

Updating
When nb is installed using a package manager like npm or Homebrew, use the package manager's upgrade functionality to update nb to the latest version. When installed via other methods, nb can be updated to the latest version using the nb update subcommand.