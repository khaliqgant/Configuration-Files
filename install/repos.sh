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


work=~/Dropbox\ \(Vector\ Media\ Group\)/Vector
work_repos=$(<$work/repos.txt)

for repo in $work_repos
do
    ($dry cd $sites && $dry git clone $repo)
done
