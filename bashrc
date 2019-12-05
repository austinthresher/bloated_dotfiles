# If the bash in our path is a different version than the one launched, switch to it
# TODO: can we check if the current shell is a login shell and launch accordingly?
[ "$BASH_VERSION" != "$(bash -c 'echo $BASH_VERSION')" ] && exec bash --login

[ -e "$HOME/.proxy" ] && source "$HOME/.proxy"
[ -e "$HOME/.bp/config" ] && source "$HOME/.bp/config"

alias ls='ls -F'
alias grep='grep -n'
alias more='less'
#alias vim='vim -c"set notitle"'
alias vim='kak'
alias kk='kak'
alias gdb='gdb -q'


export PATH=$HOME/.dotfiles/scripts:$PATH

export EDITOR=vim
export VISUAL=vim
export PAGER=less

source colorutils
source set_dark_theme

if [[ $- == *i* ]]
then
	# TODO: Investigate adding other tmux hooks with trap callbacks
	set_window_title() {
		case "$TERM" in
			screen*|tmux*) printf "\ek$1\e\\" ;;
			linux|xterm*|rxvt*) printf "\e]0;$1\007" ;;
			*) ;;
		esac
	}
	export -f set_window_title

	set_pane_title() {
		case "$TERM" in
			tmux*)
				printf "\e]2;$1\e\\"
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
			-e '1s/.*\/\(.*\) .*$/\1/' \
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

	COL=$FG_RED
	[ -z "$SSH_CLIENT" ] && COL=$FG_BLUE

	set_pane_title "$PWD"
	if [ -z "$TMUX" ]; then
		set -o ignoreeof
		export PS1="\[$(color $FG_GREEN)\]\u\[$(color $FG_CYAN)\]@\[$(color $FG_BLUE)\]\h\[$(norm)\]:\w\[$(bold)$(color $COL)\] ➤ \[$(norm)"
		export PROMPT_COMMAND='set_window_title "${USER}@${HOSTNAME%%.*}:${PWD/\/home\/$(whoami)/\~}"; trap "trap_pre" DEBUG; echo -e \a'
	else
		export PS1="\[$(bold)$(color $COL)\]➤ \[$(norm)\]"
 		export PROMPT_COMMAND='trap "trap_pre" DEBUG; echo -e \a'
	fi

	export PS1='$(git_prompt)'"$PS1"

	clear
fi
