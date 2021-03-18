export SHELL=/bin/zsh
# item for eecli
export PATH=~/.composer/vendor/bin:$PATH

export PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
export PATH=/usr/local/share/npm/bin:$PATH #Setting to use Grunt
export PATH=~/npm/bin:$PATH #Because installed node w/o homebrew add the npm path from the local usr
export PATH=~/.node/bin:$PATH #add path for npm install modules
export PATH=/usr/texbin:$PATH #Add latex to path
export PATH=/usr/local/sbin:$PATH
export PATH=~/Library/Python/2.7/bin:$PATH
export PATH=~/Library/Python/3.6/bin:$PATH
export PATH=/usr/local/opt/postgresql@9.6/bin:$PATH

#Go
export GOPATH=/Users/khaliq/Sites/go
export PATH=$PATH:$GOPATH/bin

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

# phpbrew
[[ -e ~/.phpbrew/bashrc ]] && source ~/.phpbrew/bashrc

# Ansible
export PATH="/usr/local/opt/ansible@1.9/bin:$PATH"

# Brewfile
export HOMEBREW_BREWFILE=~/Configuration-Files/Brewfile

# kubectx
autoload -U compinit && compinit
