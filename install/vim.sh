echo "installing spf13"
$dry curl http://j.mp/spf13-vim3 -L -o - | $dry sh
($dry cd ~/.vim/bundle/vimproc.vim && make)
