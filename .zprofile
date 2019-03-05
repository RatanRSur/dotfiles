xset b off
export PATH="$HOME/.cargo/bin:$PATH"
if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
    if [[ $(hostname) = "wednesday" ]]; then
        export GDK_SCALE=2
    fi
    startx
fi
