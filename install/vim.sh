echo "installing spf13"
$dry curl http://j.mp/spf13-vim3 -L -o - | $dry sh
($dry cd ~/.vim/bundle/vimproc.vim && $dry make)
($dry cd ~/.vim && $dry mkdir undodir)
$dry git clone https://github.com/github/copilot.vim.git ~/.config/nvim/pack/github/start/copilot.vim
