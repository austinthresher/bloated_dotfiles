#!/bin/bash
apt-get update && apt-get upgrade -y
apt-get install -y \
	clang*-9 cmake vim tmux git make build-essential ctags \
	python3 python3-jedi python3-numpy python3-pep8 \
	python3-pip python3-matplotlib python3-ipython python3-gdbm \
	python3-pytest python3-sdl2 python3-venv python3-yapf \
	xfonts-terminus stterm graphviz doxygen cppcheck libsdl2-dev \
	libsdl2-ttf-dev tree
