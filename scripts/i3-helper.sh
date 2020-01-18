#!/bin/bash
set -x
# Launches compton and conky with resolution-dependant settings

killall -q compton -9
killall -q conky -9

compton --daemon
__RESOLUTION=$(xrandr | grep '*' | awk '{print $1}')
__HEIGHT=${__RESOLUTION##*x}
__WIDTH=${__RESOLUTION%%x*}
cat "$HOME/.conkyrc" \
    | sed \
        -e "s@%WIDTH%@$__WIDTH@g" \
        -e "s@%HEIGHT%@$__HEIGHT@g" \
    > "$HOME/.generated/conky.conf"

if [ "$__HEIGHT" -gt 1080 -a "$__WIDTH" -gt 1920 ]; then
    conky -y 32 --config="$HOME/.generated/conky.conf" --daemonize
    i3-msg gaps inner all set 128 &> /dev/null
elif [ "$__HEIGHT" -gt 1366 -a "$__WIDTH" -gt 768 ]; then
    conky -y 24 --config="$HOME/.generated/conky.conf" --daemonize
    i3-msg gaps inner all set 64 &> /dev/null
else
    conky -y 16 --config="$HOME/.generated/conky.conf" --daemonize
    i3-msg gaps inner all set 32
    i3-msg gaps bottom all set 32
fi
