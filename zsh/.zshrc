if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
# ============================================================================= #
#  ➜ ➜ ➜ ZSH
# ============================================================================= #
# [TEMPORARY]
alias mce="micro"

for env in $HOME/.dotfiles/**/*.env; do
    if [ -r $env ]; then
        source $env
    fi
done
for load in $HOME/.dotfiles/zsh/*.zsh; do
    if [ -r $load ]; then
        source $load
    fi
done
unset load env
# ============================================================================= #
#  ➜ ➜ ➜ OH-MY-ZSH PLUGINS
# ============================================================================= #
plugins=(git history-substring-search command-not-found
    npm yarn python golang pip virtualenv virtualenvwrapper
    cargo ruby rust gem bundler
    brew
    direnv dotenv
    doctl gcloud minikube systemd docker docker-compose
    nmap ssh-agent gpg-agent sudo
    colorize rsync vscode extract copydir taskwarrior zsh_reload)

ohmyzsh_load
# ============================================================================= #
#  ➜ ➜ ➜ MINIPLUG PLUGINS
# ============================================================================= #
[ ! -d "$MINIPLUG_HOME" ] && mkdir -p "$MINIPLUG_HOME"

miniplug plugin 'wuotr/zsh-plugin-vscode'
miniplug plugin 'zsh-users/zsh-autosuggestions'
miniplug plugin 'desyncr/auto-ls'
miniplug plugin 'lukechilds/zsh-nvm'
miniplug plugin 'mattberther/zsh-pyenv'
miniplug plugin 'Tarrasch/zsh-autoenv'
miniplug plugin 'MichaelAquilina/zsh-you-should-use'
miniplug plugin 'unixorn/git-extra-commands'
miniplug plugin 'zdharma/fast-syntax-highlighting'
miniplug plugin 'zsh-users/zsh-completions'
miniplug plugin 'lukechilds/zsh-better-npm-completion'
# ============================================================================= #
#  ➜ ➜ ➜ THEME
# ============================================================================= #
miniplug theme 'romkatv/powerlevel10k' depth:1
# ============================================================================= #
miniplug load 
# ============================================================================= #
[[ ! -f ~/.dotfiles/zsh/.p10k ]] || source ~/.dotfiles/zsh/.p10k