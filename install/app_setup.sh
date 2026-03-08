echo "Open apps to configure them correctly"

# BetterSnapTool: enable cmd+shift drag to move, opt+shift drag to resize
echo "Configuring BetterSnapTool"
defaults write com.hegenberg.BetterSnapTool cmdMove -bool true
defaults write com.hegenberg.BetterSnapTool shiftMove -bool true
defaults write com.hegenberg.BetterSnapTool optResize -bool true
defaults write com.hegenberg.BetterSnapTool shiftResize -bool true

open /Applications/RescueTime.app
open /Applications/Next\ Meeting.app
open /Applications/Bartender.app
open /Applications/Postman.app
open /Applications/Superhuman.app
