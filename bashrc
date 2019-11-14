alias gdb='gdb -q'
alias octave='octave-cli'
alias colors='msgcat --color=test'

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
