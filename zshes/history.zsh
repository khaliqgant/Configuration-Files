dropbox=~/Dropbox\ \(Personal\)/KJG/Computers
historyL=$dropbox/.history

# cp the history file from this comp to dropbox
cp ~/.zsh_history "$historyL"/"`hostname`"

# now enable to search all histories, and use ack to do so
all_history() {
    (cd "$historyL" && ack "$1")
}
