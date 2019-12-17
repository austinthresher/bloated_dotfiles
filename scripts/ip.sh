#!/bin/bash

function get_ip() {
	if [ -x "$(which ip)" ]; then
		ip addr | $(which grep) "e..[0-9]$" | awk '{ print $2 }' | sed 's/\/.*//g'
	else
		printf "unknown"
	fi
}
export IP_ADDR=$(get_ip)
