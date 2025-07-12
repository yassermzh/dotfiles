#!/bin/bash

theme=$(gsettings get org.gnome.desktop.interface color-scheme)

if [[ "$theme" == "'prefer-dark'" ]]; then
    cp ~/.config/ghostty/config-dark.toml ~/.config/ghostty/config.toml
else
    cp ~/.config/ghostty/config-light.toml ~/.config/ghostty/config.toml
fi

