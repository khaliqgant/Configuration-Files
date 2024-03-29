My Configuration Files
--------
- Create symlinks to these files for version controlled config files
- For example
```
ln -s ~/Configuration-Files/.vimrc.bundles.local ~/
```
- If doing a new set up quickly symlink everything by
```
ln -s .* ~/
```

* I am also using spf13-vim-3 (http://vim.spf13.com/#install) for my vimrc settings which holds the majority of my settings. Any overrides or extra settings are located in the vimrc.local which overrides spf13 settings.
* In addition I am using JSHint (https://github.com/Shutnik/jshint2.vim) as an additional bundle
* Also using numbers.vim (https://github.com/myusuf3/numbers.vim) to toggle numbers, specifically to show line numbers within nerdtree for faster navigation
* Using [Vim Instant Markdown](https://github.com/suan/vim-instant-markdown) to open up an instant preview
    run ```InstantMarkdownPreview```
* Making use of [YouCompleteMe](https://github.com/Valloric/YouCompleteMe). Steps:
    1. Add to Vundle (.vimrc-bundles.local)
    2. cd into the YouCompleteMe directory and run
        ```
        ./install.sh --clang-completer
        ```
    3. In my instance, I had brew unlink cmake and reinstall via brew
    4. Also to quiet the python quitting error, had to brew unlink python as wel
* Using [homebrew-brewdler](https://github.com/Homebrew/homebrew-brewdler) 
to manage homebrew depdencies with a Brewfile. To install brewdler run
```
brew tap Homebrew/brewdler
```
* To install homebrew depdencies navigate to this config repo and run
```
brew brewdle
```
* Might want to move to [homebrew-file](https://github.com/rcmdnk/homebrew-file) instead
* To run latex manipulations download [mactext](http://www.tug.org/mactex/index.html)

Executables
---------
* Any custom shell scripts turn the file into an executable
```
chmod +x replace
```
* Sym link it to the usr/local/bin directory
```
ln -s ~/Configuration-Files/bin/replace .
```

Linting
---------
* Using [ALE](https://github.com/w0rp/ale) to run linting checks since it lints
asynchrnously to prevent lag. Syntastic is installed but disabled:
```
# https://stackoverflow.com/questions/20030603/vim-syntastic-how-to-disable-the-checker
let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': [],'passive_filetypes': [] }
nnoremap <C-w>E :SyntasticCheck<CR> :SyntasticToggleMode<CR>
```
* ALE lags on text entering so it doesn't lint on text change:
```
let g:ale_lint_on_text_changed = 'never'
```
