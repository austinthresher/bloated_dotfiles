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

if [ "$__HEIGHT" -gt 1080 -a "$__WIDTH" -gt 1920 ]; then
    i3-msg gaps inner all set 128 &> /dev/null
elif [ "$__HEIGHT" -gt 1366 -a "$__WIDTH" -gt 768 ]; then
    i3-msg gaps inner all set 64 &> /dev/null
fi
