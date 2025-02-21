# dotfiles.git

Based on https://www.amazon.com/Building-Your-Mouseless-Development-Environment/dp/3982423805 book.
but you should still install all those packages and few more manually. lots of `pacman -S xxx`.

```
git clone https://github.com/yassermzh/dotfiles
cd dotfiles
sh install.sh
```

For tmux plugins, make sure to install tpm as described in https://github.com/tmux-plugins/tpm:

```
git clone https://github.com/tmux-plugins/tpm ~/.config/.tmux/plugins/tpm
```

then try `ctrl-s I` to install plugins.

switched to alacritty instead of urxvt. for its themes:

```
mkdir -p ~/.config/alacritty/themes                                                                               λ:main  [  +  ]
git clone https://github.com/alacritty/alacritty-theme ~/.config/alacritty/themes
```
