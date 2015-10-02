# New Computer Setup Install Scripts
Oh, new computer?? You fancy huh?

## Steps
1. Install Dropbox & Git
2. Once have dropbox set up, run the start.sh there
3. Clone this repo and run install/run.sh (this gets called automatically from the start.sh from above)
4. run.sh then calls a few different shell scripts which will install apps on apps on apps

## What is being installed
* SSH config (via Dropbox start.sh)
* This repo
* [spf13](http://vim.spf13.com/#install)
* [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh)
* Adds [zsh syntax highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)
* https://github.com/zsh-users/zsh-history-substring-search
* ....

## Tests
* Run tests/main.sh to generate an output of everything that is going to run. 
Tests pass a ```--dry-run``` flag to the scripts which simply outputs and doesn’t run
* In addition there are individual scripts that call the broken out scripts
with the ```--dry-run``` in progress

