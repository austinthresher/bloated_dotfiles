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
pip3 install --user jedi==0.15.0
pip3 install --user neovim
pip3 install --user autopep8
pip3 install --user python-language-server
pip3 install --user pyls-isort
pip3 install --user cmake_format

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
npm i -g standard
npm i -g eslint
npm i -g remark-cli
npm i -g fixjson
