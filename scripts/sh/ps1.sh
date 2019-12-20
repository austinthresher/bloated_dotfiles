#!/bin/bash

if loaded attributes; then
	export PS1="\[$(bold)$PROMPT_COLOR\]$PROMPT_TEXT\[$(norm)\]"
else
	[ -z "$SSH_CLIENT" ] \
		&& export PS1="[tty]$PROMPT_TEXT" \
		|| export PS1="[ssh]$PROMPT_TEXT"
fi

export PS1="\w$PS1"

loaded prompt_command || return

prompt_command_clear
if require color && require right_print; then
	prompt_command_add 'right_print $(color $COL_FG_DARK_GRAY)$(date +%H:%M:%S)$(norm)'
fi
if require set_title; then
  prompt_command_add 'set_title $(whoami)@$(hostname)'
fi
if require init_trap; then
	init_trap
fi
