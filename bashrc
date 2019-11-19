alias ls='ls --color=auto'
alias grep='grep -n --color=auto'
alias more='less'
alias vim='vim -c"set notitle"'
alias gdb='gdb -q'

export PATH=$HOME/.dotfiles/scripts:$PATH
export LD_LIBRARY_PATH=$HOME/.local/lib:$LD_LIBRARAY_PATH

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

# TODO: Investigate adding other tmux hooks with trap callbacks
set_window_title() {
	case "$TERM" in
		screen*|tmux*) printf "\033k$1\033\\" ;;
		linux|xterm*|rxvt*) printf "\033]0;$1\007" ;;
		*) ;;
	esac
}
export -f set_window_title

set_pane_title() {
	case "$TERM" in
		tmux*)
			printf "\033]2;$1\033\\" 
			set_window_title "${USER}@${HOSTNAME%%.*}"
			;;
		*) ;;
	esac
}
export -f set_pane_title

trap_post() {
	RET=$?
	trap - DEBUG;
	set_pane_title "$PWD ⋅ ${THIS_CMD%% -*} ⋅ $RET"
}

trap_pre() {
	trap - DEBUG;
	THIS_CMD=$BASH_COMMAND;
	PREV_CMD=$THIS_CMD;
	if [ "${THIS_CMD%% *}" != "trap" ]; then
		set_pane_title "$PWD ⋅ ${THIS_CMD%% -*} ⋅ running"
	else
		set_pane_title "$PWD"
	fi
	trap trap_post DEBUG
}

git_branch() {
	git branch 2> /dev/null | sed \
		-e '/^[^*]/d' \
		-e 's/* \(.*\)/\1/'
}

git_repo() {
	git remote -v 2> /dev/null | sed \
		-e '1s/.*\/\(.*\)\.git.*/\1/' \
		-e '2d'
}

git_changes() {
	git status 2> /dev/null | sed \
		-e '/^Changes/!d' \
		-e 's/^Changes not.*$/\-/g' \
		-e 's/^Changes to.*$/\+/g' \
		| tr -d "\n" \
		| sed -e 's/+-/±/'
}

git_prompt() {
	_R=$(git_repo)
	_B=$(git_branch)
	_C=$(git_changes)
	_P=$(printf "%s" $(git_repo)/$(git_branch)$(git_changes))
	if [ "${#_R}" != "0" ]; then
		printf "❰%s/%s%s❱" "$_R" "$_B" "$_C"
	fi
}

set_pane_title "$PWD"
if [ -z "$TMUX" ]; then
	set -o ignoreeof
	export PS1='\033[1;32m\u\033[36m@\033[34m\h\033[0;37m:\w➤ '
	export PROMPT_COMMAND='set_window_title "${USER}@${HOSTNAME%%.*}:${PWD/\/home\/$(whoami)/\~}"; trap "trap_pre" DEBUG'
else
	export PS1='➤ '
	export PROMPT_COMMAND='trap "trap_pre" DEBUG'
fi

export PS1='$(git_prompt)'"$PS1"
