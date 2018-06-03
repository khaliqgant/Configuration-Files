# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Get ride of annoying prompt to upgrade, just do it!
DISABLE_UPDATE_PROMPT=true

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how many often would you like to wait before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

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

# load in path exports
source ~/Configuration-Files/zshes/path.zsh

# load other functions
source ~/Configuration-Files/zshes/functions/main.zsh

# load in histdb
source ~/Configuration-Files/zshes/histdb.zsh

# load in any custom private scripts
source ~/Dropbox/KJG/Development/scripts.zsh

# Sauce labs shortuct, this depends on tab which is in functions.zsh
alias sauce='tab "sites && cd sauce-labs && bin/sc -u vectormediagroup -k 355ea7db-9fe4-4bde-b729-878d75e3816c"'

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
