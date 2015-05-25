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
alias ....='cd ../../..'
alias sites='cd ~/Sites'
alias config='cd ~/Configuration-Files'
alias Sites='cd ~/Sites'
alias Config='cd ~/Configuration-Files'
alias spf=' cd ~/.spf13-vim-3/'
alias home=$HOME

# quickly find files and directory
alias ff='find . -type f -name'
alias fd='find . -type d -name'

# copy the current working directory to the clipboard
alias cpwd='pwd | xclip -selection clipboard'

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
alias bower:install='(cd $(dirname $(find . -maxdepth 2 -name bower.json)) && bower install)'
alias bower:update='(cd $(dirname $(find . -maxdepth 2 -name bower.json)) && bower update)'

#ExpressionEngine
alias eecli='vendor/bin/eecli'
alias sync:db='remotee-sync --env=production -d'

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
alias stash:list='git stash list --date=local'
alias pop='git stash pop'
alias new='git checkout -b'
alias reset='git reset --hard origin/master'
alias root='cd "`git rev-parse --show-toplevel`"'

#Vim
alias vim='open -a Macvim'

# Docker
alias es-local='sites && cd es-docker && boot2docker up && docker start es'
alias es-local:stop='sites && cd es-docker && docker stop es && boot2docker stop'
export DOCKER_HOST=tcp://192.168.59.103:2376
export DOCKER_CERT_PATH=/Users/khaliq/.boot2docker/certs/boot2docker-vm
export DOCKER_TLS_VERIFY=1

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
export PATH=/Applications/MAMP/bin/php/php5.4.4/bin:$PATH #MAMP PHI setting for Composer
export PATH=/usr/local/share/npm/bin:$PATH #Setting to use Grunt
export PATH=~/npm/bin:$PATH #Because installed node w/o homebrew add the npm path from the local usr
export PATH=~/.node/bin:$PATH #add path for npm install modules
export PATH=/usr/texbin:$PATH #Add latex to path
export PATH=/usr/local/share/python:$PATH #add python path


# MySQL
alias mysql="/Applications/MAMP/Library/bin/mysql"
alias mysqldump="/Applications/MAMP/Library/bin/mysqldump"

# Java
# shortcut for compiling and running Java programs
function ja {
    filename="${1%.*}"
    javac $filename.java
    if [[ $? == 0 ]]; then
       java $filename
    fi
}

# Latex
# shortcut to compile and open a pdf created from latex
function pdf {
    filename="${1%.*}"
    pdflatex $filename.latex
    if [[ $? == 0 ]]; then
       open $filename.pdf
    fi
}

# open up a new tab
# source: https://gist.github.com/bobthecow/757788
function tab () {
    local cmd=""
    local cdto="$PWD"
    local args="$@"
 
    if [ -d "$1" ]; then
        cdto=`cd "$1"; pwd`
        args="${@:2}"
    fi
 
    if [ -n "$args" ]; then
        cmd="; $args"
    fi
 
    osascript &>/dev/null <<EOF
        tell application "iTerm"
            tell current terminal
                launch session "Default Session"
                tell the last session
                    write text "cd \"$cdto\"$cmd"
                end tell
            end tell
        end tell
EOF
}

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
