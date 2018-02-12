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
