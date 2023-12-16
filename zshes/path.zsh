export SHELL=/bin/zsh

eval "$(/opt/homebrew/bin/brew shellenv)"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"

export PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
export PATH=/usr/local/share/npm/bin:$PATH #Setting to use Grunt
export PATH=~/npm/bin:$PATH #Because installed node w/o homebrew add the npm path from the local usr
export PATH=~/.node/bin:$PATH #add path for npm install modules
export PATH=/usr/texbin:$PATH #Add latex to path
export PATH=/usr/local/sbin:$PATH
export PATH=/opt/homebrew/bin/php/bin:$PATH
export PATH=/Users/Shared/DBngin/postgresql/15.1/bin:$PATH

#Go
export GOPATH=/Users/khaliqgant/Sites/go
export PATH=$PATH:$GOPATH/bin

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

# Ruby
export PATH="$HOME/.gem/ruby/2.6.0/bin:$PATH"

# phpbrew
[[ -e ~/.phpbrew/bashrc ]] && source ~/.phpbrew/bashrc

# Ansible
export PATH="/usr/local/opt/ansible@1.9/bin:$PATH"

# Brewfile
export HOMEBREW_BREWFILE=~/Configuration-Files/Brewfile

# kubectx
autoload -U compinit && compinit

# JAVA
export JAVA_HOME=$(/usr/libexec/java_home)
