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
alias stash-all='git stash --include-untracked'
alias pop='git stash pop'
alias new='git checkout -b'
alias reset="git reset --hard $1"
alias grm="git branch -m $1"
# take you to the top of the git repo
alias root='cd "`git rev-parse --show-toplevel`"'

# remove branches that have been merged into the current branch
purge-branches() {
    git branch --merged | grep -v '\*' | xargs -n 1 git branch -d
}

issue () {
    new "gh-#$1"
}
