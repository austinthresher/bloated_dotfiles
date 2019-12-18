#!/bin/bash

require prompt_command_add || return
require set_pane_path || return
require set_pane_title || return
require cwd || cwd() { pwd; }

trap "$PROMPT_COMMAND" WINCH

function tmux_powerline_sep() {
	printf "#[fg=0]$COMMAND_ICON $1"
}

function init_trap() {
	prompt_command_add 'resize'
	if [ ! -z "$TMUX" ]; then
		prompt_command_add 'trap hook_pre debug'
		set_pane_path "$(cwd)"
		set_pane_title "#[fg=0]$COMMAND_ICON "
		PANETITLE=
	fi
}

function hook_post() {
	trap - debug
	if [ -z "$PANETITLE" ]; then
	  set_pane_title "#[fg=0]$COMMAND_ICON "
		sec=
	else
		sec=${SECONDS}s
	  set_pane_title "#[push-default]#[fg=0]$COMMAND_ICON#[default] $PANETITLE "
	fi
	set_pane_path "$(cwd)"
}

function hook_pre() {
	trap - debug
	c=$BASH_COMMAND
	if [[ "$PROMPT_COMMAND" != *"$c"* ]]; then
		PANETITLE="${c%% *}"
	  set_pane_title "#[push-default]#[fg=0]$COMMAND_ICON#[default] #[fg=$TMUX_WHITE]$PANETITLE "
	else
		PANETITLE=""
	  set_pane_title "#[fg=0]$COMMAND_ICON "
	fi
	SECONDS=0
	trap hook_post debug
}
