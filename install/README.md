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

## Other dependencies
* Handle homebrew installations: https://github.com/Homebrew/homebrew-bundle
* Handle syncing app configurations: https://github.com/lra/mackup
* Handle installing apps: https://github.com/caskroom/homebrew-cask

## Tests
* Run tests/main.sh to generate an output of everything that is going to run. 
Tests pass a ```--dry-run``` flag to the scripts which simply outputs and doesn’t run
* In addition there are individual scripts that call the broken out scripts
with the ```--dry-run``` in progress

## Needs to be done
* Install dev tools
* rvm
* grunt
* gulp
* ruby
* node.js
* bower
* Envoy
* eecli

## References
* Need to have iterm settings as : https://www.dropbox.com/s/hqm2luz4dkj75wu/Screenshot%202015-10-05%2017.36.56.png?dl=0

## Known Issues
* Using nvm to manage node.js versions
* TL;DR run npms.sh twice:
In the nodesh.sh have a command that copies the nvm specific binaries to the usr/local
however that doesn't copy over what is needed for the specific npm libraries
so binaries are created for whatever is in the npm.txt file. Once npm
is in the usr/local can run the npms.sh again to overwrite the previously 
copied over npm binaries. 

