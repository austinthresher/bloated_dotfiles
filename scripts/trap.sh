#!/bin/bash

require prompt_command_add || return
require set_pane_path || return
require set_pane_title || return

function tmux_powerline_sep() {
	# TODO: Instead of syncing these by hand, set them where
	# both bashrc and tmux can read them
	local BG1=colour0
	local BG2=colour8
	local FG2=colour15
	printf "#[bg=$BG2 fg=$BG1]\ue0b0#[bg=$BG2 fg=$FG2]"
	printf " $1 "
}

function prompt_tmux() {
	prompt_command_add 'trap hook_pre debug'
	set_pane_path "$(pwd)"
	set_pane_title " $(tmux_powerline_sep '')"
	PANETITLE=
}

function hook_post() {
	trap - debug
	if [ -z "$PANETITLE" ]; then
		sec=
	else
		sec=${SECONDS}s
	fi
	set_pane_title "$PANETITLE $(tmux_powerline_sep $sec)"
	set_pane_path "$(pwd)"
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
