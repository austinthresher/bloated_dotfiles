#!/bin/bash
TCL=tcl8.6.10
TMP=$(mktemp -d)
trap 'rm -rf $TMP' EXIT
cd "$TMP" || exit 1
wget "https://prdownloads.sourceforge.net/tcl/$TCL-src.tar.gz"
tar -xf "$TCL-src.tar.gz"
cd "$TCL/unix" || exit 1
./configure --prefix="$HOME/.local"
make
make install
ln -s "$HOME/.local/bin/tclsh8.6" "$HOME/.local/bin/tclsh"
