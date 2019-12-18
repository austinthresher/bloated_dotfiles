#!/bin/bash

if require rgb_color; then
	[ -z "$SSH_CLIENT" ] \
		&& C=$(rgb_color 102 236 150) \
		|| C=$(rgb_color 204 102 102) 
	export PS1="\[$(bold)$C\]$PROMPT_TEXT\[$(norm)\]"
elif require color; then
	[ -z "$SSH_CLIENT" ] \
		&& C=$(color $COL_FG_GREEN) \
		|| C=$(color $COL_FG_RED)
	export PS1="\[$(bold)$C\]$PROMPT_TEXT\[$(norm)\]"
else
	[ -z "$SSH_CLIENT" ] \
		&& export PS1="[tty]$PROMPT_TEXT" \
		|| export PS1="[ssh]$PROMPT_TEXT"
fi

export PS1="\w$PS1"

require prompt_command_clear || return
require prompt_command_add || return

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
