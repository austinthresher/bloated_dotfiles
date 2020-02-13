#!/bin/bash

# Set bg to black
printf "\e[48;2;00;00;00m"
printf "\e[2J\e[;H"

echo "default"
#             blk red grn yel blu mag cyn whi
./theme256.sh 0   1   2   3   4   5   6   7
./theme256.sh 8   9   10  11  12  13  14  15

echo "neovim"
#             blk red grn yel blu mag cyn whi
./theme256.sh 234 197 112 221 75  127 84  252
./theme256.sh 241 203 118 227 147 165 122 255

echo "vim"
#             blk red grn yel blu mag cyn whi
./theme256.sh 233 160 82  214 63  129 85  225
./theme256.sh 59  197 156 221 105 140 159 231

echo "muted"
#             blk red grn yel blu mag cyn whi
./theme256.sh 233 167 149 215 109 171 114 225
./theme256.sh 101 210 155 228 147 218 158 231
