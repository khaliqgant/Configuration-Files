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
