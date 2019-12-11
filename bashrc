[ -e "$HOME/.proxy" ] && source "$HOME/.proxy"
[ -e "$HOME/.bp/config" ] && source "$HOME/.bp/config"

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
prompt_add 'printf $(under)$(color $FG_DARK_GRAY)'
prompt_add 'rprint $(color $FG_DARK_GRAY)$(date +%H:%M:%S)'
prompt_add 'echo $(whoami)@$(hostname):$(italic)$PWD$(norm)'
[ ! -z "$TMUX" ] && prompt_tmux
