alias docker-stop-all='docker stop $(docker ps -q);'
alias docker-prevent-auto-start='docker update --restart=no $(docker ps -q);'
alias docker-remove-stopped='docker rm $(docker ps -qf "status=exited");'
alias docker-prune-force='docker system prune -af'
