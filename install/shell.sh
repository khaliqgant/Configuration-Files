#!/usr/bin/env bash

bash symlinks.sh
echo "adding zsh plugins"
zshes=$(<data/zshPlugins.txt)

for zsh in $zshes
do
    plugin_name=$(basename "$zsh" .git)
    plugin_dir=~/.oh-my-zsh/custom/plugins/$plugin_name
    if [ -d "$plugin_dir" ]; then
        echo "$plugin_name already installed, skipping"
    else
        $dry git clone "$zsh" "$plugin_dir"
    fi
done

echo "copying zsh config to plugins"
$dry cp ~/Configuration-Files/install/config/zsh/* ~/.oh-my-zsh/custom/
