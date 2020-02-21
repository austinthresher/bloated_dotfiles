#!/bin/bash

set -o errexit

# netget <file-url>
function netget {
    local src="$1"
    local dst="${1##*/}"
    if which wget &> /dev/null  && [ -x "$(which wget)" ]; then
        wget -O "$dst" "$src" --no-check-certificate
    elif which perl &> /dev/null  && [ -x "$(which perl)" ]; then
        perl -MLWP::Simple -e "getstore \"$src\", \"$dst\""
    elif which curl &> /dev/null && [ -x "$(which curl)" ]; then
        curl -fsSL "$src" -o "$dst" --insecure
    else
        echo "No download utility found. Setup cannot continue."
        return 127
    fi
    echo "$dst"
}

case "$OS" in
    linux|wsl)
        netget https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh
        chmod +x install.sh
        sh install.sh
        rm install.sh
        export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
        ;;
    osx)
        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
        export PATH="/home/homebrew/.homebrew/bin:$PATH"
        ;;
    *)
        echo "Unknown OS. Exiting"
        exit 1
        ;;
esac

brew update
