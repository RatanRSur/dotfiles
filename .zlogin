xset b off
if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
    if [[ $(hostname) = "wednesday" ]]; then
        export GDK_SCALE=2
        export QT_AUTO_SCREEN_SCALE_FACTOR=1
    fi
    startx
fi
