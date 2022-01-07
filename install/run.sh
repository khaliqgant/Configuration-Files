if [[ "$1" == "--dry-run" ]]; then
    dry="echo"
else
    dry=""
fi

# export dry for the other scripts
export dry=$dry


echo "copying iterm fonts"
$dry cp -R iterm/fonts/source-code-pro-1.017R/* /Library/Fonts/

echo "copying over terminal setting"
$dry open ./terminal/profiles/dev.terminal
$dry defaults write com.apple.terminal "Default Window Settings" "dev"

cd install
echo "downloading cli and vim items"
sh shell.sh
echo "setting vim settings"
sh vim.sh
echo "setting up ruby setup"
sh rvm-setup.sh
echo "downloading homebrew and cask apps"
sh apps.sh
echo "cloning my repos"
sh repos.sh
echo "setting up npm global packages"
sh npms.sh
echo "restoring mackup settings"
$dry mackup restore
echo "installing global composer packages"
sh composer.sh
echo "setting up python using pyenv"
sh python-setup.sh
echo "installing pips"
sh pip.sh
echo "starting mysql"
sh mysql.sh
echo "setup installed apps"
sh app_setup.sh
