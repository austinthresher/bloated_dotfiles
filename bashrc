[ -e "$HOME/.proxy" ] && source "$HOME/.proxy"
[ -e "$HOME/.bp/config" ] && source "$HOME/.bp/config"

unset -f command_not_found_handle

alias ls='ls -F'
alias grep='grep -n'
alias more='less'
alias vim='vim -c"set notitle"'
alias kk='kak'
alias gdb='gdb -q'

export PATH=$HOME/.dotfiles/scripts/sh:$PATH
export EDITOR=vim
export VISUAL=vim
export PAGER=less

# Some configuration was easier with code generation. Generate those scripts:
mkdir -p $HOME/.generated
awk -f "$HOME/.dotfiles/scripts/awk/tmux-powerline-env.awk" > $HOME/.generated/tmux-powerline-env

if [ -z "$SSH_CLIENT" ]; then
	case "$OSTYPE" in
		*arwin*)
			export OS="osx"
			export COLORS=256
			;;
		*gnu*)
			export OS="linux"
			export COLORS=24
			;;
		*)
			export OS="unknown"
			export COLORS=8
			;;
	esac
	export THEME="green"
else
	export THEME="red"
fi

if [ -z "$OS" ]; then
	export OS="unknown"
	export COLORS=0
fi

source module.sh

load cwd

case "$COLORS" in
	24) load term-rgb ;;
	256) load term-256color ;;
	8) load term-color ;;
	*) load term-dumb ;;
esac

load theme

case "$OS" in
	osx)
		load ascii
		;;
	linux)
		load unicode 
		load set_title
		load trap
		load git
		;;
	unknown)
		load ascii
		;;
esac

load ip
load tmux
load ps1

if require set_title; then
	set_title $(whoami)@$(hostname)
fi
