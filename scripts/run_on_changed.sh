#!/bin/bash

if [ ! -e "$1" ]; then
    echo "file not found: $1"
else
    LASTMOD=
    while true; do
        MOD=$(stat "$1" -c '%Y')
        if [ "$LASTMOD" != "$MOD" ]; then
            ./$1
            LASTMOD="$MOD"
        fi
        sleep 1
    done
fi
