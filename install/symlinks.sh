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
