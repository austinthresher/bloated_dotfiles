[ -e "$HOME/.proxy" ] && source "$HOME/.proxy"
[ -e "$HOME/.bpinit" ] && source "$HOME/.bpinit"
unset -f command_not_found_handle

function launch_vim {
	if [ -f "$(which nvim)" ]; then
		$(which nvim) "$@"
	elif [ -f "$(which vim)" ]; then
		$(which vim) "$@"
	else
		$(which vi) "$@"
	fi
}

alias ls='ls -F'
alias rgrep='grep -Iirn'
alias more='less'
alias nvim='launch_vim'
alias vim='launch_vim'
alias vi='launch_vim'
alias gdb='gdb -q'
alias preview='feh --scale -d . &'

# Pass the platform and color support alongside TERM
alias ssh='env TERM="$PLATFORM:$COLORS:$TERM" ssh -t'
alias _ssh='$(which ssh)'

export PATH=$HOME/.dotfiles/scripts/sh:$HOME/go/bin:$PATH
export EDITOR=vi
export VISUAL=vi
export PAGER=less

if [ ! -z "$TMUX" ]; then
	export LD_LIBRARY_PATH=
	export PKG_CONFIG_PATH=
fi

# Some configuration was easier with code generation. Generate those scripts:
mkdir -p $HOME/.generated
awk -f "$HOME/.dotfiles/scripts/awk/tmux-powerline-env.awk" > $HOME/.generated/tmux-powerline-env

function set_term_colors {
	if [ -z "$COLORS" ]; then
		case "$TERM" in
			xterm-kitty)
				export COLORS=24
				export TERM=xterm-256color
				;;
			*256color)
				if [ -z "$VTE_VERSION" ]; then
					export COLORS=256
				else
					export COLORS=24
				fi
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
			if [ -z "$WSL_DISTRO_NAME" ]; then
				export PLATFORM=linux
			else
				export PLATFORM=wsl
			fi
			set_term_colors
			;;
		*)
			export PLATFORM=unknown
			export COLORS=8
			;;
	esac
	export THEME=blue
fi

# Override above detection for WSL
if [ ! -z "$WSL_DISTRO_NAME" ]; then
	export PLATFORM=wsl
fi

if [ -z "$PLATFORM" ]; then
	export PLATFORM=unknown
	export COLORS=0
	export THEME=yellow
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
		load unicode
		load set_title
		if [ ! -z "$TMUX" ]; then
			load trap
			load git
		fi
		;;
	wsl)
		load ascii
		load set_title
		if [ ! -z "$TMUX" ]; then
			load trap
			load git
		fi
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

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
