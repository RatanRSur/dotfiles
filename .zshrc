
# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
DISABLE_UPDATE_PROMPT=true
ZSH_THEME="ratan"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

plugins=(git)

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
export PATH=~/.cargo/bin:$PATH
export PATH=~/.local/bin:$PATH
export GOPATH=~/go

os=`uname -s`
case $os in
    "Darwin" )
        ;;
    "Linux" )
        #ls stuff
        export LS_COLORS=$LS_COLORS:'di=0;36:ow=0;37'
        alias l='ls -AlhF'
        alias c="xsel -b --input"
        alias v="xsel -b"
        export BROWSER="google-chrome-stable"
        alias sudo="sudo --preserve-env" # preserves caller env
        function del {
            trash-put "$@"
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
        if [ $(ls --almost-all "$@" | wc --lines) -gt $(tput lines) ]; then
            grid_option="--grid"
        fi
        exa --group --long --all $grid_option "$@"
    }
    function tree {
        exa --tree "$@"
    }
fi

alias cat='bat --theme=base16-tomorrow-night'

if [ "$TERM" != "linux" ]; then
    BASE16_SHELL=$HOME/.config/base16-shell/
    [ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"
fi

export FZF_DEFAULT_OPTS='--color 16'

alias n='nvim'
alias tmux='tmux -2'
alias rr='rm -r'
alias gs='git status'
alias gl='git log --graph --left-right --format="%Cgreen%h %Cblue%an %Creset%s %Cred%d%Creset"'
alias git=hub
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
    mkdir --parents "$dir" && cd "$dir";
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

if which tmux &>/dev/null && [ -z "$TMUX" ] && [ "$TERM" != "linux" ]; then
    # start control session
    if ! tmux list-sessions 2> /dev/null | grep control &> /dev/null; then
        cd ~
        tmux new-session -d -n "dotfiles" -s control
        tmux send-keys "cd dotfiles; nvim .config/nvim/init.vim" Enter
        tmux split-window -h -c "dotfiles"
        tmux send-keys "git status" Enter
        tmux select-pane -t {left}
        tmux new-window -n stf -c "stf"
        tmux -2 attach-session -d
    elif tmux list-sessions | grep -v attached &> /dev/null; then
        echo "Attach to unattached session? [y/N]"
        if read -q; then
            tmux attach control || tmux attach
        fi
    fi
fi
