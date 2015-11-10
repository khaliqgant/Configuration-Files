packages=$(<data/gemss.txt)

for package in $packages
do
    $dry gem install $package
done


