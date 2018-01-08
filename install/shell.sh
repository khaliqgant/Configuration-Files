sh symlinks.sh
echo "adding zsh plugins"
zshes=$(<data/zshPlugins.txt)

for zsh in $zshes
do
    ($dry cd ~/.oh-my-zsh/custom/plugins && $dry git clone $zsh)
done

echo "copying zsh config to plugins"
$dry cp ~/Configuration-Files/install/config/zsh/* ~/.oh-my-zsh/custom/

echo "setting tab to be able to navigate menu items"
# https://superuser.com/questions/473143/how-to-tab-between-buttons-on-an-mac-os-x-dialog-box
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3
