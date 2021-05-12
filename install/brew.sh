$dry brew tap Homebrew/bundle
cd ..
$dry brew bundle
cd -

$dry brew services start mysql
$dry brew services start mailhog
$dry brew services start postgresql@10
