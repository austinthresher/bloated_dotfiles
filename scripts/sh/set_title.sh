#!/bin/bash

function set_title() {
	case "$TERM" in
		screen*|tmux*) printf "\ek$1\e\\" ;;
		linux|xterm*|rxvt*) printf "\e]0;$1\007" ;;
		*) ;;
	esac
}

function set_pane_title() {
	[ ! -z "$TMUX" ] && printf "\e]2;$1\e\\";
}

function set_pane_path() { 
	[ ! -z "$TMUX" ] && printf "\e]7;$1\e\\";
}
