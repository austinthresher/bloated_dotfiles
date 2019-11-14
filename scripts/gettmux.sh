#!/bin/sh

require() {
	if [ ! -x $(which $1) ]; then
		echo "missing $1, install and try again."
		exit 1
	else
		echo "found $1"
	fi
}

require autoconf
require automake
require pkg-config
mkdir -p $HOME/.local/bin
[ ! -e "$HOME/.tmux" ] && git clone https://github.com/tmux/tmux.git "$HOME/.tmux"
cd "$HOME/.tmux"
git pull
sh autogen.sh
./configure && make -j
ln -s "$HOME/.tmux/tmux" "$HOME/.local/bin/tmux"
