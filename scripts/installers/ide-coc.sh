#!/bin/bash

EXTENSIONS='coc-json coc-tsserver coc-yaml coc-python coc-highlight '
EXTENSIONS+='coc-snippets coc-lists coc-yank coc-vimlsp coc-clangd '

nvim -c "CocInstall -sync ${EXTENSIONS} |q"
