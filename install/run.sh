if [[ "$1" == "--dry-run" ]]; then
    dry="echo"
else
    dry=""
fi

# export dry for the other scripts
export dry=$dry


echo "copying iterm fonts"
$dry cp iterm/fonts/source-code-pro-1.017R/* /Library/Fonts/

cd install
echo "downloading cli and vim items"
sh shell.sh
echo "setting vim settings"
sh vim.sh
echo "setting up php setup"
sh php-setup.sh
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
echo "installing pips"
sh pip.sh
