#!/bin/bash

# This script should be ran from the repo root directory

backup() {
	if [ -e "$1" ]; then
		mv "$1" "$1.bak" 
		local res=$?
		if [ "$res" == "0" ]; then
			echo "backed up $1 to $1.bak"
		else
			diff "$1" "$1.bak"
			res=$?
			if [ "$res" ]; then
				echo "Can't back up $1, backup differs from existing file"
			else
				rm "$1.bak"
				backup "$1"
			fi
		fi
	fi
}

backup $HOME/.bashrc
backup $HOME/.vimrc
backup $HOME/.tmux.conf
backup $HOME/.tmux.local
backup $HOME/.tmux.remote

ln bashrc $HOME/.bashrc
ln vimrc $HOME/.vimrc
ln tmux.conf $HOME/.tmux.conf
ln tmux.top $HOME/.tmux.local
ln tmux.nested $HOME/.tmux.remote

mkdir -p $HOME/.vim/colors
mkdir -p $HOME/.config/

[ ! -e "$HOME/.vim/colors/focuspoint.vim" ] && ln colors/focuspoint.vim $HOME/.vim/colors/
[ ! -e "$HOME/.vim/colors/mono.vim" ] && ln colors/mono.vim $HOME/.vim/colors/
