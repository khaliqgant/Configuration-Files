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

# item for eecli
export PATH=~/.composer/vendor/bin:$PATH

# KJG's Customization
#Dev
alias grd='guard --no-interactions'
alias bg='bundle exec guard'

#Folder Nav
alias back='cd -'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias sites='cd ~/Sites'
alias config='cd ~/Configuration-Files'
alias Sites='cd ~/Sites'
alias Config='cd ~/Configuration-Files'
alias spf=' cd ~/.spf13-vim-3/'
alias home=$HOME
alias tree="find . -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'"

# quickly find files and directory
alias ff='find . -type f -name'
alias fd='find . -type d -name'

# copy the current working directory to the clipboard
alias cpwd='pwd | xclip -selection clipboard'

# restart the shell
alias restart='exec -l $SHELL'

#Open Config Files
alias ssh-config='open -a Macvim ~/.ssh/config'
alias show:ssh-config='cat ~/.ssh/config'
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
# reference : http://git-scm.com/docs/git-clean
alias clean='git clean -f -d'
alias stash='git stash'
alias stash:list='git stash list --date=local'
alias pop='git stash pop'
alias new='git checkout -b'
alias reset='git reset --hard origin/master'
# take you to the top of the git repo
alias root='cd "`git rev-parse --show-toplevel`"'
# zsh got rid of these commands with this PR https://github.com/robbyrussell/oh-my-zsh/pull/2790
alias ggpush='ggp'
alias ggpull='ggl'

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


# MySQL
alias mysql="/Applications/MAMP/Library/bin/mysql"
alias mysqldump="/Applications/MAMP/Library/bin/mysqldump"

# Terminal Settings
bindkey -M viins 'jj' vi-cmd-mode
bindkey -v

# Sauce labs shortuct
alias sauce='tab "sites && cd sauce-labs && bin/sc -u vectormediagroup -k 355ea7db-9fe4-4bde-b729-878d75e3816c"'

source "/Users/khaliq/Configuration-Files/functions.zsh"

# conditionally load some google cloud stuff
if [[ $(HOSTNAME) == "Khaliqs-MacBook-Air.local" ]]; then
    # The next line updates PATH for the Google Cloud SDK.
    source '/Users/khaliq/google-cloud-sdk/path.zsh.inc'
    # The next line enables shell command completion for gcloud.
    source '/Users/khaliq/google-cloud-sdk/completion.zsh.inc'
fi
