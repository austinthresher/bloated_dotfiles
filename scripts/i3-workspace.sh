#!/bin/bash
__WINDEX=$(i3-msg -t get_workspaces | sed 's|.*name\":\"\([a-zA-Z0-9]*\)\",\"visible\":true.*|\1|')
for ((i=1;i<=8;i++)); do
	if [ "$i" == "$__WINDEX" ]; then
		printf "[$__WINDEX] "
	else
		printf " $i "
	fi
done
