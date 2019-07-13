dropbox=~/Dropbox/KJG/Computers
historyL=$dropbox/.history

# cp the history file from this comp to dropbox
cp ~/.zsh_history "$historyL"/"`hostname`"

# now enable to search all histories, and use ack to do so
all_history() {
    (cd "$historyL" && ack "$1")
}

# with optional limit parameter
# the top result is the most recent
show_local_history() {
    limit="${1:-10}"
    local query="
        select history.start_time, commands.argv 
        from history left join commands on history.command_id = commands.rowid
        left join places on history.place_id = places.rowid
        where places.dir LIKE '$(sql_escape $PWD)%'
        order by history.start_time desc
        limit $limit
    "
    results=$(_histdb_query "$query")
    echo "$results"
}

search_local_history() {
    show_local_history 100 | rg "$1"
}
