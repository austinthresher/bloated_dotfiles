#!/bin/bash

# TODO: right now this just gets 1 parent process. Make it iterate to the top

export __PID="$$"
__PARENT_PID=$(ps -jat | awk '$2 == '"$__PID"' { print $1 }')
ps -e | awk '$1 == '"$__PARENT_PID"' { print $4 }'

