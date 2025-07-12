#!/usr/bin/env bash
# Read current GTK color-scheme
mode=$(gsettings get org.gnome.desktop.interface color-scheme | tr -d \')
if [ "$mode" = "prefer-light" ]; then
  gsettings set org.gnome.desktop.interface gtk-theme "YourDarkGTK3Theme"
  gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"
  # sed -i 's/color_scheme_path=.*/color_scheme_path="\/path\/to\/Dark.colors"/' ~/.config/qt6ct/qt6ct.conf
  ~/.config/hypr/sync-ghostty-theme.sh
else
  gsettings set org.gnome.desktop.interface gtk-theme "YourLightGTK3Theme"
  gsettings set org.gnome.desktop.interface color-scheme "prefer-light"
  # sed -i 's/color_scheme_path=.*/color_scheme_path="\/path\/to\/Light.colors"/' ~/.config/qt6ct/qt6ct.conf
  ~/.config/hypr/sync-ghostty-theme.sh
fi
