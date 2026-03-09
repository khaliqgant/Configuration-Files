export SHELL=/bin/zsh

eval "$(/opt/homebrew/bin/brew shellenv)"
eval "$(mise activate zsh)"

export PATH=/usr/local/sbin:$PATH
export PATH=/Users/Shared/DBngin/postgresql/15.1/bin:$PATH
export PATH=$PATH:/Users/khaliqgant/bin # terraform switch

[ -z "$HOSTNAME" ] && export HOSTNAME="$(hostname)"

# Brewfile
export HOMEBREW_BREWFILE=~/Configuration-Files/Brewfile

# kubectx
autoload -U compinit && compinit

# JAVA
[[ -x /usr/libexec/java_home ]] && /usr/libexec/java_home &>/dev/null && export JAVA_HOME=$(/usr/libexec/java_home)

# AI Agent Tools
export PATH="$PATH:$HOME/Projects/ai-tooling/agent-tools/brave-search"
export PATH="$PATH:$HOME/Projects/ai-tooling/agent-tools/search-tools"
export PATH="$PATH:$HOME/Projects/ai-tooling/agent-tools/browser-tools"
export PATH="$PATH:$HOME/Projects/ai-tooling/agent-tools/vscode"
