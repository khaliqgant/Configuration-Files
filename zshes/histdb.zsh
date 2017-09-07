# https://github.com/larkery/zsh-histdb

source ~/Configuration-Files/zshes/vendor/sqlite-history.zsh
source ~/Configuration-Files/zshes/vendor/history-timer.zsh
#source ~/Configuration-Files/zshes/vendor/histdb-merge.zsh
autoload -Uz add-zsh-hook
add-zsh-hook preexec _start_timer
add-zsh-hook precmd  _stop_timer

_zsh_autosuggest_strategy_histdb_top_here() {
    local query="select commands.argv from
history left join commands on history.command_id = commands.rowid
left join places on history.place_id = places.rowid
where (places.dir LIKE '$(sql_escape $PWD)%' OR 1=1)
and commands.argv LIKE '$(sql_escape $1)%'
group by commands.argv 
order by count(*) desc, 
places.dir LIKE '$(sql_escape $PWD)%' desc 
limit 1"
    _histdb_query "$query"
}

ZSH_AUTOSUGGEST_STRATEGY=histdb_top_here