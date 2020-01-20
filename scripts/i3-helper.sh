#!/bin/bash
set -x
# Launches compton and conky with resolution-dependant settings

killall -q compton -9
killall -q conky -9

compton --daemon
__RESOLUTION=$(xrandr | head -n 1 | sed 's/.*current \([0-9]*\) x \([0-9]*\).*$/\1x\2/')
__HEIGHT=${__RESOLUTION##*x}
__WIDTH=${__RESOLUTION%%x*}
echo "$__RESOLUTION"
if [ -d "/sys/class/power_supply/BAT*" ]; then
    cat "$HOME/.conkyrc" \
        | sed \
            -e "s@%WIDTH%@$__WIDTH@g" \
            -e "s@%HEIGHT%@$__HEIGHT@g" \
            -e '33i${template1}    \\' \
        > "$HOME/.generated/conky.conf"
else
    cat "$HOME/.conkyrc" \
        | sed \
            -e "s@%WIDTH%@$__WIDTH@g" \
            -e "s@%HEIGHT%@$__HEIGHT@g" \
        > "$HOME/.generated/conky.conf"
fi

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
