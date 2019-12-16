#!/bin/bash

# Counts the number of printable characters in $1, moves the cursor
# to the (columns - numchars) column, prints string, returns cursor
# to beginning of line with \r
function right_print() {
	local str=$1
	local stripped=$(echo $str | sed "s/\x1B\[[0-9;]*[a-zA-Z]//g")
	local cols=${COLUMNS:-$(tput cols)}
	local len=${#stripped}
	local offset=$(expr $cols - $len)
	printf "%${offset}s%s"'\r' "" "$str"
}
