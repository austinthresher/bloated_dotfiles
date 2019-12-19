#!/bin/bash

require prompt_command_add || return
require set_pane_path || return
require set_pane_title || return
require cwd || cwd() { pwd; }

trap "$PROMPT_COMMAND" WINCH

PANE_ICON="${TMUX_PUSH}${COMMAND_ICON}${TMUX_POP}"

function update_tmux() {
  set_pane_path "$(cwd)"
  if [ "$#" == 0 ]; then
    set_pane_title "$PANE_ICON "
  else
    set_pane_title "$PANE_ICON $@ "
  fi
  $(which tmux) refresh-client
}

function init_trap() {
	require resize && prompt_command_add 'resize'
	if [ ! -z "$TMUX" ]; then
		prompt_command_add 'trap hook_pre debug'
    update_tmux
		PANETITLE=
	fi
}

function hook_post() {
	trap - debug
  update_tmux $PANETITLE
}

function hook_pre() {
	trap - debug
	c=$BASH_COMMAND
	if [[ "$PROMPT_COMMAND" != *"$c"* ]]; then
		PANETITLE="${c%% *}"
	  update_tmux "#[fg=$TMUX_WHITE]$PANETITLE"
	else
		PANETITLE=
    update_tmux
	fi
	trap hook_post debug
}
