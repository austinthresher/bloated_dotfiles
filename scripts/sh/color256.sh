#!/bin/bash

function color256fg() { printf "\e[38;5;$1m"; }
function color256bg() { printf "\e[48;5;$1m"; }
