
0="${${ZERO:-${0:#$ZSH_ARGZERO}}:-${(%):-%N}}"
0="${${(M)0:#/*}:-$PWD/$0}"

_zsh_autosuggest_strategy_dir_history(){ # Avoid Zinit picking this up as a completion
    emulate -L zsh
    if $_per_directory_history_is_global && [[ -r "$_per_directory_history_path" ]]; then
        setopt EXTENDED_GLOB
        local prefix="${1//(#m)[\\*?[\]<>()|^~#]/\\$MATCH}"
        local pattern="$prefix*"
        if [[ -n $ZSH_AUTOSUGGEST_HISTORY_IGNORE ]]; then
        pattern="($pattern)~($ZSH_AUTOSUGGEST_HISTORY_IGNORE)"
        fi
        [[ "${dir_history[(r)$pattern]}" != "$prefix" ]] && \
        typeset -g suggestion="${dir_history[(r)$pattern]}"
    fi
}

_zsh_autosuggest_strategy_custom_history () {
        emulate -L zsh
        setopt EXTENDED_GLOB
        local prefix="${1//(#m)[\\*?[\]<>()|^~#]/\\$MATCH}"
        local pattern="$prefix*"
        if [[ -n $ZSH_AUTOSUGGEST_HISTORY_IGNORE ]]
        then
                pattern="($pattern)~($ZSH_AUTOSUGGEST_HISTORY_IGNORE)"
        fi
        [[ "${history[(r)$pattern]}" != "$prefix" ]] && \
        typeset -g suggestion="${history[(r)$pattern]}"
}
ZSHZ_DATA="${ZPFX}/z"
AUTOENV_AUTH_FILE="${ZPFX}/autoenv_auth"
ZSH_AUTOSUGGEST_USE_ASYNC=true
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
ZSH_AUTOSUGGEST_HISTORY_IGNORE="?(#c100,)" # Do not consider 100 character entries
ZSH_AUTOSUGGEST_COMPLETION_IGNORE="[[:space:]]*"   # Ignore leading whitespace
ZSH_AUTOSUGGEST_MANUAL_REBIND=set
ZSH_AUTOSUGGEST_STRATEGY=(dir_history custom_history completion)
HISTORY_SUBSTRING_SEARCH_FUZZY=set
AUTOPAIR_CTRL_BKSPC_WIDGET=".backward-kill-word"
FZF_DEFAULT_COMMAND="fd --type f --hidden --follow --exclude .git 2>/dev/null"
FZ_HISTORY_CD_CMD=zshz
ZSHZ_CMD=" " # Do not set the alias, fz will cover that
ZSHZ_UNCOMMON=1
forgit_ignore="/dev/null" #replaced gi with local git-ignore plugin

# Strings to ignore when using dotscheck, escape stuff that could be wild cards (../)
dotsvar=( gtkrc-2.0 kwinrulesrc '\.\./' \.config/gtk-3\.0/settings\.ini )

# Export variables when connected via SSH
if [[ -n $SSH_CONNECTION ]]; then
    export DISPLAY=:0
    alias ls="lsd --group-dirs=first --icon=never"
else
    alias ls='lsd --group-dirs=first'
fi
# Set variables if on ac mode
if [[ $(cat /run/tlp/last_pwr) = 0 ]]; then
    alias micro="micro -fastdirty false"
fi
# dot file management
alias dots='DOTBARE_DIR="$HOME/.dots" DOTBARE_TREE="$HOME" DOTBARE_BACKUP="${ZPFX:-${XDG_DATA_HOME:-$HOME/.local/share}}/dotbare" dotbare'
export DOTBARE_FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS"
export DOTBARE_DIFF_PAGER=delta
