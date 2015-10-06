# used this as a guide http://stackoverflow.com/questions/28017374/what-is-the-suggested-way-to-install-brew-node-js-io-js-nvm-npm-on-os-x
brew install nvm
source $(brew --prefix nvm)/nvm.sh

# add that so is loaded every time
echo "source $(brew --prefix nvm)/nvm.sh" >> ~/Configuration-Files/zshes/path.zsh

# specify node.js version here
version=0.10
nvm install $version
npm install -g npm@latest
nvm use $version

# copy active version into usr/local
# source: https://www.digitalocean.com/community/tutorials/how-to-install-node-js-with-nvm-node-version-manager-on-a-vps
n=$(which node);n=${n%/bin/node}; chmod -R 755 $n/bin/*; sudo cp -r $n/{bin,lib,share} /usr/local
