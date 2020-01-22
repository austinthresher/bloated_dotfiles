#!/bin/bash

function get_ip() {
	if [ ! -z "$(which ip)" ]; then
		ip addr \
			| egrep "(wlp|wlan|enp|eth|en|eno)[0-9]" \
			| egrep "[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}" \
			| awk '{ print $2 }' \
			| sed 's/\/.*//g'
	elif [ ! -z "$(which ifconfig)" ]; then
		ifconfig \
			| grep 'inet [0-9]*.[0-9]*.[0-9]*.[0-9]' \
			| grep -v '127.0.0.1' \
			| awk '{ print $2 }'
	else
		printf "no ip"
	fi
}
export IP_ADDR=$(get_ip)
