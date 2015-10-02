echo "install oh-my-zsh && spf13"
$dry sh -c "$($dry curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" && $dry curl http://j.mp/spf13-vim3 -L -o - | $dry sh
echo "setting symlinks"
sh symlinks.sh
echo "adding zsh syntax highlighting"
($dry cd ~/.oh-my-zsh/custom/plugins && $dry git clone git://github.com/zsh-users/zsh-syntax-highlighting.git)
