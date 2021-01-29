# ============================================================================= #
#  ➜ ➜ ➜ OH-MY-ZSH
# ============================================================================= #
[ ! -f "$OHMYZSH/oh-my-zsh.sh" ] && git clone https://github.com/ohmyzsh/ohmyzsh "$OHMYZSH"
# ZSH_THEME="robbyrussell"
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
# DISABLE_UNTRACKED_FILES_DIRTY="true"
HIST_STAMPS="mm/dd/yyyy"
plugins=(git history-substring-search npm yarn nvm python pyenv
    pip rvm rsync vscode golang virtualenv virtualenvwrapper copydir
    systemd docker docker-compose ssh-agent gpg-agent sudo
    extract taskwarrior command-not-found colorize gem)
source $OHMYZSH/oh-my-zsh.sh
