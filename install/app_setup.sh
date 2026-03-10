echo "Open apps to configure them correctly"

# BetterSnapTool: import full plist (individual defaults write keys get
# overwritten by BSTAppSettings blob, so we import the whole file instead)
echo "Configuring BetterSnapTool"
cp ../resources/BetterSnapTool.plist ~/Library/Preferences/com.hegenberg.BetterSnapTool.plist

open /Applications/RescueTime.app
open /Applications/Next\ Meeting.app
open /Applications/Bartender.app
open /Applications/Postman.app
open /Applications/Superhuman.app
