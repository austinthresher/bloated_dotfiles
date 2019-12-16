#!/bin/bash

C=
require color && [ -z "$SSH_CLIENT" ] \
	&& C=$(color $COL_FG_GREEN) \
	|| C=$(color $COL_FG_RED)

require rgb_color && [ -z "$SSH_CLIENT" ] \
	&& C=$(rgb_color 102 236 150) \
	|| C=$(rgb_color 204 102 102) 

export PS1="\[$(bold)$C\]$PROMPT_TEXT\[$(norm)\]"

require prompt_command_clear || return
require prompt_command_add || return

prompt_command_clear
require color && require right_print && prompt_command_add 'right_print $(color $COL_FG_DARK_GRAY)$(date +%H:%M:%S)$(norm)'
require set_title && prompt_command_add 'set_title $(whoami)@$(hostname)'
require prompt_tmux && [ ! -z "$TMUX" ] && prompt_tmux
