# read file contents into memory
packages=$(<data/composers.txt)

for package in $packages
do
    $dry composer global require $package
done

