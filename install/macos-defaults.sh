#!/usr/bin/env bash

echo "Configuring macOS defaults..."

# Dock
echo "  Dock settings"
$dry defaults write com.apple.dock tilesize -int 1
$dry defaults write com.apple.dock autohide -bool true
$dry defaults write com.apple.dock autohide-delay -float 0
$dry defaults write com.apple.dock show-recents -bool false
$dry defaults write com.apple.dock minimize-to-application -bool true

# Keyboard
echo "  Keyboard settings"
# Enable full keyboard access for all controls (tab through dialogs)
$dry defaults write NSGlobalDomain AppleKeyboardUIMode -int 3
# Fast key repeat rate
$dry defaults write NSGlobalDomain KeyRepeat -int 2
# Short delay until key repeat
$dry defaults write NSGlobalDomain InitialKeyRepeat -int 15
# Disable auto-correct
$dry defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
# Disable auto-capitalization
$dry defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false
# Disable smart dashes
$dry defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false
# Disable smart quotes
$dry defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
# Disable period substitution
$dry defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false

# Trackpad
echo "  Trackpad settings"
# Enable tap to click
$dry defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
# Enable three-finger drag
$dry defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool true

# Finder
echo "  Finder settings"
# Show all file extensions
$dry defaults write NSGlobalDomain AppleShowAllExtensions -bool true
# Show path bar
$dry defaults write com.apple.finder ShowPathbar -bool true
# Show status bar
$dry defaults write com.apple.finder ShowStatusBar -bool true
# Default to list view
$dry defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"
# Show hidden files
$dry defaults write com.apple.finder AppleShowAllFiles -bool true
# Disable warning when changing file extension
$dry defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
# Search current folder by default
$dry defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Screenshots
echo "  Screenshot settings"
# Save screenshots to Desktop
$dry defaults write com.apple.screencapture location -string "${HOME}/Desktop"
# Save screenshots as PNG
$dry defaults write com.apple.screencapture type -string "png"
# Disable shadow in screenshots
$dry defaults write com.apple.screencapture disable-shadow -bool true

# Safari
echo "  Safari settings"
# Enable Safari develop menu and web inspector
$dry defaults write com.apple.Safari IncludeDevelopMenu -bool true
$dry defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true

# Activity Monitor
echo "  Activity Monitor settings"
# Show all processes
$dry defaults write com.apple.ActivityMonitor ShowCategory -int 0

# Restart affected apps
echo "  Restarting affected apps"
$dry killall Dock
$dry killall Finder
$dry killall SystemUIServer 2>/dev/null

echo "macOS defaults configured. Some changes may require a logout/restart."
