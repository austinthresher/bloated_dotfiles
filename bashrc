alias ls='ls --color=auto'
alias grep='grep -n --color=auto'
alias more='less'

case "$TERM" in
	linux|xterm*|rxvt*)
		export PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/\/home\/$(whoami)/\~}\007"'
		export PS1='\033[1;32m\u\033[36m@\033[34m\h\033[0;37m:\w\$ '
		;;
	screen*|tmux*)
		export PROMPT_COMMAND='echo -ne "\033k${USER}@${HOSTNAME%%.*}:${PWD/\/home\/$(whoami)/\~}\033\\" '
		export PS1='\$ '
		;;
	*)
		;;
esac

LOCALPATH=$HOME/.local/bin
if [[ $LOCALPATH != *"$PATH"* ]]; then
	export PATH=$LOCALPATH:$PATH
fi

export EDITOR=vim
export VISUAL=vim
export PAGER=less

# Color output for manpages
export LESS_TERMCAP_mb=$'\e[1;31m'   # blink
export LESS_TERMCAP_md=$'\e[1;31m'   # bold
export LESS_TERMCAP_me=$'\e[0m'      # turn off bold + blink + underline
export LESS_TERMCAP_so=$'\e[07;34m'  # standout
export LESS_TERMCAP_se=$'\e[0m'      # stop standout
export LESS_TERMCAP_us=$'\e[1;4;32m'   # start underline
export LESS_TERMCAP_ue=$'\e[0m'      # stop underline


