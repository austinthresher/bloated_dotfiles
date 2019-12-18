#!/bin/bash

function get_ip() {
	if [ -x "$(which ip)" ]; then
		ip addr \
			| egrep "(wlp|wlan|enp|eth|en|eno)[0-9]" \
			| egrep "[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}" \
			| awk '{ print $2 }' \
			| sed 's/\/.*//g'
	else
		printf "unknown"
	fi
}
export IP_ADDR=$(get_ip)
