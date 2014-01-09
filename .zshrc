# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

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
plugins=(git)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH=/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin
[[ -s /etc/profile.d/autojump.sh ]] && . /etc/profile.d/autojump.sh

# KJG's Customization
#Dev
alias grd='guard --no-interactions'
alias bg='bundle exec guard'

#Folder Nav
alias ..='cd ..'
alias ...='cd ../..'
alias sites='cd ~/Sites'
alias config='cd ~/Configuration-Files'
alias spf=' cd ~/.spf13-vim-3/'
alias home=$HOME

#Open Config Files
alias ssh-config='open -a Macvim ~/.ssh/config'
alias .zshrc='open -a Macvim ~/.zshrc'
alias .vimrc='open -a Macvim ~/.vimrc.local'
alias spf-vimrc='open -a Macvim ~/.spf13-vim-3/.vimrc'


#Git
alias fetch='git fetch'
alias log='git log --oneline --abbrev-commit --all --graph --decorate --color'
alias gc='git commit -m'
alias push='git push origin'
alias pull='git pull origin'
alias status='git status'
alias co='git checkout'

#Vim
alias vim='open -a Macvim'

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
export PATH=/Applications/MAMP/bin/php/php5.4.4/bin:$PATH #MAMP PHI setting for Composer
export PATH=/usr/local/share/npm/bin:$PATH #Setting to use Grunt

# MySQL
alias mysql="/Applications/MAMP/Library/bin/mysql"
alias mysqldump="/Applications/MAMP/Library/bin/mysqldump"
