# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

ZSH_THEME="robbyrussell"

# Get ride of annoying prompt to upgrade, just do it!
DISABLE_UPDATE_PROMPT=true

export NVM_AUTO_USE=true

plugins=($(<~/Configuration-Files/zshes/plugins.txt))

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
[[ -s /etc/profile.d/autojump.sh ]] && . /etc/profile.d/autojump.sh
[[ -s `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh

# set vim as editor
export VISUAL=vim
export EDITOR="$VISUAL"


#####################
# KJG's Customization
#####################

# Terminal Settings
bindkey -M viins 'jj' vi-cmd-mode
bindkey -v

# History
source ~/Configuration-Files/zshes/history.zsh

# Folder Nav
source ~/Configuration-Files/zshes/folder-nav.zsh

# Open Config Files
source ~/Configuration-Files/zshes/config.zsh

# Deploy
source ~/Configuration-Files/zshes/deploy.zsh

# load git aliases
source ~/Configuration-Files/zshes/git.zsh

# load docker shortcuts
source ~/Configuration-Files/zshes/docker.zsh

# load in path exports
source ~/Configuration-Files/zshes/path.zsh

# load other functions
source ~/Configuration-Files/zshes/functions/main.zsh

# load in histdb
source ~/Configuration-Files/zshes/histdb.zsh

# load in any custom private scripts
source ~/Dropbox/KJG/Development/scripts.zsh

# switch terraform versions on directory change
source ~/Configuration-Files/zshes/tfswitch.zsh

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
