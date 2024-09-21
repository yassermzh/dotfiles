#!/bin/bash
########
# nvim #
########
rm -rf "$HOME/.config/nvim"
ln -sf "$HOME/dotfiles/nvim" "$HOME/.config/nvim"

rm -rf "$HOME/.config/alacritty"
ln -sf "$HOME/dotfiles/alacritty" "$HOME/.config/alacritty"

rm -rf "$HOME/.config/kmonad"
ln -sf "$HOME/dotfiles/kmonad" "$HOME/.config/kmonad"

rm -rf "$HOME/.config/X11"
ln -s "$HOME/dotfiles/X11" "$HOME/.config"

mkdir -p "$HOME/.config/zsh"
ln -sf "$HOME/dotfiles/zsh/.zshenv" "$HOME"
ln -sf "$HOME/dotfiles/zsh/.zshrc" "$HOME/.config/zsh"
ln -sf "$HOME/dotfiles/zsh/aliases" "$HOME/.config/zsh/aliases"
rm -rf "$HOME/.config/zsh/external"
ln -sf "$HOME/dotfiles/zsh/external" "$HOME/.config/zsh"

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
