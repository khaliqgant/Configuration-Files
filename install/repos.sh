#!/usr/bin/env bash

repos=$(<data/repos.txt)
sites=~/Sites

$dry mkdir -p "$sites"

while read -r line; do
    # handle "url dirname" format (e.g. "git@github.com:foo/bar.git my-dir")
    repo=$(echo "$line" | awk '{print $1}')
    dir=$(echo "$line" | awk '{print $2}')

    # derive directory name from repo url if not specified
    if [[ -z "$dir" ]]; then
        dir=$(basename "$repo" .git)
    fi

    if [ -d "$sites/$dir" ]; then
        echo "$dir already cloned, skipping"
    else
        $dry git clone "$repo" "$sites/$dir"
    fi
done < data/repos.txt
