#!/bin/bash

echo "Creating an SSH key for you..."
ssh-keygen -t ed25519 -C "connorlukegoddard@gmail.com" -N "" -f ~/.ssh/id_rsa

echo "Here is your new public SSH key..."
cat ~/.ssh/id_rsa.pub

echo "Please add this public key to Github \n"
echo "https://github.com/account/ssh \n"
read -p "Press [Enter] key after this..."

echo "Installing Xcode dev tools..."
xcode-select --install

# Check for Homebrew,
# Install if we don't have it
if test ! $(which brew); then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

# Update Homebrew recipes
echo "Updating Homebrew..."
brew update

read -p "Press [Enter] key after this..."

echo "Installing Git..."
brew install git

echo "Git config"

git config --global user.name "Connor Goddard"
git config --global user.email connorlukegoddard@gmail.com

echo "Installing brew git utilities..."
brew install git-extras
brew install legit
brew install git-flow

echo "Installing other brew stuff..."
brew install tree
brew install wget
brew install trash
brew install node
#brew install svn
#brew install mackup

echo "Cleaning up Homebrew"
brew cleanup

echo "Installing Homebrew cask"
brew install homebrew/cask

#Install Zsh & Oh My Zsh
echo "Installing Oh My ZSH..."
curl -L http://install.ohmyz.sh | sh

echo "Setting up Zsh plugins..."
cd ~/.oh-my-zsh/custom/plugins
git clone git://github.com/zsh-users/zsh-syntax-highlighting.git

echo "Setting ZSH as shell..."
chsh -s /bin/zsh

# Apps
apps=(
  alfred
  hyper
  brave-browser
  spotify
  surfshark
  zoom
  lastpass
  qlmarkdown
  qlstephen
  suspicious-package
  visual-studio-code
)

# Install apps to /Applications
# Default is: /Users/$user/Applications
echo "Installing apps with Homebrew Cask..."
brew install --cask --appdir="/Applications" ${apps[@]}			

brew cleanup

echo "Setting some Mac settings..."
read -p "Press [Enter] key after this..."

#"Setting computer name..."
scutil --set ComputerName "Brosnan"
scutil --set LocalHostName "Brosnan"
scutil --set HostName "Brosnan"

#"Disabling system-wide resume"
defaults write NSGlobalDomain NSQuitAlwaysKeepsWindows -bool false

#"Disabling automatic termination of inactive apps"
defaults write NSGlobalDomain NSDisableAutomaticTermination -bool true

#"Allow text selection in Quick Look"
defaults write com.apple.finder QLEnableTextSelection -bool TRUE

#"Disabling OS X Gate Keeper"
#"(You'll be able to install any app you want from here on, not just Mac App Store apps)"
sudo spctl --master-disable
sudo defaults write /var/db/SystemPolicy-prefs.plist enabled -string no
defaults write com.apple.LaunchServices LSQuarantine -bool false

#"Expanding the save panel by default"
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

#"Automatically quit printer app once the print jobs complete"
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

#"Saving to disk (not to iCloud) by default"
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

#"Check for software updates daily, not just once per week"
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

#"Disable smart quotes and smart dashes as they are annoying when typing code"
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

#"Enabling subpixel font rendering on non-Apple LCDs"
defaults write NSGlobalDomain AppleFontSmoothing -int 2

#"Showing icons for hard drives, servers, and removable media on the desktop"
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true

#"Showing all filename extensions in Finder by default"
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

#"Disabling the warning when changing a file extension"
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

#"Use column view in all Finder windows by default"
defaults write com.apple.finder FXPreferredViewStyle Clmv

#"Avoiding the creation of .DS_Store files on network volumes"
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

#"Enabling snap-to-grid for icons on the desktop and in other icon views"
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist

#"Setting the icon size of Dock items to 36 pixels for optimal size/screen-realestate"
defaults write com.apple.dock tilesize -int 36

#"Speeding up Mission Control animations and grouping windows by application"
defaults write com.apple.dock expose-animation-duration -float 0.1
defaults write com.apple.dock "expose-group-by-app" -bool true

#"Setting email addresses to copy as 'foo@example.com' instead of 'Foo Bar <foo@example.com>' in Mail.app"
defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false

#"Enabling UTF-8 ONLY in Terminal.app and setting the Pro theme by default"
defaults write com.apple.terminal StringEncodings -array 4
defaults write com.apple.Terminal "Default Window Settings" -string "Pro"
defaults write com.apple.Terminal "Startup Window Settings" -string "Pro"

#"Preventing Time Machine from prompting to use new hard drives as backup volume"
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

#"Disable the sudden motion sensor as its not useful for SSDs"
sudo pmset -a sms 0

#"Speeding up wake from sleep to 24 hours from an hour"
# http://www.cultofmac.com/221392/quick-hack-speeds-up-retina-macbooks-wake-from-sleep-os-x-tips/
sudo pmset -a standbydelay 86400

#"Setting screenshots location to ~/Desktop"
defaults write com.apple.screencapture location -string "$HOME/Desktop"

#"Setting screenshot format to PNG"
defaults write com.apple.screencapture type -string "png"

#"Hiding Safari's bookmarks bar by default"
defaults write com.apple.Safari ShowFavoritesBar -bool false

#"Hiding Safari's sidebar in Top Sites"
defaults write com.apple.Safari ShowSidebarInTopSites -bool false

#"Disabling Safari's thumbnail cache for History and Top Sites"
defaults write com.apple.Safari DebugSnapshotsUpdatePolicy -int 2

#"Enabling Safari's debug menu"
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true

#"Making Safari's search banners default to Contains instead of Starts With"
defaults write com.apple.Safari FindOnPageMatchesWordStartsOnly -bool false

#"Removing useless icons from Safari's bookmarks bar"
defaults write com.apple.Safari ProxiesInBookmarksBar "()"

#"Allow hitting the Backspace key to go to the previous page in history"
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2BackspaceKeyNavigationEnabled -bool true

#"Enabling the Develop menu and the Web Inspector in Safari"
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari "com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled" -bool true

#"Adding a context menu item for showing the Web Inspector in web views"
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

defaults write com.apple.dock persistent-apps -array-add '<dict>
<key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString
</key><string>/Applications/Brave.app</string><key>_CFURLStringType
</key><integer>0</integer></dict></dict></dict>'

#"Adding volume and Bluetooth icons to menu bar"
defaults write ~/Library/Preferences/ByHost/com.apple.controlcenter.plist Bluetooth -int 18
defaults write ~/Library/Preferences/ByHost/com.apple.controlcenter.plist Sound -int 18

killall dock

killall Finder

echo "Done!"

#@TODO install vagrant and sites folder

defaults write com.apple.systemuiserver menuExtras -array "/System/Library/CoreServices/Menu Extras/Bluetooth.menu"

