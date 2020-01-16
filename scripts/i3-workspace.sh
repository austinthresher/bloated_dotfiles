#!/bin/bash
__WINDEX=$(i3-msg -t get_workspaces \
	| sed 's|.*name\":\"\([a-zA-Z0-9]*\)\",\"visible\":true.*|\1|')

printf '${color #666666}'
for ((i=1;i<=9;i++)); do
	if [ "$i" == "$__WINDEX" ]; then
		printf ' ${color white}'
		printf "$i"
		printf '${color #666666}'
	else
		printf " $i"
	fi
done
if [ "$__WINDEX" == 10 ]; then
	printf ' ${color white}0'
else
	printf ' 0'
fi
