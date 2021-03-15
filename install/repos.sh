# read file contents into memory
repos=$(<data/repos.txt)
sites=~/Sites

if [ ! -d "$sites" ]; then
    mkdir ~/Sites
fi

for repo in $repos
do
    ($dry cd $sites && $dry git clone $repo)
done
