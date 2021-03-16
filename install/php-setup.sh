echo "installing php brew"
$dry \curl -L -O https://github.com/phpbrew/phpbrew/releases/latest/download/phpbrew.phar
$dry chmod +x phpbrew.phar
$dry sudo mv phpbrew.phar /usr/local/bin/phpbrew
$dry phpbrew init
$dry phpbrew install 8.0 +default +bz2=/usr/local/opt/bzip2 +zlib=/usr/local/opt/zlib +pdo +mysql
