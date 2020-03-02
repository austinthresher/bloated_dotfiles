#!/bin/bash

cd "$HOME/.config/nvim/repos/"
if [ ! -d "coc.nvim" ]; then
    git clone https://github.com/neoclide/coc.nvim coc.nvim
fi
cd coc.nvim
git checkout release

EXTENSIONS='coc-json coc-tsserver coc-yaml coc-python coc-highlight '
EXTENSIONS+='coc-snippets coc-lists coc-yank coc-vimlsp coc-clangd '

nvim -c "CocInstall -sync ${EXTENSIONS} |q"
