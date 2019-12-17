#!/bin/bash

function resize() {
	unset LIMITED_SPACE
	export SCREEN_WIDTH=${COLUMNS:-$(tput cols)}
	export SCREEN_HEIGHT=${LINES:-$(tput lines)}
	if [ $SCREEN_WIDTH -lt 120 ]; then
		export LIMITED_SPACE=true
	fi
}

resize

export TMUX_DEFAULT_TERM=tmux
load attributes
load color
