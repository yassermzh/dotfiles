urxvtd -o -q -f
xrdb -merge ~/.config/X11/.Xresources
xrdb -merge ~/.config/X11/solarized.theme
udiskie &
#xmodmap ~/.config/X11/.Xmodmap

setxkbmap -layout us,ir -option grp:alt_shift_toggle 
setxkbmap -option 'caps:ctrl_modifier';xcape -e 'Caps_Lock=Escape'&
exec i3


