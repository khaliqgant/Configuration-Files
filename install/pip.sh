sudo easy_install pip
packages=$(<data/pips.txt)

for package in $packages
do
    $dry pip install $package --user
    $dry python3 -m pip install $package
done


