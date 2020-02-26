#!/bin/bash

# Downloads and installs binaries for a general development environment
# on Ubuntu 18.04 or OSX

function osx {
    [[ $OSTYPE == *darwin* ]]
}

# Set PATH
PREFIX=${PREFIX:-"$HOME/.local"}
if [[ $PATH != *"$PREFIX/bin"* ]]; then
    export PATH="$PREFIX/bin:$PATH"
fi

# Ensure we have the programs we need
REQUIRED=(git python3 pip3 tar curl)
for x in "${REQUIRED[@]}"; do
    which $x &> /dev/null || {
        echo "Requires '$x', please install before continuing."
            exit 1
        }
done

# package urls
osx \
    && NVIM=nvim-macos \
    || NVIM=nvim-linux64
NVIM_EXT=.tar.gz
NVIM_URL="https://github.com/neovim/neovim/releases/download/v0.4.3/$NVIM$NVIM_EXT"

osx \
    && LLVM=clang+llvm-9.0.0-x86_64-darwin-apple \
    || LLVM=clang+llvm-9.0.0-x86_64-linux-gnu-ubuntu-18.04
LLVM_EXT=.tar.xz
LLVM_URL="http://releases.llvm.org/9.0.0/$LLVM$LLVM_EXT"

osx \
    && CMAKE=cmake-3.16.3-Darwin-x86_64 \
    || CMAKE=cmake-3.16.3-Linux-x86_64
CMAKE_EXT=.tar.gz
CMAKE_URL="https://github.com/Kitware/CMake/releases/download/v3.16.3/$CMAKE$CMAKE_EXT"

osx \
    && SHELLCHECK=shellcheck-stable.darwin.x86_64 \
    || SHELLCHECK=shellcheck-stable.linux.x86_64
SHELLCHECK_EXT=.tar.xz
SHELLCHECK_URL="https://storage.googleapis.com/shellcheck/$SHELLCHECK$SHELLCHECK_EXT"

# Installer functions for above packages
INSTALL_DIRS=(bin include lib libexec share)

mkdir -p "$PREFIX"
for d in "${INSTALL_DIRS[@]}"; do
    mkdir -p "$PREFIX/$d"
done

function install_dirs {
    for d in "${INSTALL_DIRS[@]}"; do
        [ -d "$1/$d" ] \
            && echo "installing $(basename $1)/$d to $PREFIX/$d" \
            && cp -r -t "$PREFIX/$d" /$1/$d/*
        done
    }

function dl_and_install {
    NAME=$1
    URL=$2
    EXT=$3
    echo "downloading $URL"
    curl -fsSL "$URL" -o "$NAME$EXT" --insecure
    if [ ! -e "$NAME$EXT" ]; then
        echo "Could not find $NAME$EXT. Directory listing:"
        ls -a
        exit 1
    fi
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

    # get shellcheck
    dl_and_install $SHELLCHECK $SHELLCHECK_URL $SHELLCHECK_EXT
    # os extract dir is inconsistent
    [ -f shellcheck ] && cp shellcheck "$PREFIX/bin/"
    [ -f shellcheck-stable ] && cp shellcheck-stable "$PREFIX/bin/shellcheck"
    [ -d shellcheck-stable ] && cp shellcheck-stable/shellcheck "$PREFIX/bin/shellcheck"

    # vim-plug
    for VIM in ( "$HOME/.config/nvim" "$HOME/.vim" ); do
        mkdir -p "$VIM/autoload"
        mkdir -p "$VIM/repos"
        git clone https://github.com/junegunn/vim-plug "$VIM/repos/vim-plug"
        ln -s "$VIM/repos/vim-plug/plug.vim" "$VIM/autoload/plug.vim"
    done

    popd &> /dev/null
    rm -rf "$TMP"
else
    echo "Failed to create temporary directory"
fi

