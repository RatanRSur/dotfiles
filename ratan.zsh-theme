# local time, color coded by last return code
time_enabled="%(?.%{$fg[green]%}.%{$fg[red]%})%*%{$reset_color%}"
time_disabled="%{$fg[green]%}%*%{$reset_color%}"
time=$time_enabled

# user part, color coded by privileges
local user="%(!.%{$fg[blue]%}.%{$fg[blue]%})%n%{$reset_color%}"

# Hostname part.  compressed and colorcoded per host_repr array
# if not found, regular hostname in default color
local host="${host_repr[$HOST]:-$HOST}%{$reset_color%}"

# Compacted $PWD
local pwd="%{$fg[blue]%}%~%{$reset_color%}"

function sexy_git_prompt() {

    git remote 2>/dev/null | grep upstream > /dev/null
    if [ $? -eq 0 ]; then
        remote=upstream
    else
        remote=origin
    fi

    if [[ -n "$(command git rev-list HEAD..$remote/master 2>/dev/null)" ]]
    then
        ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[red]%}"
    else
        ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[yellow]%}"
    fi

    if [[ $(git diff-index --name-only HEAD 2>/dev/null) ]]; then
        ZSH_THEME_GIT_PROMPT_DIRTY=" ※%{$reset_color%}"
    else
        ZSH_THEME_GIT_PROMPT_DIRTY=" ⁘%{$reset_color%}"
    fi
    git_prompt_info
}

PROMPT=' ${pwd} $(sexy_git_prompt)'
if [ "$SSH_CONNECTION" ]; then
    PROMPT="${user}@$HOST$PROMPT"
fi

# i would prefer 1 icon that shows the "most drastic" deviation from HEAD,
# but lets see how this works out
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[yellow]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%}"

# elaborate exitcode on the right when >0
return_code_right="%(?.%{$fg[green]%}.%{$fg[red]%})%? ↵%{$reset_color%}"
return_code_left="%(?.. %{$fg[red]%}%?%{$reset_color%})"

PROMPT="${return_code_left}$PROMPT"
#RPS1='${return_code}'

function accept-line-or-clear-warning () {
	if [[ -z $BUFFER ]]; then
		time=$time_disabled
		return_code=$return_code_disabled
	else
		time=$time_enabled
		return_code=$return_code_enabled
	fi
	zle accept-line
}
zle -N accept-line-or-clear-warning
bindkey '^M' accept-line-or-clear-warning
