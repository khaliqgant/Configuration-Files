echo "installing spf13"
$dry curl http://j.mp/spf13-vim3 -L -o - | $dry sh
($dry cd ~/.vim/bundle/vimproc.vim && make)
echo "setting symlinks"
sh symlinks.sh
echo "adding zsh plugins"
zshes=$(<data/zshPlugins.txt)

for zsh in $zshes
do
    ($dry cd ~/.oh-my-zsh/custom/plugins && $dry git clone $zsh)
done

echo "copying zsh config to plugins"
$dry cp ~/Configuration-Files/install/config/zsh/* ~/.oh-my-zsh/custom/
