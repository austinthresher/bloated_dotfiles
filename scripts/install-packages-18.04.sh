#!/bin/bash
apt-get update && apt-get upgrade -y
apt-get install -y \
    vim tmux git make build-essential \
    python3 graphviz doxygen cppcheck \
    libsdl2-dev libsdl2-ttf-dev tree indent \
    ncurses-term
