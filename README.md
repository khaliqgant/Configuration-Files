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
* Using [Homebrew Bundle](https://github.com/Homebrew/homebrew-bundle) 
to manage Homebrew dependencies with a Brewfile.
* To install dependencies manually, navigate to this config repo and run:
```bash
brew bundle
```

Executables
---------
* Any custom shell scripts in `bin/` should be made executable:
```bash
chmod +x bin/replace
```
* They are automatically symlinked to your home directory by `install/symlinks.sh`. To make them globally accessible, you can add `~/bin` to your PATH (already handled in `zshes/path.zsh`).

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
