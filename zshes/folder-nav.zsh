alias back='cd -'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias site='sites'
alias sites='cd ~/Sites'
alias projects='cd ~/Projects'
alias p='cd ~/Projects'
alias n='cd ~/Projects/nango'
alias config='cd ~/Configuration-Files'
alias Sites='cd ~/Sites'
alias Sites='cd ~/Projects'
alias Config='cd ~/Configuration-Files'
alias paris='cd /Volumes/Paris\ Drive/Projects/'
alias spf=' cd ~/.spf13-vim-3/'
alias home=$HOME
alias tree="find . -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'"

# mkdir and cd into that dir
mkd() {
    mkdir -p $1
    cd $1
}

octal() {
    stat -f "%Sp %OLp" $1
}

reload() {
    cd ../ && cd -
}

# quickly find files and directory
alias ff='find . -type f -name'
alias fd='find . -type d -name'

# copy the current working directory to the clipboard
alias cpwd='pwd | xclip -selection clipboard'
alias list='ls -tlla'

# https://apple.stackexchange.com/questions/50844/how-to-move-files-to-trash-from-command-line/50849#50849
trash() { mv -fv "$@" ~/.Trash/ ; }
