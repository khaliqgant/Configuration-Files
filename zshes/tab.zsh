# open up a new tab no matter iterm/terminal

# source: https://gist.github.com/bobthecow/757788
# http://stackoverflow.com/questions/1589114/opening-a-new-terminal-tab-in-osxsnow-leopard-with-the-opening-terminal-window
function tab() {

# find which app they're using
app=`echo $TERM_PROGRAM`

cmd=""
cdto="$PWD"
args="$@"

if [ -d "$1" ]; then
    cdto=`cd "$1"; pwd`
    args="${@:2}"
fi

if [ -n "$args" ]; then
    cmd="; $args"
fi

if [[ " ${app} " == *" iTerm.app "* ]]; then
osascript &>/dev/null <<EOF
    tell application "$app"
        tell current terminal
            launch session "Default Session"
            tell the last session
                write text "cd \"$cdto\"$cmd"
            end tell
        end tell
    end tell
EOF
fi

if [[ " ${app} " == *" Apple_Terminal "* ]]; then
    if [ $# -ne 1 ]; then
        PATHDIR=`pwd`
    else
        PATHDIR=$1
    fi

    /usr/bin/osascript <<EOF
    activate application "Terminal"
    tell application "System Events"
        keystroke "t" using {command down}
    end tell
    tell application "Terminal"
        repeat with win in windows
            try
                if get frontmost of win is true then
                    do script "cd $PATHDIR; clear; $cmd;" in (selected tab of win)
                end if
            end try
        end repeat
    end tell
EOF
clear
fi
}
