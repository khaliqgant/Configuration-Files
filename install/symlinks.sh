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

echo "Symlinking mise config"
$dry mkdir -p ~/.config/mise
# Remove existing file/symlink first (sudo in case it's root-owned from a prior sudo run)
$dry sudo rm -f ~/.config/mise/config.toml
$dry ln -sf ~/Configuration-Files/mise.toml ~/.config/mise/config.toml
