[ -e "$HOME/.proxy" ] && source "$HOME/.proxy"
[ -e "$HOME/.backpack/config" ] && source "$HOME/.backpack/config"
[ -d "/home/linuxbrew/.linuxbrew/bin" ] && export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
[ -d "/Users/homebrew/.homebrew/bin" ] && export PATH="/home/homebrew/.homebrew/bin:$PATH"

unset -f command_not_found_handle

if [ "$TERM" == xterm -a ! -z "$VTE_VERSION" ]; then
	export TERM=xterm-256color
fi

alias ls='ls -F'
alias grep='grep -n'
alias more='less'
alias vim='nvim -c"set notitle"'
alias kk='kak'
alias gdb='gdb -q'
# Pass the host OS and color support alongside TERM
alias ssh='env TERM="$PLATFORM:$COLORS:$TERM" ssh -t'

export PATH=$HOME/.dotfiles/scripts/sh:$PATH
export EDITOR=vi
export VISUAL=vi
export PAGER=less

# Some configuration was easier with code generation. Generate those scripts:
mkdir -p $HOME/.generated
awk -f "$HOME/.dotfiles/scripts/awk/tmux-powerline-env.awk" > $HOME/.generated/tmux-powerline-env

function set_term_colors {
	if [ -z "$COLORS" ]; then
		case "$TERM" in
			xterm-kitty)
				export COLORS=24
				;;
			*256color)
				export COLORS=256
				;;
			*)
				export COLORS=8
				;;
		esac
	fi
}

if [[ "$TERM" == *":"* ]]; then
	export THEME="red"
	PLATFORM_COLORS=${TERM%:*}
	export PLATFORM=${PLATFORM_COLORS%:*}
	export COLORS=${PLATFORM_COLORS#*:}
	export TERM=${TERM##*:}
elif [ -z "$PLATFORM" ]; then
	case "$OSTYPE" in
		*arwin*)
			export PLATFORM=osx
			set_term_colors
			;;
		*gnu*)
			export PLATFORM=linux
			set_term_colors
			;;
		*)
			export PLATFORM=unknown
			export COLORS=8
			;;
	esac
	export THEME=green
fi

if [ -z "$PLATFORM" ]; then
	export PLATFORM=unknown
	export COLORS=0
	export THEME=blue
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

case "$PLATFORM" in
	osx)
		load ascii
		;;
	linux)
		load ascii #unicode
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
