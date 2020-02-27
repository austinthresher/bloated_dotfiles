#!/bin/bash

# Node.js
curl -sL install-node.now.sh | /bin/bash -s -- --prefix="$HOME/.local" -y
npm i -g neovim
npm i -g bash-language-server
npm i -g dockerfile-language-server-nodejs
npm i -g standard
npm i -g eslint
npm i -g remark-cli
npm i -g fixjson
npm i -g javascript-typescript-langserver
npm i -g yarn

yarn global add vim-language-server
