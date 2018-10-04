#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

xrandr --auto --dpi 220
xbindkeys
pgrep redshift &> /dev/null || redshift -l 40.7128:-74.0060 &> /dev/null &
wallpaper
xset r rate 300 30
xinput --set-prop "ETPS/2 Elantech Touchpad" "libinput Natural Scrolling Enabled" 1
xinput --set-prop "ETPS/2 Elantech Touchpad" "libinput Accel Speed" 1.0
xinput --set-prop 'ETPS/2 Elantech Touchpad' 'libinput Tapping Enabled' 1
exec i3 -V >> ~/log/i3log-$(date +'%F-%k-%M-%S') 2>&1
