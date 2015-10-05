# used this as a guide http://stackoverflow.com/questions/28017374/what-is-the-suggested-way-to-install-brew-node-js-io-js-nvm-npm-on-os-x
brew install nvm
source $(brew --prefix nvm)/nvm.sh

# add that so is loaded every time
echo "source $(brew --prefix nvm)/nvm.sh" >> ~/Configuration-Files/zshes/path.zsh

nvm install 2.0.2
npm install -g npm@latest
