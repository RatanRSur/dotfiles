
# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="dieter"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

plugins=(git zsh-syntax-highlighting)

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
####################
# my stuff
#
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f /usr/share/fzf/completion.zsh ] && source /usr/share/fzf/completion.zsh
[ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh

export PATH=~/bin:$PATH

os=`uname -s`
case $os in
    "Darwin" )
        export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
        #color output
        export CLICOLOR=1
        export LSCOLORS=exfxcxdxbxegedabagacad
        #ls aliases
        alias l='ls -GAlFh'
        #brew stuff
        alias brewup="brew update -all && brew upgrade"
        function update {
            brew update -all &&
            brew upgrade &&
            brew cask upgrade &&
            nvim -c 'PlugUpdate | q | q' &&
            tldr --update &&
            julia -e 'Pkg.update(); exit()' &&
            cabal update
        }
        function notify {
            osascript -e 'display notification "" with title "Command Finished"'
        }
        #nasa apod stuff
        [ "$(ls -A ~/Pictures/apod | grep -v DS_store)" ] && echo "You have astronomy pictures for review!"
        #move to trash instead of deleting forever
        if hash trash 2>/dev/null; then
            alias rm='trash'
        fi
        ;;
    "Linux" )
        #ls stuff
        export LS_COLORS=$LS_COLORS:'di=0;36:ow=0;37'
        alias l='ls -AlhF'
        alias c="xsel -ib"
        alias v="xsel -ob"
        export BROWSER="google-chrome-stable %s"
        alias sudo="sudo -E" # preserves caller env
        function del {
            mkdir ~/.trash
            mv "$@" ~/.trash
        }
        ;;
esac
if hash nvim 2>/dev/null; then
    export EDITOR="nvim"
    export VISUAL="nvim"
fi

if hash exa 2>/dev/null; then
    unalias l
    function l {
        grid_option=""
        if [ $(ls -A | wc -l) -gt $(tput lines) ]; then
            grid_option="-G"
        fi
        exa -l -a $grid_option "$@"
    }
fi

BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"
#system independent exports
export FZF_DEFAULT_OPTS='--color 16'
#other aliases
alias n='nvim'
alias e='exit'
alias tmux='tmux -2'
alias rr='rm -r'
alias gs='git status'
alias gl='git log --graph --left-right --format="%Cgreen%h %Cblue%an %Creset%s %Cred%d%Creset"'
function grl {
    gl --color "$@" | head -$(($(stty size | cut -d ' ' -f 1) / 2))
}

backup() {
    for i
    do mv "$i" "$i.backup"
    done
}

restore() {
    for i
    do mv "$i" $(echo "$i" | sed 's/\.backup$//')
    done
}

mkcd()
{
    dir="$*";
    mkdir -p "$dir" && cd "$dir";
}

#function for pdflatex compilation with entr
latexmode()
{
    ls "$1" | entr -c pdflatex --halt-on-error "$1"
}

man() {
    env \
        LESS_TERMCAP_mb=$(printf "\e[1;31m") \
        LESS_TERMCAP_md=$(printf "\e[1;31m") \
        LESS_TERMCAP_me=$(printf "\e[0m") \
        LESS_TERMCAP_se=$(printf "\e[0m") \
        LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
        LESS_TERMCAP_ue=$(printf "\e[0m") \
        LESS_TERMCAP_us=$(printf "\e[1;32m") \
        man "$@"
}

if which tmux >/dev/null 2>&1 && [ -z "$TMUX" ] && [ "$TERM" != "linux" ]; then
    #if not inside a tmux session, and no sessions exist, start a new session
    if tmux list-sessions | grep -v attached > /dev/null; then
        tmux attach
    elif tmux list-sessions | grep dev > /dev/null; then
        tmux new-session
    else
        dev
    fi
fi

