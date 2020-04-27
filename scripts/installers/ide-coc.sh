#!/bin/bash

cd "$HOME/.config/nvim/repos/"
if [ ! -d "coc.nvim" ]; then
    git clone https://github.com/neoclide/coc.nvim coc.nvim
fi
cd coc.nvim
git checkout release
git pull
EXTENSIONS='coc-json coc-tsserver coc-yaml coc-python coc-highlight '
EXTENSIONS+='coc-snippets coc-lists coc-yank coc-vimlsp coc-clangd '
EXTENSIONS+='coc-go coc-cmake'
nvim -c "CocInstall -sync ${EXTENSIONS} |q"
