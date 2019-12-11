[ -e "$HOME/.proxy" ] && source "$HOME/.proxy"
[ -e "$HOME/.bp/config" ] && source "$HOME/.bp/config"

alias ls='ls -F'
alias grep='grep -n'
alias more='less'
alias vim='vim -c"set notitle"'
alias kk='kak'
alias gdb='gdb -q'

# Uncomment to show git branch and status in prompt
#export PS1_GIT=on

export PATH=$HOME/.dotfiles/scripts:$PATH

export EDITOR=vim
export VISUAL=vim
export PAGER=less

source colorutils
source promptutils

if [[ $- == *i* ]]
then
	COL=$FG_RED
	[ -z "$SSH_CLIENT" ] && COL=$FG_BLUE
	export PS1="\[$(bold)$(color $COL)\]➤ \[$(norm)\]"

	#panetitle_esc "$PWD"
	#if [ -z "$TMUX" ]; then
		#set -o ignoreeof
		#export PS1="\[$(color $FG_GREEN)\]\u\[$(color $FG_CYAN)\]@\[$(color $FG_BLUE)\]\h\[$(norm)\]:\w\[$(bold)$(color $COL)\] ➤ \[$(norm)"
		#export PROMPT_COMMAND='set_window_title "${USER}@${HOSTNAME%%.*}:${PWD/\/home\/$(whoami)/\~}"; trap "trap_pre" DEBUG; echo -en "\a"'
	#else
		#export PS1="\[$(bold)$(color $COL)\]➤ \[$(norm)\]"
 		#export PROMPT_COMMAND='trap "trap_pre" DEBUG; echo -en "\a"'
	#fi

	#export PS1='$(git_prompt)'"$PS1"
fi

[ -f "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.bash ] && source "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.bash
