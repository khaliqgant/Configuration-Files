packages=$(<data/npm.txt)

for package in $packages
do
    $dry sudo npm install -g $package
done

