 echo "installing spf13"
# @TODO install oh-my-zsh cancels the rest of the script, probably because it restarts the shell
#$dry sh -c "$($dry curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
$dry curl http://j.mp/spf13-vim3 -L -o - | $dry sh
echo "setting symlinks"
sh symlinks.sh
echo "adding zsh syntax highlighting and zsh-nvm"
($dry cd ~/.oh-my-zsh/custom/plugins && 
$dry git clone git://github.com/zsh-users/zsh-syntax-highlighting.git && 
$dry git clone git@github.com:lukechilds/zsh-nvm.git)
