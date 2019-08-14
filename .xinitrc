#!/bin/bash

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

if [[ $(hostname) = "wednesday" ]]; then
    xrandr --setprovideroutputsource modesetting NVIDIA-0
    xrandr --auto --dpi 220
fi
touchpad=$(xinput list --name-only | grep -i touchpad)
xinput --set-prop "$touchpad" "libinput Natural Scrolling Enabled" 1
xinput --set-prop "$touchpad" "libinput Accel Speed" 1.0
xinput --set-prop "$touchpad" "libinput Tapping Enabled" 1
xbindkeys
pgrep redshift &> /dev/null || redshift -l 40.7128:-74.0060 &> /dev/null &
xset r rate 225 30
compton -b
autorandr --change # this should imply wallpaper setting from autorandr postswitch
exec i3 -V >> ~/log/i3log-$(date +'%F-%k-%M-%S') 2>&1
