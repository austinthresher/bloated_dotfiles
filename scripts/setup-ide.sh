#!/bin/bash

# Sets up development environment with neovim and ycm
# on Ubuntu 18.04

# Set PATH
PREFIX=${PREFIX:-"$HOME/.local"}
if [[ $PATH != *"$PREFIX/bin"* ]]; then
	export PATH="$PREFIX/bin:$PATH"
fi

# Ensure we have the programs we need
REQUIRED=(git python3 wget tar cmake)
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

echo "Writing init.vim"
cat << EOF > "$HOME/.config/nvim/init.vim"
set nocompatible

call plug#begin('$VIMPLUG')
	Plug 'ycm-core/YouCompleteMe'
	"Plug 'scrooloose/syntastic'
	Plug 'SirVer/ultisnips'
	Plug 'honza/vim-snippets'
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
call plug#end()

"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0
"let g:ycm_show_diagnostics_ui = 0

let g:srcery_italic = 1
colorscheme srcery

"let g:ycm_filetype_whitelist = [ 'python', 'cpp', 'c' ]
let g:ycm_error_symbol = '!'
let g:ycm_warning_symbol = '@'
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_server_python_interpreter = '$PREFIX/python/bin/python3'
let g:ycm_autoclose_preview_window_after_insertion = 1

nnoremap <C-]> YcmCompleter GoTo<cr>
nnoremap K :YcmCompleter GetDoc<cr>

set previewheight=3

EOF

echo "Installing neovim plugins"
nvim -c ':PlugInstall' -c ':qa'

echo "Building YouCompleteMe"
pushd "$VIMPLUG/YouCompleteMe" &> /dev/null
python3 install.py --clangd-completer
popd &> /dev/null
