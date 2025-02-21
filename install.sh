#!/bin/bash
########
# nvim #
########
rm -rf "$HOME/.config/nvim"
ln -s "$HOME/dotfiles/nvim" "$HOME/.config"

rm -rf "$HOME/.config/alacritty"
ln -s "$HOME/dotfiles/alacritty" "$HOME/.config"

rm -rf "$HOME/.config/kmonad"
ln -s "$HOME/dotfiles/kmonad" "$HOME/.config"

rm -rf "$HOME/.config/X11"
ln -s "$HOME/dotfiles/X11" "$HOME/.config"

mkdir -p "$HOME/.config/zsh"
ln -sf "$HOME/dotfiles/zsh/.zshenv" "$HOME"
ln -sf "$HOME/dotfiles/zsh/.zshrc" "$HOME/.config/zsh/.zshrc"
ln -sf "$HOME/dotfiles/zsh/aliases" "$HOME/.config/zsh/aliases"
ln -sf "$HOME/dotfiles/zsh/external" "$HOME/.config/zsh/external"

########
# tmux #
########
# mkdir -p "$XDG_CONFIG_HOME/tmux"
rm -rf "$HOME/.config/tmux"
# ln -sf "$DOTFILES/tmux/tmux.conf" "$XDG_CONFIG_HOME/tmux/tmux.conf"
ln -s "$HOME/dotfiles/tmux" "$HOME/.config"


######
# i3 #
######
rm -rf "$XDG_CONFIG_HOME/i3"
ln -s "$DOTFILES/i3" "$XDG_CONFIG_HOME"

# dunst #
mkdir -p "$XDG_CONFIG_HOME/dunst"
ln -sf "$DOTFILES/dunst/dunstrc" "$XDG_CONFIG_HOME/dunst/dunstrc"


# gestures
cp "$DOTFILES/libinput-gestures.conf" "$XDG_CONFIG_HOME"

# lf
ln -sf "$DOTFILES/lf" "$XDG_CONFIG_HOME"

# default apps
cp "$DOTFILES/mimeapps.list" "$XDG_CONFIG_HOME"

######### # Fonts # #########
mkdir -p "$XDG_DATA_HOME"
cp -rf "$DOTFILES/fonts" "$XDG_DATA_HOME"

