#!/usr/bin/env bash

if [ ! -d ~/.spf13-vim-3 ]; then
    echo "installing spf13"
    $dry curl https://raw.githubusercontent.com/spf13/spf13-vim/3.0/bootstrap.sh -L -o - | $dry sh
else
    echo "spf13 already installed, skipping"
fi

# Ensure spf13 symlinks are correct (symlinks.sh or other scripts can break these)
echo "Restoring spf13 symlinks"
$dry ln -sf ~/.spf13-vim-3/.vimrc ~/.vimrc
$dry ln -sf ~/.spf13-vim-3/.vimrc.before ~/.vimrc.before
$dry ln -sf ~/.spf13-vim-3/.vimrc.bundles ~/.vimrc.bundles

if [ -d ~/.vim/bundle/vimproc.vim ]; then
    ($dry cd ~/.vim/bundle/vimproc.vim && $dry make)
fi

$dry mkdir -p ~/.vim/undodir

copilot_dir=~/.config/nvim/pack/github/start/copilot.vim
if [ ! -d "$copilot_dir" ]; then
    echo "installing copilot.vim"
    $dry git clone https://github.com/github/copilot.vim.git "$copilot_dir"
else
    echo "copilot.vim already installed, skipping"
fi
