if [[ "$1" == "--dry-run" ]]; then
    dry="echo"
else
    dry=""
fi

# export dry for the other scripts
export dry=$dry


echo "downloading cli and vim items"
sh shell.sh
echo "downloading homebrew and cask apps"
sh apps.sh
echo "cloning my repos"
sh repos.sh
echo "installing node"
sh nodejs.sh
echo "setting up npm global packages"
sh npms.sh
echo "restoring mackup settings"
$dry mackup restore
echo "installing global composer packages"
sh composer.sh
