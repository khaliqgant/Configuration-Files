#! /usr/bin/env bash
config=~/Configuration-Files
for file in $config/.*
do
    if [[ "$file" != $config/".DS_Store" && -f "$file" ]]; then
        ln -s "$file" ~/
    fi;
done
