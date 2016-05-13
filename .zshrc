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

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(osx git bower jira npm terminalapp jsontools zsh-syntax-highlighting 
git-extras)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH=/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin
[[ -s /etc/profile.d/autojump.sh ]] && . /etc/profile.d/autojump.sh
[[ -s `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh

# set vim as editor
export VISUAL=vim
export EDITOR="$VISUAL"


#####################
# KJG's Customization
#####################

# restart the shell
alias restart='exec -l $SHELL'

#Vim
alias vim='open -a Macvim'

# Build tools
alias big:gulp='(cd $(dirname $(find . -maxdepth 2 -name gulpfile.js)) && gulp)'
alias bower:install='(cd $(dirname $(find . -maxdepth 2 -name bower.json)) && bower install)'
alias bower:update='(cd $(dirname $(find . -maxdepth 2 -name bower.json)) && bower update)'

# ExpressionEngine
alias eecli='vendor/bin/eecli'
alias sync:db='remotee-sync --env=production -d'
alias save:db='remotee-sync --env=production -s --file=$(basename `git rev-parse --show-toplevel`)_$(date +%m-%d).sql --sync=no -d'

# Docker, paths in path.zsh
alias es-local='sites && cd es-docker && boot2docker up && docker start es'
alias es-local:stop='sites && cd es-docker && docker stop es && boot2docker stop'

# MySQL
alias mysql="/Applications/MAMP/Library/bin/mysql"
alias mysqldump="/Applications/MAMP/Library/bin/mysqldump"

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
source ~/Configuration-Files/zshes/functions.zsh

# Sauce labs shortuct, this depends on tab which is in functions.zsh
alias sauce='tab "sites && cd sauce-labs && bin/sc -u vectormediagroup -k 355ea7db-9fe4-4bde-b729-878d75e3816c"'

