#!/bin/bash

JBMTEMP=$(mktemp -d)
trap "rm -rf $JBMTEMP" EXIT
curl -fsSL https://download.jetbrains.com/fonts/JetBrainsMono-2.001.zip -o $JBMTEMP/jbm.zip
cd $JBMTEMP || exit 1
unzip -q jbm.zip
mkdir -p $HOME/.local/share/fonts
mv ttf/No\ ligatures/*.ttf $HOME/.local/share/fonts/
