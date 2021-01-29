# ============================================================================= #
#  ➜ ➜ ➜ ZPLUG
# ============================================================================= #
#[ ! -d "$ZPLUG_HOME" ] && mkdir -p "$ZPLUG_HOME"
#[ ! -f "$ZPLUG_HOME/init.zsh" ] && git clone https://github.com/zplug/zplug "$ZPLUG_HOME"
#source "$MINIPLUG_HOME/zplug/zplug/init.zsh"
# ============================================================================= #
#zplug 'zplug/zplug', hook-build:'zplug --self-manage'
#zplug "lib/*", from:oh-my-zsh
#zplug "plugins/history-substring-search", from:oh-my-zsh
#zplug "plugins/git", from:oh-my-zsh
#zplug "plugins/npm", from:oh-my-zsh
#zplug "plugins/yarn", from:oh-my-zsh
#zplug "plugins/nvm", from:oh-my-zsh
#zplug "plugins/python", from:oh-my-zsh
#zplug "plugins/pyenv", from:oh-my-zsh
#zplug "plugins/pip", from:oh-my-zsh
#zplug "plugins/rvm", from:oh-my-zsh
#zplug "plugins/rsync", from:oh-my-zsh
#zplug "plugins/vscode", from:oh-my-zsh
#zplug "plugins/golang", from:oh-my-zsh
#zplug "plugins/virtualenv", from:oh-my-zsh
#zplug "plugins/virtualenvwrapper", from:oh-my-zsh
#zplug "plugins/copydir", from:oh-my-zsh
#zplug "plugins/copyfile", from:oh-my-zsh
#zplug "plugins/systemd", from:oh-my-zsh
#zplug "plugins/docker", from:oh-my-zsh
#zplug "plugins/docker-machine", from:oh-my-zsh
#zplug "plugins/docker-compose", from:oh-my-zsh
#zplug "plugins/colorize", from:oh-my-zsh
#zplug "plugins/comand-not-fount", from:oh-my-zsh
#zplug "plugins/taskwarrior", from:oh-my-zsh
#zplug "plugins/sudo", from:oh-my-zsh
#zplug "plugins/extract", from:oh-my-zsh
#zplug "plugins/completion", from:oh-my-zsh
#zplug "plugins/ssh-agent", from:oh-my-zsh
#zplug "plugins/gpg-agent", from:oh-my-zsh
# ============================================================================= #
#  ➜ ➜ ➜ GIST
# ============================================================================= #
#zplug "ss-o/f78cf2f331ed83d158c1a70d613da1fa", \
#    from:gist, \
#    as:command, \
#    use:progbar

# ============================================================================= #
#  ➜ ➜ ➜ ZPLUG/LOAD
# ============================================================================= #
#if ! zplug check --verbose; then
#    zplug install
#fi
#zplug load
