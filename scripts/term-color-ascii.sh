#!/bin/bash


export TMUX_DEFAULT_TERM=screen

export SCREEN_WIDTH=${COLUMNS:-$(tput cols)}
test $SCREEN_WIDTH -lt 120 && export LIMITED_SPACE=true

load attributes
load color
load ascii
