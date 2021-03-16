packages=$(<data/npm.txt)

for package in $packages
do
    $dry npm install -g $package
done

$dry nvm install-latest-npm

