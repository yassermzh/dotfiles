urxvtd -o -q -f

xrdb -merge ~/.config/X11/.Xresources
xrdb -merge ~/.config/X11/solarized.theme

udiskie &

#
# keyboard layout and mappings
#
# xmodmap ~/.config/X11/.Xmodmap
setxkbmap -layout us,ir -option grp:alt_shift_toggle 
setxkbmap -option 'caps:ctrl_modifier'
xcape -e 'Caps_Lock=Escape'
xmodmap -e "keysym Menu = Super_R"
#xmodmap -e "keysym backslash = Return"
#xmodmap -e "keysym less = backslash"

libinput-gestures-setup start
#exec --no-startup-id "libinput-gestures-setup start"

exec i3


