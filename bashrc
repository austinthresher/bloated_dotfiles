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

source module.sh

load cwd
case "$OSTYPE" in
	*arwin*) # OSX
		function sed_i() { sed -i '.bak' "$@"; }
		export -f sed_i
		load term-color
		load ascii
		;;
	*gnu*) # Linux
		function sed_i() { sed -i "$@"; }
		export -f sed_i
		case "$TERM" in
			*256color)
				load term-rgb
				;;
			*)
				load term-color
				;;
		esac
		load unicode 
		load set_title
		load trap
		;;
	*)
		load term-dumb
		load ascii
		;;
esac

load ip
load tmux
load ps1

if require set_title; then
	set_title $(whoami)@$(hostname)
fi
