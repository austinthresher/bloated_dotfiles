#!/bin/bash
TARGET=cmake-3.16.3-Linux-x86_64.sh
TMP=/tmp/
URL="https://github.com/Kitware/CMake/releases/download/v3.16.3/$TARGET"
if [ ! -f "$TMP/$TARGET" ]; then
    wget "$URL" -O "$TMP/$TARGET"
fi
if [ -f "$TMP/$TARGET" ]; then
    sh "$TMP/$TARGET" --prefix="$HOME/.local" --skip-license
else
    echo "file not found: $TMP/$TARGET"
    return 1
fi
