#!/usr/bin/env bash
#
# macOS system preferences as code. Only settings changed from a stock install
# are listed, so every line here is an intentional choice. Safe to re-run after
# a macOS upgrade resets something.
#
# Discover a new key: `defaults read > before`, change the setting in
# System Settings, `defaults read > after`, then `diff before after`.

set -euo pipefail

[[ $OSTYPE == darwin* ]] || exit 0

# Menu bar & appearance
# ------------------------------------------------------------------------------
defaults write NSGlobalDomain _HIHideMenuBar -bool true
defaults write NSGlobalDomain AppleMenuBarVisibleInFullscreen -bool false
defaults write com.apple.controlcenter AutoHideMenuBarOption -int 0
defaults write com.apple.controlcenter "NSStatusItem VisibleCC Sound" -bool true

# Menu bar clock: weekday, date and seconds
defaults write com.apple.menuextra.clock ShowDayOfWeek -bool true
defaults write com.apple.menuextra.clock ShowDate -int 1
defaults write com.apple.menuextra.clock ShowSeconds -bool true
defaults write com.apple.menuextra.clock ShowAMPM -bool true

# Dock
# ------------------------------------------------------------------------------
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock orientation -string "left"
defaults write com.apple.dock tilesize -int 69
defaults write com.apple.dock magnification -bool false
defaults write com.apple.dock show-recents -bool false
defaults write com.apple.dock minimize-to-application -bool false
# Bottom-right hot corner disabled (stock is Quick Note)
defaults write com.apple.dock wvous-br-corner -int 1

# Windows: no tiling by edge drag, no margins, no option-key tiling accelerator
# ------------------------------------------------------------------------------
defaults write com.apple.WindowManager EnableTilingByEdgeDrag -bool false
defaults write com.apple.WindowManager EnableTopTilingByEdgeDrag -bool false
defaults write com.apple.WindowManager EnableTilingOptionAccelerator -bool false
defaults write com.apple.WindowManager EnableTiledWindowMargins -bool false
defaults write NSGlobalDomain AppleActionOnDoubleClick -string "None"
defaults write NSGlobalDomain AppleMiniaturizeOnDoubleClick -bool false

# Finder
# ------------------------------------------------------------------------------
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
defaults write com.apple.finder NewWindowTarget -string "PfHm"
defaults write com.apple.finder FXPreferredViewStyle -string "icnv"
defaults write com.apple.finder ShowSidebar -bool true
defaults write NSGlobalDomain com.apple.springing.enabled -bool true
defaults write NSGlobalDomain com.apple.springing.delay -float 0.5

# Keyboard & text input
# ------------------------------------------------------------------------------
# F1-F12 act as media keys; hold fn for function keys
defaults write NSGlobalDomain com.apple.keyboard.fnState -bool false
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticInlinePredictionEnabled -bool false

# Trackpad & mouse
# ------------------------------------------------------------------------------
defaults write NSGlobalDomain com.apple.trackpad.forceClick -bool true
defaults write NSGlobalDomain AppleEnableSwipeNavigateWithScrolls -bool false

# Screenshots: copy to clipboard and show pointer clicks in recordings
# ------------------------------------------------------------------------------
defaults write com.apple.screencapture target -string "clipboard"
defaults write com.apple.screencapture showsClicks -bool true

# System keyboard shortcuts live in a nested plist that `defaults write` handles
# poorly, so they are restored from the exported file instead. The export has
# Dock "turn hiding on/off" (cmd+opt+D, id 52) disabled.
# ------------------------------------------------------------------------------
settings_path="${DOTFILES_PATH:-$HOME/.dotfiles}/os/mac/settings"
for domain in com.apple.symbolichotkeys com.raycast.macos; do
	plist="$settings_path/$domain.plist"
	[[ -f $plist ]] && defaults import "$domain" "$plist"
done

# Apply
# ------------------------------------------------------------------------------
for app in Dock Finder SystemUIServer ControlCenter; do
	killall "$app" >/dev/null 2>&1 || true
done
/System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u >/dev/null 2>&1 || true

echo "macOS defaults applied"
