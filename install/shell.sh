 echo "installing spf13"
$dry curl http://j.mp/spf13-vim3 -L -o - | $dry sh
echo "setting symlinks"
sh symlinks.sh
echo "adding zsh syntax highlighting and zsh-nvm"
($dry cd ~/.oh-my-zsh/custom/plugins && 
$dry git clone git://github.com/zsh-users/zsh-syntax-highlighting.git && 
$dry git clone git@github.com:lukechilds/zsh-nvm.git)
