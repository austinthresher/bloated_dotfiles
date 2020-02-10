#!/bin/bash

# Sets up development environment with neovim and lsp
# on Ubuntu 18.04

# Set PATH
PREFIX=${PREFIX:-"$HOME/.local"}
if [[ $PATH != *"$PREFIX/bin"* ]]; then
    export PATH="$PREFIX/bin:$PATH"
fi

# Ensure we have the programs we need
REQUIRED=(git python3 pip3 wget tar curl)
for x in "${REQUIRED[@]}"; do
    which $x &> /dev/null || {
        echo "Requires '$x', please install before continuing."
        exit 1
    }
done

pip3 install --user wheel
pip3 install --user pylint
pip3 install --user jedi=0.15.0
pip3 install --user neovim
pip3 install --user autopep8
pip3 install --user python-language-server
pip3 install --user pyls-isort

# package urls
NVIM=nvim-linux64
NVIM_EXT=.tar.gz
NVIM_URL="https://github.com/neovim/neovim/releases/download/nightly/$NVIM$NVIM_EXT"

LLVM=clang+llvm-9.0.0-x86_64-linux-gnu-ubuntu-18.04
LLVM_EXT=.tar.xz
LLVM_URL="http://releases.llvm.org/9.0.0/$LLVM$LLVM_EXT"

CMAKE=cmake-3.16.3-Linux-x86_64
CMAKE_EXT=.tar.gz
CMAKE_URL="https://github.com/Kitware/CMake/releases/download/v3.16.3/$CMAKE$CMAKE_EXT"

# Installer functions for above packages
INSTALL_DIRS=(bin include lib libexec share)

mkdir -p "$PREFIX"
for d in "${INSTALL_DIRS[@]}"; do
    mkdir -p "$PREFIX/$d"
done

function install_dirs {
    for d in "${INSTALL_DIRS[@]}"; do
        echo "installing $(basename $1)/$d to $PREFIX/$d"
        [ -d "$1/$d" ] && cp -r -t "$PREFIX/$d" /$1/$d/* 
    done
}

function dl_and_install {
    NAME=$1
    URL=$2
    EXT=$3
    echo "downloading $URL"
    wget "$URL" -q
    echo "extracting $NAME$EXT"
    tar -xf "$NAME$EXT"
    install_dirs "$PWD/$NAME"
}

TMP=$(mktemp -d)
if [ -d "$TMP" ]; then
    pushd "$TMP" &> /dev/null

    # neovim
    dl_and_install $NVIM $NVIM_URL $NVIM_EXT

    # cmake
    dl_and_install $CMAKE $CMAKE_URL $CMAKE_EXT

    # llvm + clang
    dl_and_install $LLVM $LLVM_URL $LLVM_EXT

    # vim-plug
    VIMAUTO="$HOME/.config/nvim/autoload"
    mkdir -p "$VIMAUTO"
    pushd "$VIMAUTO" &> /dev/null
    git clone https://github.com/junegunn/vim-plug
    mv vim-plug/plug.vim .
    rm -rf vim-plug
    popd &> /dev/null
    VIMPLUG="$HOME/.config/nvim/repos"
    mkdir -p "$VIMPLUG"

    popd &> /dev/null
    rm -rf "$TMP"
else
    echo "Failed to create temporary directory"
fi

# Node.js
curl -sL install-node.now.sh | bash -s -- --prefix=$PREFIX -y
npm i -g neovim
npm i -g bash-language-server
npm i -g dockerfile-language-server-nodejs

echo "Writing init.vim"

# Write out portion of vimrc that needs variables expanded
cat << EOF > "$HOME/.config/nvim/init.vim"
call plug#begin('$VIMPLUG')
EOF
# Write rest of vimrc
cat << 'EOF' >> "$HOME/.config/nvim/init.vim"
    Plug 'junegunn/fzf', { 'do': './install --bin' }
    Plug 'junegunn/fzf.vim'
    Plug 'tpope/vim-sensible'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-eunuch'
    Plug 'tpope/vim-endwise'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-rsi'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-apathy'
    Plug 'tpope/vim-abolish'
    Plug 'tpope/vim-unimpaired'
    Plug 'srcery-colors/srcery-vim'
    Plug 'ap/vim-buftabline'
    Plug 'yggdroot/indentline'
    Plug 'google/vim-searchindex'
    Plug 'junegunn/vim-easy-align'
    Plug 'neovim/nvim-lsp'
call plug#end()

try
lua << END_LUA
require'nvim_lsp'.pyls.setup{}
require'nvim_lsp'.clangd.setup{}
require'nvim_lsp'.bashls.setup{}
require'nvim_lsp'.dockerls.setup{}
END_LUA

set omnifunc=v:lua.vim.lsp.omnifunc
catch
endtry

let g:srcery_italic = 1
colorscheme srcery

set nocompatible
set previewheight=3
set shiftwidth=4
set softtabstop=4
set expandtab

" Clear search with <C-L>
nnoremap <c-l> :noh<cr><c-l>

nnoremap ` <c-w>
nnoremap <c-w>` `

nmap <leader>1 <Plug>BufTabLine.Go(1)
nmap <leader>2 <Plug>BufTabLine.Go(2)
nmap <leader>3 <Plug>BufTabLine.Go(3)
nmap <leader>4 <Plug>BufTabLine.Go(4)
nmap <leader>5 <Plug>BufTabLine.Go(5)
nmap <leader>6 <Plug>BufTabLine.Go(6)
nmap <leader>7 <Plug>BufTabLine.Go(7)
nmap <leader>8 <Plug>BufTabLine.Go(8)
nmap <leader>9 <Plug>BufTabLine.Go(9)
nmap <leader>0 <Plug>BufTabLine.Go(10)
nmap ga <Plug>(EasyAlign)
vmap <Enter> <Plug>(EasyAlign)

let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_list_hide = netrw_gitignore#Hide()

let g:indentLine_char_list = ['|', '¦', '┆', '┊']
let g:indentLine_setColors = 0

let g:buftabline_indicators = 1
let g:buftabline_numbers = 2

set cot+=preview

nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>


EOF

nvim +PlugInstall +UpdateRemotePlugins +qa
