#!/bin/bash

function get_ip() {
	if [ -x "$(which ip)" ]; then
		ip addr \
			| egrep "(wlan|enp|eth|en)[0-9](s[0-9][0-9])?" \
			| grep inet \
			| awk '{ print $3 }' \
			| sed 's/\/.*//g'
	else
		printf "unknown"
	fi
}
export IP_ADDR=$(get_ip)
