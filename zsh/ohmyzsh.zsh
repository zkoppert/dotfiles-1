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
ZSH_CUSTOM="$HOME/.zsh/custom_plugins"

alias ohmyzsh_load="source $ZSH/oh-my-zsh.sh"
