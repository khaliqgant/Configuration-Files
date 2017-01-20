alias fetch='git fetch -pv'
alias log='git log --oneline --abbrev-commit --all --graph --decorate --color'
alias gc='git commit -m'
alias push='git push origin'
alias pull='git pull origin'
alias status='git status'
alias co='git checkout'
# open the github app
alias gh='github'
# reference : http://git-scm.com/docs/git-clean
alias clean='git clean -f -d'
alias stash='git stash'
alias stash:list='git stash list --date=local'
alias pop='git stash pop'
alias new='git checkout -b'
alias reset='git reset --hard origin/master'
# take you to the top of the git repo
alias root='cd "`git rev-parse --show-toplevel`"'
# zsh got rid of these commands with this PR https://github.com/robbyrussell/oh-my-zsh/pull/2790
alias ggpush='ggp'
alias ggpull='ggl'
