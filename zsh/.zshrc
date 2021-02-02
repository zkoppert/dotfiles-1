if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
# ============================================================================= #
#  ➜ ➜ ➜ ZSH
# ============================================================================= #
# [TEMPORARY]
alias mce="micro"
export PATH="$PATH:$HOME/.gem/ruby/2.7.0/bin"

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
#  ➜ ➜ ➜ MINIPLUG
# ============================================================================= #
miniplug plugin 'wuotr/zsh-plugin-vscode'
miniplug plugin 'zsh-users/zsh-autosuggestions'
miniplug plugin 'desyncr/auto-ls'
miniplug plugin 'lukechilds/zsh-nvm'
miniplug plugin 'mattberther/zsh-pyenv'
miniplug plugin 'MichaelAquilina/zsh-you-should-use'
miniplug plugin 'unixorn/git-extra-commands'
miniplug plugin 'zdharma/fast-syntax-highlighting'
miniplug plugin 'zsh-users/zsh-completions'
miniplug plugin 'lukechilds/zsh-better-npm-completion'
# ============================================================================= #
#  ➜ ➜ ➜ THEMES
# ============================================================================= #
miniplug theme 'romkatv/powerlevel10k' depth:1
# ============================================================================= #
miniplug load 
# ============================================================================= #
#       >> Homebrew
[[ -d "/home/linuxbrew" ]] && eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
