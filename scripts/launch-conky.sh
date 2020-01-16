#!/bin/bash
__RESOLUTION=$(xrandr | grep '*' | awk '{print $1}')
__HEIGHT=${__RESOLUTION##*x}
__WIDTH=${__RESOLUTION%%x*}
cat "$HOME/.conkyrc" \
    | sed \
        -e "s@%WIDTH%@$__WIDTH@g" \
        -e "s@%HEIGHT%@$__HEIGHT@g" \
    > "$HOME/.generated/conky.conf"
killall conky -9
conky --config="$HOME/.generated/conky.conf" --daemonize
