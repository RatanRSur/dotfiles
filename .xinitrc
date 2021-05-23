#!/bin/bash

userresources=$HOME/.Xresources
sysresources=/etc/X11/xinit/.Xresources

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

nm-applet&
for id in $(xinput list --id-only); do
  xinput --set-prop $id "libinput Natural Scrolling Enabled" 1
  xinput --set-prop $id "libinput Accel Speed" 0.7
  xinput --set-prop $id "libinput Tapping Enabled" 1
done

xbindkeys
keyboard
autorandr --change # this should imply wallpaper setting from autorandr postswitch
wallpaper
clight &
exec i3 -V >> ~/log/i3-$(date -Iseconds).log
#export XDG_SESSION_TYPE=x11
#export GDK_BACKEND=x11
#exec gnome-session
