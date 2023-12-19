$dry brew tap Homebrew/bundle
$dry brew tap heroku/brew
cd ..
$dry brew bundle
cd -

$dry brew services start mysql
$dry brew services start mailhog
