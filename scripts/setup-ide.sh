#!/bin/bash

# Sets up development environment with neovim and ycm
# on Ubuntu 18.04

# Set PATH
PREFIX=${PREFIX:-"$HOME/.local"}
if [[ $PATH != *"$PREFIX/bin"* ]]; then
	export PATH="$PREFIX/bin:$PATH"
fi

# Ensure we have the programs we need
REQUIRED=(git python3 wget tar curl)
for x in "${REQUIRED[@]}"; do
	which $x &> /dev/null || {
		echo "Requires '$x', please install before continuing."
		exit 1
	}
done

# Set up python virtual environment
if [ ! -d "$PREFIX/python" ]; then
	python3 -m venv "$PREFIX/python" --prompt=ide
	echo "source $PREFIX/python/bin/activate" >> ~/.bashrc
fi
source "$PREFIX/python/bin/activate"
pip3 install wheel
pip3 install pylint
pip3 install jedi
pip3 install black
pip3 install neovim
pip3 install python-language-server

# package urls
NVIM=nvim-linux64
NVIM_EXT=.tar.gz
NVIM_URL="https://github.com/neovim/neovim/releases/download/v0.4.3/$NVIM$NVIM_EXT"

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

curl -sL install-node.now.sh | bash -s -- --prefix=$PREFIX

echo "Writing init.vim"
cat << EOF > "$HOME/.config/nvim/init.vim"
set nocompatible
set previewheight=3
call plug#begin('$VIMPLUG')
	Plug 'prabirshrestha/async.vim'
	Plug 'prabirshrestha/vim-lsp'
	Plug 'prabirshrestha/asyncomplete.vim'
	Plug 'prabirshrestha/asyncomplete-lsp.vim'
	Plug 'mattn/vim-lsp-settings'
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
call plug#end()

let g:python3_host_prog = '$HOME/.local/python/bin/python3'

let g:srcery_italic = 1
colorscheme srcery

let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_virtual_text_enabled = 0
let g:lsp_signs_enabled = 0

hi LspErrorHighlight gui=underline cterm=underline guifg=red ctermfg=red
hi LspWarningHighlight gui=underline cterm=underline guifg=yellow ctermfg=yellow

set shiftwidth=4
set tabstop=4
set softtabstop=4
set expandtab

EOF
cat << 'EOF' >> "$HOME/.config/nvim/init.vim"
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

EOF

echo "Installing neovim plugins"
nvim -c ':PlugInstall' -c ':qa'
