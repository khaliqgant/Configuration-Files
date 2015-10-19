# largely copied from https://gist.github.com/t-io/8255711
echo Install Homebrew
$dry ruby -e "$($dry curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
$dry brew install caskroom/cask/brew-cask
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

# install all the apps
apps=$(<data/apps.txt)
echo "Installing apps on apps on apps"
for app in $apps
do
    $dry brew cask install $app
done
echo "installing macvim with lua support see https://github.com/Shougo/neocomplete.vim#vim-for-mac-os-x"
brew install macvim --with-cscope --with-lua
echo "installing valgrind for c development"
# source: http://stackoverflow.com/questions/26564125/yosemite-and-valgrind
brew install --HEAD valgrind
echo "installing sshpas"
brew install https://raw.githubusercontent.com/kadwanev/bigboybrew/master/Library/Formula/sshpass.rb
