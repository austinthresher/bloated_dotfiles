[ -e "$HOME/.proxy" ] && source "$HOME/.proxy"
unset -f command_not_found_handle

function norm    { printf "\e[0m"; }
function bold    { printf "\e[1m"; }
function reverse { printf "\e[7m"; }
function under   { printf "\e[4m"; }
function colorfg { printf "\e[3$1m"; }
function colorbg { printf "\e[4$1m"; }

function launch_vi {
	if [ -f "$(which nvim)" ]; then
		$(which nvim) "$@"
	elif [ -f "$(which vim)" ]; then
		$(which vim) "$@"
	elif [ -f "$(which vis)" ]; then
		$(which vis) "$@"
	else
		$(which vi) "$@"
	fi
}

alias ls='ls -F'
alias rgrep='grep -Iirn'
alias more='less'
alias nvim='launch_vi'
alias vim='launch_vi'
alias vi='launch_vi'
alias gdb='gdb -q'
alias preview='feh --scale -d . &'

export PATH=$HOME/.dotfiles/scripts/sh:$HOME/go/bin:$PATH
export EDITOR=vi
export VISUAL=vi
export PAGER=less

PROMPT_COLOR=2
if [ ! -z "$SSH_CLIENT" ]; then
	PROMPT_COLOR=$(expr $PROMPT_COLOR \+ 1)
fi
if [ ! -z "$TMUX" ]; then
	PROMPT_COLOR=$(expr $PROMPT_COLOR \+ 2)
fi
case "$PROMPT_COLOR" in
	0) export TMUX_COLOR=black ;;
	1) export TMUX_COLOR=red ;;
	2) export TMUX_COLOR=green ;;
	3) export TMUX_COLOR=yellow ;;
	4) export TMUX_COLOR=blue ;;
	5) export TMUX_COLOR=magenta ;;
	6) export TMUX_COLOR=cyan ;;
	7) export TMUX_COLOR=white ;;
	*) ;;
esac
export PS1="\[$(reverse)$(colorfg $PROMPT_COLOR)\] \w \[$(norm)\] "
