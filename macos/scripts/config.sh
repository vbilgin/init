#!/usr/bin/env zsh

echo ""
echo "################################################"
echo "Setting macOS config from /macos/scripts/config.sh"
echo "################################################"
echo ""

### Folders and Files ###
mkdir ~/.ssh
touch ~/.ssh/config

mkdir ~/Developer
mkdir ~/Developer/git
mkdir ~/Developer/temp

mkdir ~/Pictures/Screenshots

mkdir ~/Usenet

echo "FILES AND FOLDERS CREATED :)"

### System Settings ###
echo "-- Finder: Show all filename extensions --"
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

echo "-- Finder: Show the ~/Library folder --"
chflags nohidden ~/Library

echo "-- Dock: Enable auto hide and show --"
defaults write com.apple.dock autohide -bool true

echo "-- Finder: Show path bar --"
defaults write com.apple.finder ShowPathbar -bool true

echo "-- Peripherals: Set a fast keyboard repeat rate --"
defaults write NSGlobalDomain KeyRepeat -int 1

echo "-- Menu Bar: Set date and time display --"
defaults write com.apple.menuextra.clock "DateFormat" "EEE MMM d h:mm:ssa"

echo "-- Finder: Hide all desktop icons --"
defaults write com.apple.finder CreateDesktop -bool false

echo "-- Dock: Hide recent apps --"
defaults write com.apple.dock show-recents -bool false

echo "-- General UI: Always show scrollbars --"
defaults write -g AppleShowScrollBars -string "Always"

killall SystemUIServer
killall "Dock"

echo "SYSTEM SETTINGS APPLIED :)"
