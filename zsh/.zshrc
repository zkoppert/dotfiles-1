if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
# ============================================================================= #
#  ➜ ➜ ➜ ZSH
# ============================================================================= #
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
#miniplug theme "themes/robbyrussell", from:oh-my-zsh
#miniplug theme  "$HOME/$DOTFILES/zsh/themes", from:local, as:theme, use:ss-o.zsh-theme
#miniplug theme "denysdovhan/spaceship-prompt", use:spaceship.zsh, from:github, as:theme
miniplug theme 'romkatv/powerlevel10k' depth:1
# ============================================================================= #
# ============================================================================= #
miniplug load
# ============================================================================= #
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh