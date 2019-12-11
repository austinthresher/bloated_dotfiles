[ -e "$HOME/.proxy" ] && source "$HOME/.proxy"
[ -e "$HOME/.bp/config" ] && source "$HOME/.bp/config"

unset -f command_not_found_handle

alias ls='ls -F'
alias grep='grep -n'
alias more='less'
alias vim='vim -c"set notitle"'
alias kk='kak'
alias gdb='gdb -q'

export PATH=$HOME/.dotfiles/scripts:$PATH
export EDITOR=vim
export VISUAL=vim
export PAGER=less

source colorutils
source promptutils

[ -z "$SSH_CLIENT" ] && COL=$FG_BLUE || COL=$FG_RED
export PS1="\[$(bold)$(color $COL)\]➤ \[$(norm)\]"
prompt_clear
prompt_add 'rprint $(color $FG_DARK_GRAY)$(date +%H:%M:%S)$(norm)'
prompt_add 'win_title $(whoami)@$(hostname)'
[ ! -z "$TMUX" ] && prompt_tmux
