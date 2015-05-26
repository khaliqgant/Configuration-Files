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
