#!/bin/bash

require prompt_command_add || return
require set_pane_path || return
require set_pane_title || return
require cwd || cwd() { pwd; }

trap "$PROMPT_COMMAND" WINCH

function tmux_powerline_sep() {
	printf "#[fg=7]"
	printf " $1 "
}

function init_trap() {
	prompt_command_add 'resize'
	if [ ! -z "$TMUX" ]; then
		prompt_command_add 'trap hook_pre debug'
		set_pane_path "$(cwd)"
		set_pane_title " $(tmux_powerline_sep '')"
		PANETITLE=
	fi
}

function hook_post() {
	trap - debug
	if [ -z "$PANETITLE" ]; then
		sec=
	else
		sec=${SECONDS}s
	fi
	set_pane_title "$PANETITLE $(tmux_powerline_sep $sec)"
	set_pane_path "$(cwd)"
}

function hook_pre() {
	trap - debug
	c=$BASH_COMMAND
	if [[ "$PROMPT_COMMAND" != *"$c"* ]]; then
		PANETITLE="${c%% *}"
	else
		PANETITLE=""
	fi
	set_pane_title "$PANETITLE $(tmux_powerline_sep $RUNNING_ICON)"
	SECONDS=0
	trap hook_post debug
}
