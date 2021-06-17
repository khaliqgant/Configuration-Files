which sqlite3 >/dev/null 2>&1 || return;

CLIPBOARDDB_FILE="${HOME}/Library/Application Support/Alfred/Databases/clipboard.alfdb"

_clipboard_query () {
    sqlite3 ${CLIPBOARDDB_FILE} "$@"
    [[ "$?" -ne 0 ]] && echo "error in $@"
}

search_clipboard_history() {
    local query="
        select Item
        from clipboard
        where Item LIKE '$(sql_escape $1)%'
        order by ts desc
        limit 10
    "
    results=$(_clipboard_query "$query")
    echo "$results"
}
