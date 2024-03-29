#! /usr/bin/env bash
config=~/Configuration-Files
for file in $config/.*
do
    if [[ "$file" != $config/".DS_Store" && -f "$file" ]]; then
        $dry ln -sf "$file" ~/
    fi;
done

echo "Copying AWS creds"
$dry ln -sf ~/Dropbox/KJG/.aws ~/

echo "Copying Hosts file"
$dry sudo ln -sf ~/Dropbox/KJG/hosts /etc

echo "Copying over global git igore"
$dry ln -sf .global-gitigore ~/.gitignore


#echo "restoring karabiner config"
#$dry ln -s ~/Configuration-Files/config/karabiner ~/.config
