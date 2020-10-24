#!/bin/bash

PSTEMP=$(mktemp -d)
trap "rm -rf $PSTEMP" EXIT
cd $PSTEMP
git clone https://github.com/deadalnix/pixel-saver.git
cd pixel-saver
git checkout tags/1.24
mkdir -p $HOME/.local/share/gnome-shell/extensions
cp -r pixel-saver@deadalnix.me -t $HOME/.local/share/gnome-shell/extensions
gnome-extensions enable pixel-saver@deadalnix.me
