#!/bin/bash
########
# nvim #
########
mkdir -p "$HOME/.config/nvim"
mkdir -p "$HOME/.config/nvim/undo"
ln -sf "$HOME/dotfiles/nvim/init.vim" "$HOME/.config/nvim/init.vim"

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
mkdir -p "$XDG_CONFIG_HOME/tmux"
ln -sf "$DOTFILES/tmux/tmux.conf" "$XDG_CONFIG_HOME/tmux/tmux.conf"


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
