#!/bin/bash

function shorten_path() {
	echo $1 | sed 's/\([^/]\)[^/]*\//\1\//g'
}

function pwd() {
	local dir=$($(which pwd))
	dir=$(printf "${dir/#$HOME/\~}")
	if [ -z "$LIMITED_SPACE" ]; then
		echo "$dir"
	else
		shorten_path "$dir"
	fi
}
