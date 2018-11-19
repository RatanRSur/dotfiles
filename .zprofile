setfont latarcyrheb-sun32 2>/dev/null
if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
    export GDK_SCALE=2
    startx
fi
