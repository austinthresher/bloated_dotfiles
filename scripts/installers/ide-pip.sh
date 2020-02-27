#!/bin/bash

pip3 install --user wheel
pip3 install --user pylama
pip3 install --user jedi==0.15.0
pip3 install --user neovim
pip3 install --user python-language-server
pip3 install --user pyls-isort
pip3 install --user cmake_format
pip3 install --user vim-vint
pip3 install --user yapf
pip3 install --user msgpack

VINT="$HOME/.local/bin/vint"
if [ ! -f "$VINT" ]; then
    echo -e "#!/usr/bin/env python3\nimport vint\nvint.main()" > "$VINT"
    chmod +x "$VINT"
fi
