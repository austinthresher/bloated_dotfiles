#!/bin/bash

function prompt_command_clear() {
	export PROMPT_COMMAND=
}

function prompt_command_add() {
	if [ -z "$PROMPT_COMMAND" ]; then
		export PROMPT_COMMAND="$@"
	else
		export PROMPT_COMMAND="$PROMPT_COMMAND && $@"
	fi
}
