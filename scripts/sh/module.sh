#!/bin/bash


function require() {
	LC_ALL=C type $1 1>/dev/null 2>/dev/null 
}

function die() {
	local retcode=$?
	printf "%s\n" "$@" >&2
	exit "$retcode"
}

function load() {
	if [ -e "$HOME/.dotfiles/scripts/sh/$1.sh" ]; then
		source "$HOME/.dotfiles/scripts/sh/$1.sh"
		LOADED+="$1 "
	else
		echo "Couldn't find module '$1'"
	fi
}

