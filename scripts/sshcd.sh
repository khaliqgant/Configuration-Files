# source: https://gist.github.com/christianbundy/8954786

# let's assume the command is:
# sshcd -v -q root@example.com:/path/to/file

t="${!#}"

# command to run, which I've broken down line by line
c=(
    "ssh" 
    "-t"               # force pseudo-tty allocation (http://www.openbsd.org/cgi-bin/man.cgi?query=ssh&sektion=1)
    "${@:1:$(($#-1))}" # list each of the arguments other than the target ("-v -q")
    "${t%:*}"          # target before the last ":"
    "cd ${t##*:}; \$SHELL -l" # target before the first ":", and start the shell
)

"${c[@]}" # run the command
