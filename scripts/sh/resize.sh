#!/bin/bash

function resize() {
	export SCREEN_WIDTH=${COLUMNS:-$(tput cols)}
	export SCREEN_HEIGHT=${LINES:-$(tput lines)}
	if [ $SCREEN_WIDTH -lt 120 ]; then
		export LIMITED_SPACE=true
	elif [ "$LIMITED_SPACE" == true ]; then
		unset LIMITED_SPACE
	fi
}

resize


