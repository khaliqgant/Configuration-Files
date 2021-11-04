# restart the shell
alias restart='exec -l $SHELL'

#Vim
alias v='open -a Macvim .'

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

alias ssh-config='open -a Macvim ~/.ssh/config'
alias show:ssh-config='cat ~/.ssh/config'
alias .zshrc='open -a Macvim ~/.zshrc'
alias .vimrc='open -a Macvim ~/.vimrc.local'
alias .bundles='open -a Macvim ~/.vimrc.bundles.local'
alias spf-vimrc='open -a Macvim ~/.spf13-vim-3/.vimrc'
alias vim-bundle='cd ~/.spf13-vim-3/.vim/bundle'

alias npmrc='(cd ~/ && ln -sf ~/Dropbox/KJG/.npmrc .npmrc)'

alias local_scripts="open -a Macvim ~/Dropbox/KJG/Development/scripts.zsh"
