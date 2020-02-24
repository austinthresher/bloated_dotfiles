#!/bin/bash

for v in "$@"; do
     printf "\e[48;5;${v}m    \e[0m"
done
printf "\n"
