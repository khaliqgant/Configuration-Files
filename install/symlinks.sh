#!/usr/bin/env bash
config=~/Configuration-Files
for file in $config/.*
do
    if [[ "$file" != $config/".DS_Store" && -f "$file" ]]; then
        $dry ln -sf "$file" ~/
    fi;
done

echo "Copying AWS creds"
$dry ln -sf ~/Dropbox/"Khaliq Gant"/KJG/.aws ~/

echo "Copying Hosts file"
$dry sudo ln -sf ~/Dropbox/"Khaliq Gant"/KJG/hosts /etc

echo "Copying over global git ignore"
$dry ln -sf .global-gitigore ~/.gitignore

echo "Symlinking mise config"
$dry mkdir -p ~/.config/mise
$dry ln -sf ~/Configuration-Files/mise.toml ~/.config/mise/config.toml
