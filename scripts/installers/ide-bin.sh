#!/bin/bash

# Downloads and installs binaries for a general development environment
# on Ubuntu 18.04 or OSX

function osx {
    [[ $OSTYPE == *darwin* ]]
}

# Set PATH
PREFIX=${PREFIX:-"$HOME/ide"}
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

python3 -m venv "$PREFIX"
source "$PREFIX/bin/activate"

# package urls

# Neovim
if osx; then
    NVIM=nvim-macos
    NVIM_DIR=nvim-osx64
else
    NVIM=nvim-linux64
    NVIM_DIR=$NVIM
fi
NVIM_EXT=.tar.gz
NVIM_URL="https://github.com/neovim/neovim/releases/download/nightly/$NVIM$NVIM_EXT"

# Clang + LLVM
if osx; then
    LLVM=clang+llvm-9.0.0-x86_64-darwin-apple
    LLVM_DIR=$LLVM
else
    LLVM=clang+llvm-9.0.0-x86_64-linux-gnu-ubuntu-18.04
    LLVM_DIR=$LLVM
fi
LLVM_EXT=.tar.xz
LLVM_URL="http://releases.llvm.org/9.0.0/$LLVM$LLVM_EXT"

# CMake
if osx; then
    CMAKE=cmake-3.16.3-Darwin-x86_64
    CMAKE_DIR=$CMAKE/CMake.app/Contents
else
    CMAKE=cmake-3.16.3-Linux-x86_64
    CMAKE_DIR=$CMAKE
fi
CMAKE_EXT=.tar.gz
CMAKE_URL="https://github.com/Kitware/CMake/releases/download/v3.16.3/$CMAKE$CMAKE_EXT"

# Shellcheck
if osx; then
    SHELLCHECK=shellcheck-stable.darwin.x86_64
    SHELLCHECK_DIR=shellcheck-stable
else
    SHELLCHECK=shellcheck-stable.linux.x86_64
    SHELLCHECK_DIR=shellcheck-stable
fi
SHELLCHECK_EXT=.tar.xz
SHELLCHECK_URL="https://storage.googleapis.com/shellcheck/$SHELLCHECK$SHELLCHECK_EXT"

# Copy these folders from the packages above
INSTALL_DIRS=(bin include lib libs libexec share)

mkdir -p "$PREFIX"
for d in "${INSTALL_DIRS[@]}"; do
    mkdir -p "$PREFIX/$d"
done

function install_dirs {
    for d in "${INSTALL_DIRS[@]}"; do
        [ -d "$d" ] \
            && echo "installing $d to $PREFIX/$d" \
            && cp -r "$d" "$PREFIX/"
    done
}

function dl_and_install {
    NAME=$1
    URL=$2
    EXT=$3
    DIR=$4
    echo "downloading $URL"
    curl -fsSL "$URL" -o "$NAME$EXT" --insecure
    if [ ! -e "$NAME$EXT" ]; then
        echo "Could not find $NAME$EXT. Directory listing:"
        ls -aF
        exit 1
    fi
    echo "extracting $NAME$EXT"
    tar -xf "$NAME$EXT"
    if [ ! -d "$DIR" ]; then
        echo "Couldn't find $DIR. Directory listing:"
        ls -aF
        exit 1
    fi
    pushd "$DIR"
    install_dirs
    popd
}

TMP=$(mktemp -d)
if [ -d "$TMP" ]; then
    cd "$TMP"
    trap "rm -rf $TMP" EXIT
    # neovim
    dl_and_install $NVIM $NVIM_URL $NVIM_EXT $NVIM_DIR

    # cmake
    dl_and_install $CMAKE $CMAKE_URL $CMAKE_EXT $CMAKE_DIR

    # llvm + clang
    dl_and_install $LLVM $LLVM_URL $LLVM_EXT $LLVM_DIR

    # get shellcheck
    dl_and_install $SHELLCHECK $SHELLCHECK_URL $SHELLCHECK_EXT $SHELLCHECK_DIR
    cp $SHELLCHECK_DIR/shellcheck "$PREFIX/bin/shellcheck"

    # vim-plug
    for VIM in "$HOME/.config/nvim" "$HOME/.vim"; do
        mkdir -p "$VIM/autoload"
        mkdir -p "$VIM/repos"
        if [ ! -d "$VIM/repos/vim-plug" ]; then
            git clone https://github.com/junegunn/vim-plug "$VIM/repos/vim-plug"
            [ ! -f "$VIM/autoload/plug.vim" ] && ln -s "$VIM/repos/vim-plug/plug.vim" "$VIM/autoload/plug.vim"
        fi
    done

    for VIM in vim nvim; do
        if command -v $VIM &> /dev/null ; then
            $VIM -c 'PlugInstall | PlugClean! | qa!'
        fi
    done

    popd &> /dev/null
else
    echo "Failed to create temporary directory"
fi
