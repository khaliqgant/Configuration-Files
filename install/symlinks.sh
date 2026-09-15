#!/usr/bin/env bash
config=~/Configuration-Files
# Files managed by spf13 — do not overwrite their symlinks
spf13_managed=(.vimrc .vimrc.before .vimrc.bundles)

for file in $config/.*
do
    basename=$(basename "$file")
    # Skip ., .., .git and files managed by spf13
    if [[ "$basename" == "." || "$basename" == ".." || "$basename" == ".git" || "$basename" == ".DS_Store" ]]; then
        continue
    fi

    if [[ -f "$file" ]]; then
        skip=false
        for managed in "${spf13_managed[@]}"; do
            if [[ "$basename" == "$managed" ]]; then
                skip=true
                break
            fi
        done
        if [[ "$skip" == false ]]; then
            $dry ln -sf "$file" ~/
        fi
    fi;
done

echo "Copying AWS creds"
$dry ln -sf ~/Dropbox/"Khaliq Gant"/KJG/.aws ~/

echo "Copying Hosts file"
$dry sudo ln -sf ~/Dropbox/"Khaliq Gant"/KJG/hosts /etc

echo "Copying over global git ignore"
$dry ln -sf .global-gitignore ~/.gitignore

echo "Symlinking mise global config"
$dry mkdir -p ~/.config/mise
# Remove existing file/symlink first (sudo in case it's root-owned from a prior sudo run)
$dry sudo rm -f ~/.config/mise/config.toml
$dry ln -sf ~/Configuration-Files/mise-global.toml ~/.config/mise/config.toml

# Omarchy/Hyprland (Linux only) — only the files we've actually customized,
# not the full ~/.config/hypr and ~/.config/omarchy trees.
if [[ -d ~/.config/hypr ]]; then
    echo "Symlinking Hyprland config overrides"
    $dry ln -sf ~/Configuration-Files/hypr/bindings.lua ~/.config/hypr/bindings.lua
    $dry ln -sf ~/Configuration-Files/hypr/monitors.lua ~/.config/hypr/monitors.lua
fi

if [[ -d ~/.config/omarchy ]]; then
    echo "Symlinking Omarchy shell config"
    $dry ln -sf ~/Configuration-Files/omarchy/shell.json ~/.config/omarchy/shell.json
fi
