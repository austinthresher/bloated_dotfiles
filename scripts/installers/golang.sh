#!/bin/bash

TMP=$(mktemp -d)
trap 'rm -rf $TMP' EXIT
cd "$TMP" || exit 1
wget https://dl.google.com/go/go1.4-bootstrap-20171003.tar.gz
tar -xf go1.4-bootstrap-20171003.tar.gz
cd go/src || exit 1
CGO_ENABLED=0 ./make.bash
cd "$HOME/.local" || exit 1
[ ! -d goroot ] && git clone https://go.googlesource.com/go goroot
cd goroot || exit 1
git checkout go1.14
cd src
GOROOT_BOOTSTRAP="$TMP/go" ./all.bash
ln -s "$HOME/.local/goroot/bin/go" "$HOME/.local/bin/"
ln -s "$HOME/.local/goroot/bin/gofmt" "$HOME/.local/bin/"
