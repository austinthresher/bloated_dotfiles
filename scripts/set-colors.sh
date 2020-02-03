#!/bin/bash

function rgb_set_col {
    case $TERM in
        *tmux*|*screen*)
            echo -ne "\eP\e]4;$1;rgb:${2:0:2}/${2:2:2}/${2:4:2}\a\e\\"
            ;;
        *)
            echo -ne "\e]4;$1;rgb:${2:0:2}/${2:2:2}/${2:4:2}\e\\"
            ;;
    esac
}

# srcery theme
rgb_set_col 0   1C1B19
rgb_set_col 1   EF2F27
rgb_set_col 2   519F50
rgb_set_col 3   FBB829
rgb_set_col 4   2C78BF
rgb_set_col 5   E02C6D
rgb_set_col 6   0AAEB3
rgb_set_col 7   D0BFA1
rgb_set_col 8   918175
rgb_set_col 9   F75341
rgb_set_col 10  98BC37
rgb_set_col 11  FED06E
rgb_set_col 12  68A8E4
rgb_set_col 13  FF5C8F
rgb_set_col 14  53FDE9
rgb_set_col 15  FCE8C3
rgb_set_col 166 D75F00
rgb_set_col 208 FF8700
rgb_set_col 233 121212
rgb_set_col 235 262626
rgb_set_col 237 3A3A3A
rgb_set_col 238 444444
rgb_set_col 239 4E4E4E
rgb_set_col 240 585858
