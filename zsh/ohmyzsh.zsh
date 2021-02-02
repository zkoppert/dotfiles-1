# ============================================================================= #
#  ➜ ➜ ➜ OH-MY-ZSH
# ============================================================================= #
[ ! -d "$ZSH" ] && mkdir -p "$ZSH"
[ ! -f "$ZSH/oh-my-zsh.sh" ] && git clone https://github.com/ohmyzsh/ohmyzsh "$ZSH"
#ZSH_THEME="robbyrussell"
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )
# ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
# DISABLE_UNTRACKED_FILES_DIRTY="true"
HIST_STAMPS="mm/dd/yyyy"

plugins=(git history-substring-search
    npm yarn nvm
    python pyenv pip virtualenv virtualenvwrapper
    cargo ruby rust gem rvm bundler
    brew fasd golang
    command-not-found
    direnv dotenv
    doctl gcloud minikube systemd docker docker-compose
    ssh-agent gpg-agent
    colorize
    rsync vscode extract copydir sudo nmap taskwarrior zsh_reload)

source $ZSH/oh-my-zsh.sh
