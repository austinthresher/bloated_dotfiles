#!/bin/bash

GOGHTEMP=$(mktemp -d)
trap "rm -rf $GOGHTEMP" EXIT
cd $GOGHTEMP
git clone --depth 1 https://github.com/mayccoll/gogh.git
cd gogh/themes
export TERMINAL=gnome-terminal

./gruvbox-dark.sh
./hemisu-dark.sh
./hemisu-light.sh
./ibm3270.sh
./papercolor-dark.sh
./papercolor-light.sh
./seafoam-pastel.sh
./srcery.sh
./tomorrow-night-bright.sh
./vs-code-dark-plus.sh
