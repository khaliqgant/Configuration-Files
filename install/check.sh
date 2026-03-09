#!/usr/bin/env bash
#
# Audit script: checks what's installed vs what should be installed.
# Run: bash install/check.sh
#

CONFIG_DIR=~/Configuration-Files
DATA_DIR="$CONFIG_DIR/install/data"

# Counters
PASS_COUNT=0
MISS_COUNT=0
WARN_COUNT=0

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[0;33m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m'

pass() { echo -e "  ${GREEN}PASS${NC}  $1"; PASS_COUNT=$((PASS_COUNT + 1)); }
miss() { echo -e "  ${RED}MISS${NC}  $1"; MISS_COUNT=$((MISS_COUNT + 1)); }
warn() { echo -e "  ${YELLOW}WARN${NC}  $1"; WARN_COUNT=$((WARN_COUNT + 1)); }

section() { echo -e "\n${CYAN}${BOLD}[$1]${NC}"; }

# ─── 1. Homebrew ──────────────────────────────────────────────────────────────

section "Homebrew"

if command -v brew >/dev/null 2>&1; then
    pass "Homebrew installed"

    if [ -f "$CONFIG_DIR/Brewfile" ]; then
        installed_formulae=$(brew list --formula 2>/dev/null)
        installed_casks=$(brew list --cask 2>/dev/null)

        missing_formulae=""
        missing_casks=""

        while IFS= read -r line; do
            # Skip comments, empty lines, taps
            case "$line" in
                ""|\#*|tap*) continue ;;
            esac

            # Extract package name from brew "pkg" or cask "pkg" lines
            pkg=$(echo "$line" | sed -n 's/^brew ["\x27]\([^"\x27]*\)["\x27].*/\1/p')
            if [ -n "$pkg" ]; then
                if ! echo "$installed_formulae" | grep -qw "$pkg"; then
                    missing_formulae="$missing_formulae $pkg"
                fi
                continue
            fi

            pkg=$(echo "$line" | sed -n 's/^cask ["\x27]\([^"\x27]*\)["\x27].*/\1/p')
            if [ -n "$pkg" ]; then
                if ! echo "$installed_casks" | grep -qiw "$pkg"; then
                    missing_casks="$missing_casks $pkg"
                fi
            fi
        done < "$CONFIG_DIR/Brewfile"

        if [ -z "$missing_formulae" ]; then
            pass "All Brewfile formulae installed"
        else
            miss "Missing formulae:$missing_formulae"
        fi

        if [ -z "$missing_casks" ]; then
            pass "All Brewfile casks installed"
        else
            miss "Missing casks:$missing_casks"
        fi
    else
        miss "Brewfile not found at $CONFIG_DIR/Brewfile"
    fi
else
    miss "Homebrew not installed"
fi

# ─── 2. Mise ──────────────────────────────────────────────────────────────────

section "Mise"

if command -v mise >/dev/null 2>&1; then
    pass "mise installed"

    mise_installed=$(mise list 2>/dev/null || true)

    check_mise_runtime() {
        local name="$1"
        local expected="$2"
        if echo "$mise_installed" | grep -qi "$name"; then
            local version
            version=$(echo "$mise_installed" | grep -i "$name" | head -1 | awk '{print $2}')
            if [ "$expected" = "latest" ]; then
                pass "$name installed (v$version)"
            elif echo "$version" | grep -q "$expected"; then
                pass "$name $expected installed (v$version)"
            else
                warn "$name installed (v$version) but expected $expected"
            fi
        else
            miss "$name not installed via mise"
        fi
    }

    check_mise_runtime "node" "22"
    check_mise_runtime "python" "3.12.4"
    check_mise_runtime "ruby" "3.3.0"
    check_mise_runtime "go" "latest"
    check_mise_runtime "rust" "latest"
else
    miss "mise not installed"
fi

# ─── CLI Tools ────────────────────────────────────────────────────────────────

section "CLI Tools"

if command -v claude >/dev/null 2>&1; then
    pass "Claude Code CLI installed"
else
    miss "Claude Code CLI not installed (curl -fsSL https://claude.ai/install.sh | bash)"
fi

if command -v amp >/dev/null 2>&1; then
    pass "Amp CLI installed"
else
    miss "Amp CLI not installed (curl -fsSL https://ampcode.com/install.sh | bash)"
fi

if command -v kiro >/dev/null 2>&1; then
    pass "Kiro CLI installed"
else
    miss "Kiro CLI not installed (curl -fsSL https://cli.kiro.dev/install | bash)"
fi

# ─── 3. Old version managers ─────────────────────────────────────────────────

section "Old Version Managers"

check_old_vm() {
    local dir="$1"
    local name="$2"
    local replacement="$3"
    if [ -d "$dir" ]; then
        warn "$name detected at $dir — migrate to mise ($replacement)"
    else
        pass "No $name found"
    fi
}

check_old_vm "$HOME/.nvm" "nvm" "mise use --global node@22"
check_old_vm "$HOME/.pyenv" "pyenv" "mise use --global python@3.12.4"
check_old_vm "$HOME/.rvm" "rvm" "mise use --global ruby@3.3.0"

# Check for cargo installed outside mise
if [ -f "$HOME/.cargo/env" ] && ! mise list 2>/dev/null | grep -qi rust; then
    warn "Standalone cargo/rustup at ~/.cargo — consider using mise for Rust"
elif [ -f "$HOME/.cargo/env" ]; then
    pass "~/.cargo exists (Rust managed by mise)"
else
    pass "No standalone cargo/rustup found"
fi

# ─── 4. Global packages ──────────────────────────────────────────────────────

section "Global Packages"

# npm
if command -v npm >/dev/null 2>&1; then
    npm_global=$(npm list -g --depth=0 2>/dev/null || true)
    missing_npm=""
    while IFS= read -r pkg; do
        [ -z "$pkg" ] && continue
        if ! echo "$npm_global" | grep -qw "$pkg"; then
            missing_npm="$missing_npm $pkg"
        fi
    done < "$DATA_DIR/npm.txt"

    if [ -z "$missing_npm" ]; then
        pass "All npm global packages installed"
    else
        miss "Missing npm packages:$missing_npm"
    fi
else
    miss "npm not available — install Node via mise first"
fi

# pip
if command -v pip3 >/dev/null 2>&1 || command -v pip >/dev/null 2>&1; then
    pip_cmd=$(command -v pip3 2>/dev/null || command -v pip 2>/dev/null)
    pip_installed=$($pip_cmd list --format=columns 2>/dev/null || true)
    missing_pip=""
    while IFS= read -r pkg; do
        [ -z "$pkg" ] && continue
        if ! echo "$pip_installed" | grep -qiw "$pkg"; then
            missing_pip="$missing_pip $pkg"
        fi
    done < "$DATA_DIR/pips.txt"

    if [ -z "$missing_pip" ]; then
        pass "All pip packages installed"
    else
        miss "Missing pip packages:$missing_pip"
    fi
else
    miss "pip not available — install Python via mise first"
fi

# gems
if command -v gem >/dev/null 2>&1; then
    gem_installed=$(gem list --no-details 2>/dev/null || true)
    missing_gem=""
    while IFS= read -r pkg; do
        [ -z "$pkg" ] && continue
        if ! echo "$gem_installed" | grep -qw "$pkg"; then
            missing_gem="$missing_gem $pkg"
        fi
    done < "$DATA_DIR/gems.txt"

    if [ -z "$missing_gem" ]; then
        pass "All gem packages installed"
    else
        miss "Missing gem packages:$missing_gem"
    fi
else
    miss "gem not available — install Ruby via mise first"
fi

# ─── 5. Repos ────────────────────────────────────────────────────────────────

section "Repos"

while IFS= read -r line; do
    [ -z "$line" ] && continue
    # Check if line has a custom directory name (space-separated)
    custom_dir=$(echo "$line" | awk '{print $2}')
    if [ -n "$custom_dir" ]; then
        repo_dir="$custom_dir"
    else
        repo_dir=$(basename "$line" .git)
    fi

    # Support paths like "Projects/ai-hist" — resolve relative to $HOME
    if [[ "$repo_dir" == */* ]]; then
        repo_path="$HOME/$repo_dir"
    else
        repo_path="$HOME/Sites/$repo_dir"
    fi

    if [ -d "$repo_path" ]; then
        pass "Repo $repo_dir cloned"
    else
        miss "Repo $repo_dir not cloned at $repo_path"
    fi
done < "$DATA_DIR/repos.txt"

# ─── 6. Zsh plugins ──────────────────────────────────────────────────────────

section "Zsh Plugins"

ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

while IFS= read -r url; do
    [ -z "$url" ] && continue
    plugin_name=$(basename "$url" .git)
    if [ -d "$ZSH_CUSTOM/plugins/$plugin_name" ]; then
        pass "Plugin $plugin_name installed"
    else
        miss "Plugin $plugin_name not installed"
    fi
done < "$DATA_DIR/zshPlugins.txt"

# ─── 7. Symlinks ─────────────────────────────────────────────────────────────

section "Symlinks"

for file in "$CONFIG_DIR"/.*; do
    bname=$(basename "$file")
    # Skip dirs, .DS_Store, .git
    [ "$bname" = ".DS_Store" ] && continue
    [ "$bname" = "." ] && continue
    [ "$bname" = ".." ] && continue
    [ "$bname" = ".git" ] && continue
    [ ! -f "$file" ] && continue

    target="$HOME/$bname"
    if [ -L "$target" ]; then
        pass "Symlink $bname"
    elif [ -f "$target" ]; then
        warn "$bname exists but is not a symlink"
    else
        miss "Symlink $bname missing"
    fi
done

# ─── 8. Dropbox symlink ──────────────────────────────────────────────────────

section "Dropbox"

if [ -d "$HOME/Dropbox" ] || [ -L "$HOME/Dropbox" ]; then
    pass "~/Dropbox exists"
    if [ -d "$HOME/.aws" ] || [ -L "$HOME/.aws" ]; then
        pass "~/.aws linked"
    else
        miss "~/.aws not linked (run: ln -sf ~/Dropbox/Khaliq\ Gant/KJG/.aws ~/)"
    fi
else
    miss "~/Dropbox not found"
fi

# ─── 9. Services ─────────────────────────────────────────────────────────────

section "Services"

if command -v brew >/dev/null 2>&1; then
    brew_services=$(brew services list 2>/dev/null || true)

    check_service() {
        local svc="$1"
        if echo "$brew_services" | grep -qw "$svc"; then
            if echo "$brew_services" | grep "$svc" | grep -qw "started"; then
                pass "$svc running"
            else
                warn "$svc installed but not running"
            fi
        else
            miss "$svc not installed as a service"
        fi
    }

    check_service "mysql"
    check_service "mailhog"
else
    miss "Homebrew not available — cannot check services"
fi

# ─── Summary ─────────────────────────────────────────────────────────────────

echo ""
echo -e "${BOLD}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}PASS: $PASS_COUNT${NC}  ${RED}MISS: $MISS_COUNT${NC}  ${YELLOW}WARN: $WARN_COUNT${NC}"
echo -e "${BOLD}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"

if [ $MISS_COUNT -gt 0 ] || [ $WARN_COUNT -gt 0 ]; then
    echo ""
    echo -e "${BOLD}Next steps:${NC}"
    if [ $MISS_COUNT -gt 0 ]; then
        echo "  1. Run missing install scripts from ~/Configuration-Files/install/"
    fi
    if [ $WARN_COUNT -gt 0 ]; then
        echo "  2. Review warnings above — old version managers should be removed"
    fi
    echo "  3. Re-run this script to verify: bash install/check.sh"
fi
