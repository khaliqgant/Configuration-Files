# read file contents into memory
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer
packages=$(<data/composers.txt)

for package in $packages
do
    $dry composer global require $package
done

sudo valet install
