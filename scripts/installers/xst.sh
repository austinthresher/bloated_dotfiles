#!/bin/bash

DIR=$(mktemp -d)
trap "rm -rf '$DIR'" EXIT
git clone https://github.com/gnotclub/xst "$DIR/xst"
cd "$DIR/xst"
make PREFIX="$HOME/.local" && make PREFIX="$HOME/.local" install
