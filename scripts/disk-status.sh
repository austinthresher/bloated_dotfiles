#!/bin/bash
# Takes current path as only argument, outputs % full of current storage device
df --output=target,pcent -h $1 | sed '1d' | awk '{ print $2 }'
