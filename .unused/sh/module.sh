#!/bin/bash

# Functions to source scripts and check if a script has been sourced.

# Return true if $1 is the name of a valid function or executable
function require() {
	LC_ALL=C type $1 1>/dev/null 2>/dev/null 
}

# Print an error message and exit with the last error code
function die() {
	local retcode=$?
	printf "[exited with $retcode] %s\n" "$@" >&2
	exit "$retcode"
}

# Return true if $1.sh is a script that has been loaded
function loaded() {
	[[ "$LOADED" == *"$1"* ]]
}

# Source a script if it has not been loaded 
function load() {
  if ! loaded "$1"; then
    local script=$(which "$1.sh")
    if [ "$?" == 0 ]; then
      source "$script"
      LOADED+="$1 "
    else
      echo "Couldn't find '$1.sh' in \$PATH"
    fi
  else
    echo "'$1.sh' is already loaded"
  fi
}

