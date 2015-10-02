# read file contents into memory
repos=$(<repos.txt)
sites=~/Sites

for repo in $repos
do
    ($dry cd $sites && $dry git clone $repo)
done


