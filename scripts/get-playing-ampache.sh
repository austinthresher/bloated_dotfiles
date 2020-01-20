#!/bin/bash

# Awk script to grab song title from Ampache window title.
# This script only works if Ampache is the focused tab or has its own window.
# The regex matches from the beginning of the string to the first few characters
# of ' | Ampache :: For the Love of Music'. Then it trims the beginning of the
# string to the first quotation mark, leaving us with just the title and artist
read -d '' awk_script << 'EOF'
{
	match($0, "^ *[0-9]x[0-9a-fA-F]* \\".*Ampache")
	trim_from_start = index($0, "\\"")
	print(substr($0, RSTART+trim_from_start, RLENGTH-10-trim_from_start))
}
EOF
xwininfo -tree -root | grep " | Ampache" | tail -n 1 | awk "$awk_script"
