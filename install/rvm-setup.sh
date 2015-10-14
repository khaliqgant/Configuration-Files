echo "installing rvm"
$dry \curl -sSL https://get.rvm.io | bash -s stable
echo "install a couple of ruby versions"
$dry rvm install 2.2.0 --rubygems 2.4.6
$dry rvm install ruby-2.0.0-p451
echo "using ruby 2.0.0 version"
rvm use ruby-2.0.0-p451
