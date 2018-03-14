# load in tab function
source ~/Configuration-Files/zshes/tab.zsh

# load in the json functions
source ~/Configuration-Files/zshes/functions/json.zsh


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

function searchConfig () {
    sed -n "/"$1"/,/^$/p" ~/.ssh/config;
}

function perf {
  curl -o /dev/null  -s -w "%{time_connect} + %{time_starttransfer} = %{time_total}\n" "$1"
}

# conditionally load some google cloud stuff
if [[ $HOSTNAME == "Khaliqs-MacBook-Pro.local" ]]; then
    # The next line updates PATH for the Google Cloud SDK.
    source '/Users/khaliq/Development/google-cloud-sdk/path.zsh.inc'
    # The next line enables shell command completion for gcloud.
    source '/Users/khaliq/Development/google-cloud-sdk/completion.zsh.inc'
fi

# conditionally load in some project specific items for my work computer
if [[ $HOSTNAME == "Khaliqs-MacBook-Pro.local" ]]; then
    source '/Users/khaliq/Dropbox/KJG/Personal/Work/VMG/scripts/functions.zsh'
fi

# load in local .bashrc.local if there
alias bashrc="[ $(find . -maxdepth 2 -name .bashrc-local) ] && source $(find . -maxdepth 2 -name .bashrc-local) && echo 'local bashrc loaded'"
alias show:bashrc="[ $(find . -maxdepth 2 -name .bashrc-local) ] && cat $(find . -maxdepth 2 -name .bashrc-local)"

# start up a bunch of apps by calling a script
alias start="sh ~/Configuration-Files/scripts/start.sh"
alias copyPrepareCommit="sh ~/Configuration-Files/scripts/copyPrepareCommit.sh"

# navigate to a directory as soon as you ssh in
# invoke by sshcd server-alias:directory/to/navigate/to
sshcd() {
    sh ~/Configuration-Files/scripts/sshcd.sh $1
}

generate_invoice() {
    sh ~/Dropbox/KJG/Development/invoice-generator/generate.sh
}

# Translations uses https://github.com/soimort/translate-shell
# Norwegian to English
betyr() {
    trans -l no :en $1 --show-original=no
}
