#!/bin/bash

function shorten_path() {
	echo $1 | sed 's/\([^/]\)[^/]*\//\1\//g'
}

function cwd() {
	local dir1=$(pwd)
	local dir2=$(printf "${dir1/#$HOME/\~}")
	shorten_path "$dir2"
}
