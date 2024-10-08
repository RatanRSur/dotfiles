
bindkey -v
# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
DISABLE_UPDATE_PROMPT=true
ZSH_THEME="ratan"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

plugins=(git)

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
setopt CD_SILENT
setopt PUSHD_IGNORE_DUPS

setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export HISTSIZE=500000
export SAVEHIST=$HISTSIZE
export PATH=~/bin:$PATH
export PATH=~/.cargo/bin:$PATH
export PATH=~/.local/bin:$PATH
export PATH=~/.gem/ruby/2.7.0/bin:$PATH
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

export EDITOR="vim"
if hash nvim 2>/dev/null; then
    export EDITOR="nvim"
fi
export VISUAL=$EDITOR

if hash eza 2>/dev/null; then
    unalias l
    function l {
        grid_option=""
        if [ $(ls -A "$@" | wc -l) -gt $(tput lines) ]; then
            grid_option="--grid"
        fi
        eza --group --long --all $grid_option "$@"
    }
    function tree {
        eza --tree "$@"
    }
fi

export BAT_THEME="base16-tomorrow-night"
alias cat='bat --plain --pager=never'

if [ "$TERM" != "linux" ]; then
    BASE16_SHELL=$HOME/.config/base16-shell/
    [ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"
fi

export FZF_DEFAULT_OPTS='--color 16'

alias n='nvim'
alias gs='git status'

unalias gl
alias gd='git diff -w'

function gl {
  graph_option="--graph"
  if [ "$(basename $(pwd))" = "linux" ]; then
    graph_option=""
  fi
  git log $graph_option --left-right --format="%Cgreen%h %Creset%s %Cblue%aN %Cred%d%Creset" "$@"
}

function grl {
    gl --color "$@" -n $(($(stty size | cut -d ' ' -f 1) / 3)) | /bin/cat
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


export MANPAGER="sh -c 'col -bx | bat -l man -p'"

if which tmux &>/dev/null && [ -z "$TMUX" ] && [ "$TERM" != "linux" ]; then
    # start control session
    if ! tmux list-sessions 2> /dev/null | grep control &> /dev/null; then
        cd ~
        tmux new-session -d -n "dotfiles" -s control
        tmux send-keys "cd dotfiles; nvim .config/nvim/init.vim" Enter
        tmux split-window -h -c "dotfiles"
        tmux send-keys "git status" Enter
        tmux select-pane -t {left}
        tmux attach-session -d
      else
        sessions=$(tmux list-sessions | grep -v attached)
        if [ $? -eq 0 ]; then
            tmux attach -t "$(echo "$sessions" | cut -d ':' -f 1 | fzf --layout=reverse --prompt='Attach to session: ')"
        fi
    fi
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
eval "$(starship init zsh)"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/homebrew/Caskroom/miniconda/base/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh" ]; then
        . "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh"
    else
        export PATH="/opt/homebrew/Caskroom/miniconda/base/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

