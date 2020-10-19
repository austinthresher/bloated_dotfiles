# The first part of this file runs both interactively and non-interactively
# =========================================================================

[ -e "$HOME/.bashrc_local" ] && source "$HOME/.bashrc_local"
unset -f command_not_found_handle
export HISTCONTROL=ignoreboth:erasedups

if [ ! -z "$WSL_DISTRO_NAME" -o "${OSTYPE}" == cygwin ]; then
    export WINDOWS=1
    # If we're on WSL, assume there's an X server running
    if [ -z "$DISPLAY" ]; then
        export DISPLAY=0:0
    fi
fi

if command -v mdvl &> /dev/null; then
    alias md='mdvl'
fi

export EDITOR=vi
export VISUAL=vi
export PAGER=less
export PATH="$PATH:$HOME/.dotfiles/scripts"
export SCREENDIR="$HOME/.screen"
[ ! -d "$SCREENDIR" ] && mkdir "$SCREENDIR" && chmod 700 "$SCREENDIR"

# The rest of this file is skipped if not running interactively
# =============================================================

case $- in
    *i*) ;; # Interactive session
    *) return ;; # Non interactive
esac


# Ignore legacy scroll lock on <C-S> and <C-Q>
stty -ixon

alias rgrep='grep -Iirn'
alias more='less'
alias gdb='gdb -q'
alias preview='feh --scale -d . &'

if [[ $OSTYPE == *darwin* ]]; then
    alias ls='ls -F'
    export BASH_SILENCE_DEPRECATION_WARNING=1
else
    alias ls='ls -F --color=auto'
fi

if command -v vim &> /dev/null; then
    alias vi='vim -u ~/.virc'
fi
alias tmux='tmux -u'

source venv
source promptcolor
