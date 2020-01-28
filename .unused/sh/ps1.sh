#!/bin/bash

if loaded attributes; then
	if loaded unicode; then
		export PS1="\[$(reverse)$PROMPT_COLOR\]$POWERLINE_FILLED_RIGHT \w \[$(norm)$PROMPT_COLOR\]$POWERLINE_FILLED_RIGHT\[$(norm)\] "
	else
		export PS1="\[$(reverse)$PROMPT_COLOR\] \w \[$(norm)\] "
	fi
else
	[ -z "$SSH_CLIENT" ] \
		&& export PS1="[tty] \w \$ " \
		|| export PS1="[ssh] \w \$ "
fi

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
