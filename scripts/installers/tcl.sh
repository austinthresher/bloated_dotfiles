#!/bin/bash

# Builds Tcl/Tk from source and installs for current user

TMP=$(mktemp -d)
trap 'rm -rf $TMP' EXIT

# Only add config flags to tk
CONFIG=
for TCL in tcl8.6.10 tk8.6.10; do
    cd "$TMP" || exit 1
    wget "https://prdownloads.sourceforge.net/tcl/$TCL-src.tar.gz"
    tar -xf "$TCL-src.tar.gz"
    cd "$TCL/unix" || exit 1
    ./configure --prefix="$HOME/ide" $CONFIG
    make
    make install
    CONFIG=--with-tcl="$TMP/tcl8.6.10/unix"
done

[ ! -e "$HOME/ide/bin/tclsh" ] && ln -s "$HOME/ide/bin/tclsh8.6" "$HOME/ide/bin/tclsh"

# Install Nagelfar, a Tcl static analysis tool

wget https://downloads.sourceforge.net/project/nagelfar/Rel_131/nagelfar131.tar.gz
tar -xf nagelfar131.tar.gz
cp -r nagelfar131 "$HOME/ide/"
TARGET="$HOME/ide/bin/nagelfar"
rm -f "$TARGET"
ln -s "$HOME/ide/nagelfar131/nagelfar.tcl" "$TARGET"
