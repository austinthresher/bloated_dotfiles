#!/bin/bash
apt-get update && apt-get upgrade -y
apt-get install -y clang*-9 cmake vim tmux git make build-essential ctags
apt-get install -y python3 python3-jedi python3-numpy python3-pep8 \
	python3-pip python3-matplotlib python3-ipython python3-gdbm \
	python3-pytest python3-sdl2 python3-venv python3-yapf
apt-get install -y xfonts-terminus stterm
