#!/bin/bash

source "$HOME/ide/bin/activate"

pip3 install wheel
pip3 install pylama
pip3 install pylint
pip3 install jedi==0.17.2
pip3 install neovim
pip3 install python-language-server
pip3 install pyls-isort
pip3 install cmake_format
pip3 install vim-vint
pip3 install yapf
pip3 install msgpack

VINT="$HOME/ide/bin/vint"
if [ ! -f "$VINT" ]; then
    echo -e "#!/usr/bin/env python3\nimport vint\nvint.main()" > "$VINT"
    chmod +x "$VINT"
fi
