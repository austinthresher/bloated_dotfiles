#!/bin/bash

DIR=$(mktemp -d)
git clone https://github.com/gnotclub/xst "$DIR/xst"
pushd "$DIR/xst"
make PREFIX="$HOME/.local" && make PREFIX="$HOME/.local" install
popd
rm -rf "$DIR"
