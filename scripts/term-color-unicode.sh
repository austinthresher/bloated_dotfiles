#!/bin/bash

export TMUX_DEFAULT_TERM=screen
export SCREEN_WIDTH=${COLUMNS:-$(tput cols)}
if [ $SCREEN_WIDTH -lt 120 ]; then
	export LIMITED_SPACE=true
fi

load attributes
load color
load unicode
