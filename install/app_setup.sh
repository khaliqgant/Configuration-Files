echo "Open apps to configure them correctly"

# BetterSnapTool: import full plist (individual defaults write keys get
# overwritten by BSTAppSettings blob, so we import the whole file instead)
echo "Configuring BetterSnapTool"
cp ../resources/BetterSnapTool.plist ~/Library/Preferences/com.hegenberg.BetterSnapTool.plist

# Bartender installs as "Bartender <major>.app", so the glob after the quoted
# name matches any version. Apps that aren't installed (e.g. Next Meeting, a
# manual Mac App Store install) are skipped with a note instead of erroring.
for name in "RescueTime" "Next Meeting" "Bartender" "Postman" "Superhuman"; do
    found=0
    for app in /Applications/"$name"*.app; do
        if [ -d "$app" ]; then
            $dry open "$app"
            found=1
        fi
    done
    [ "$found" -eq 0 ] && echo "skipping $name: not installed"
done
