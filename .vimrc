"Vim RC

set backspace=eol,start,indent
set background=dark
syntax on
set autoindent
set number

"remap escape key
ino jj <esc>
execute pathogen#infect()
filetype plugin indent on

"Show partial commands in the last line of the screen
set showcmd

" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save changed files.
set confirm

set showmode		"show current mode at the bottom
set autoread		"reload files changed outside of vim
set incsearch		"find the next match as we type the search
set hlsearch		"Highlight searchs by default
execute pathogen#infect()
map <C-e> :NERDTreeToggle<CR>