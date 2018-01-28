sudo easy_install pip
packages=$(<data/pips.txt)

for package in $packages
do
    $dry sudo pip install $package
done


