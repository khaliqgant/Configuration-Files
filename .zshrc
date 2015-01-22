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
plugins=(osx git bower jira npm terminalapp web-search)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH=/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin
[[ -s /etc/profile.d/autojump.sh ]] && . /etc/profile.d/autojump.sh
[[ -s `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh

# item for eecli
export PATH=~/.composer/vendor/bin:$PATH

# KJG's Customization
#Dev
alias grd='guard --no-interactions'
alias bg='bundle exec guard'

#Folder Nav
alias ..='cd ..'
alias ...='cd ../..'
alias sites='cd ~/Sites'
alias config='cd ~/Configuration-Files'
alias Sites='cd ~/Sites'
alias Config='cd ~/Configuration-Files'
alias spf=' cd ~/.spf13-vim-3/'
alias home=$HOME

#Open Config Files
alias ssh-config='open -a Macvim ~/.ssh/config'
alias .zshrc='open -a Macvim ~/.zshrc'
alias .vimrc='open -a Macvim ~/.vimrc.local'
alias .bundles='open -a Macvim ~/.vimrc.bundles.local'
alias spf-vimrc='open -a Macvim ~/.spf13-vim-3/.vimrc'
alias vim-bundle='cd ~/.spf13-vim-3/.vim/bundle'

#Deploy
alias deploy:staging='(cd $(dirname $(find . -name Envoy.blade.php)) && envoy run deploy:staging)'
alias deploy:production='(cd $(dirname $(find . -name Envoy.blade.php)) && envoy run deploy:production)'
alias big:gulp='(cd $(dirname $(find . -maxdepth 2 -name gulpfile.js)) && gulp)'
alias gulp:watch='(cd $(dirname $(find . -maxdepth 2 -name gulpfile.js)) && gulp watch)'
alias bower:install='(cd $(dirname $(find . -maxdepth 2 -name bower.json)) && bower install)'
alias bower:update='(cd $(dirname $(find . -maxdepth 2 -name bower.json)) && bower update)'

#ExpressionEngine
alias eecli='vendor/bin/eecli'

#Go
export GOPATH=/Users/khaliq/Sites/go
export PATH=$PATH:$GOPATH/bin

#Git
alias fetch='git fetch'
alias log='git log --oneline --abbrev-commit --all --graph --decorate --color'
alias gc='git commit -m'
alias push='git push origin'
alias pull='git pull origin'
alias status='git status'
alias co='git checkout'
alias clean='git clean -f -d'
alias stash='git stash'
alias pop='git stash pop'
alias new='git checkout -b'
alias reset='git reset --hard origin/master'

#Vim
alias vim='open -a Macvim'

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
export PATH=/Applications/MAMP/bin/php/php5.4.4/bin:$PATH #MAMP PHI setting for Composer
export PATH=/usr/local/share/npm/bin:$PATH #Setting to use Grunt
export PATH=~/npm/bin:$PATH #Because installed node w/o homebrew add the npm path from the local usr
export PATH=~/.node/bin:$PATH #add path for npm install modules


# MySQL
alias mysql="/Applications/MAMP/Library/bin/mysql"
alias mysqldump="/Applications/MAMP/Library/bin/mysqldump"

# Terminal Settings
bindkey -M viins 'jj' vi-cmd-mode
bindkey -v

# Set autoresume
if [[ $TERM_PROGRAM == "Apple_Terminal" ]] && [[ -z "$INSIDE_EMACS" ]] {
  function chpwd {
    local SEARCH=' '
    local REPLACE='%20'
    local PWD_URL="file://$HOSTNAME${PWD//$SEARCH/$REPLACE}"
    printf '\e]7;%s\a' "$PWD_URL"
  }

  chpwd
}
