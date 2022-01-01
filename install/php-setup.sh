echo "installing php brew"
brew install php
$dry \curl -L -O https://github.com/phpbrew/phpbrew/releases/latest/download/phpbrew.phar
$dry chmod +x phpbrew.phar
$dry sudo mv phpbrew.phar /usr/local/bin/phpbrew
$dry phpbrew init
$dry phpbrew install 8.0 +default +bz2=/usr/bin/bzip2 +zlib=/usr/local/opt/zlib +pdo +mysql

$dry phpbrew ext install gd \
-- --with-libdir=lib/x86_64-linux-gnu \
--with-gd=shared \
--enable-gd-natf \
--with-jpeg-dir=/usr \
--with-png-dir=/usr
