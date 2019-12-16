#!/bin/bash

function rgb_color() { printf "\e[38;2;$1;$2;$3m"; }

# This escape code was difficult to search for. Found it here:
# https://metacpan.org/release/Term-ExtendedColor-Xresources/source/lib/Term/ExtendedColor/Xresources.pm
# Remaps an xterm 256 color index to a new RGB value
# redefcol <index> <rgb>
# where r, g, and b are 2 digit hex values
rgb_set_col() {
	case $TERM in
		*tmux*|*screen*)
			echo -ne "\eP\e]4;$1;rgb:${2:0:2}/${2:2:2}/${2:4:2}\a\e\\"
			;;
		*)
			echo -ne "\e]4;$1;rgb:${2:0:2}/${2:2:2}/${2:4:2}\e\\"
			;;
	esac
}
rgb_set_bg() {
	case $TERM in
		*tmux*|*screen*)
			echo -ne "\eP\e]11;rgb:${1:0:2}/${1:2:2}/${1:4:2}\a\e\\"
			;;
		*)
			echo -ne "\e]11;rgb:${1:0:2}/${1:2:2}/${1:4:2}\e\\"
			;;
	esac

}
rgb_set_fg() {
	case $TERM in
		*tmux*|*screen*)
			echo -ne "\eP\e]10;rgb:${1:0:2}/${1:2:2}/${1:4:2}\a\e\\"
			;;
		*)
			echo -ne "\e]10;rgb:${1:0:2}/${1:2:2}/${1:4:2}\e\\"
			;;
	esac
}

