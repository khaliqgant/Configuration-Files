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

# conditionally load some google cloud stuff
if [[ $(HOSTNAME) == "Khaliqs-MacBook-Air.local" ]]; then
    # The next line updates PATH for the Google Cloud SDK.
    source '/Users/khaliq/google-cloud-sdk/path.zsh.inc'
    # The next line enables shell command completion for gcloud.
    source '/Users/khaliq/google-cloud-sdk/completion.zsh.inc'
fi

# load in local .bashrc.local if there
alias bashrc="[ $(find . -maxdepth 2 -name .bashrc-local) ] && source $(find . -maxdepth 2 -name .bashrc-local) && echo 'local bashrc loaded'"

# json pretty print
# http://stackoverflow.com/questions/352098/how-can-i-pretty-print-json?answertab=votes#tab-top
jprint() {
    echo $1 | python -m json.tool
}


# this isn't needed because of the command brew bundle dump
# keeping this for note purposes
update_brewfile() {
    # turn into string array
    config
    brews=($(brew list))
    # loop over elements now
    for brew in "${brews[@]}"
    do
    done
    cd -
}

update_nvm() {
    #n=$(which node);n=${n%/bin/node}; chmod -R 755 $n/bin/*; sudo cp -r $n/{bin,lib,share} /usr/local 
    # grab first line and remove whitespace
    # http://stackoverflow.com/questions/13659318/how-to-remove-space-from-string
    current_node=$(nvm ls | sed -n '1 p' | tr -d ' ')
    #ln -sfvn /Users/khaliq/.nvm/$current_node/lib/node_modules/npm/bin/npm-cli.js /usr/local/bin/
    ln -sfvn /Users/khaliq/.nvm/v0.10.40/lib/node_modules/npm/bin/npm-cli.js /usr/local/bin/npm
}
