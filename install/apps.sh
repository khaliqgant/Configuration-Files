# largely copied from https://gist.github.com/t-io/8255711
echo Install Homebrew
$dry ruby -e "$($dry curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
$dry brew install caskroom/cask/brew-cask
export HOMEBREW_CASK_OPTS="--appdir=/Applications"
echo "Install Core Apps"
$dry brew cask install vlc
$dry brew cask install iterm2
$dry brew cask install java
echo "Install dev appps"
$dry brew cask install github
$dry brew cask install sublime-text
$dry brew cask install macvim
$dry brew cask install virtualbox
$dry brew cask install vagrant
$dry brew cask install sourcetree
$dry brew cask install mamp
$dry brew cask install transmit
$dry brew cask install sequel-pro
$dry brew cask install google-drive
echo "install mac apps"
$dry brew cask install alfred
$dry brew cask install zooom
$dry brew cask install bartender
$dry brew cask install codebox
$dry brew cask install flux
$dry brew cask install clipmenu
$dry brew cask install rescuetime
$dry brew cask install spectacle
$dry brew cask install divvy
$dry brew cask install cloud
$dry brew cask install disk-inventory-x
$dry brew cask install xtrafinder
echo "install browsers"
$dry brew cask install firefox
$dry brew cask install google-chrome
echo "install entertainment apps"
$dry brew cask install spotify
$dry brew cask install hipchat
