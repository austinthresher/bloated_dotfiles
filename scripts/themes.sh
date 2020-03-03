#!/bin/bash

# rgb functions {{{
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

rgb_set_bg() {
    # hack to make this work on st
    rgb_set_col 256 $1
    case $TERM in
        *tmux*|*screen*)
            echo -ne "\eP\e]11;rgb:${1:0:2}/${1:2:2}/${1:4:2}\a\e\\"
            ;;
        *)
            echo -ne "\e]11;rgb:${1:0:2}/${1:2:2}/${1:4:2}\e\\"
            ;;
    esac
}

rgb_set_fg() {
    # hack to make this work on st
    rgb_set_col 257 $1
    case $TERM in
        *tmux*|*screen*)
            echo -ne "\eP\e]10;rgb:${1:0:2}/${1:2:2}/${1:4:2}\a\e\\"
            ;;
        *)
            echo -ne "\e]10;rgb:${1:0:2}/${1:2:2}/${1:4:2}\e\\"
            ;;
    esac
}
# }}}

function theme_elemental { #{{{
    rgb_set_col 0  3c3c30
    rgb_set_col 1  98290f
    rgb_set_col 2  479a43
    rgb_set_col 3  7f7111
    rgb_set_col 4  497f7d
    rgb_set_col 5  7f4e2f
    rgb_set_col 6  387f58
    rgb_set_col 7  807974
    rgb_set_col 8  555445
    rgb_set_col 9  e0502a
    rgb_set_col 10 61e070
    rgb_set_col 11 d69927
    rgb_set_col 12 79d9d9
    rgb_set_col 13 cd7c54
    rgb_set_col 14 59d599
    rgb_set_col 15 fff1e9
    rgb_set_bg 22211d
    rgb_set_fg 807a74
} #}}}

function theme_espresso { #{{{
    rgb_set_col 0  353535
    rgb_set_col 1  d25252
    rgb_set_col 2  a5c261
    rgb_set_col 3  ffc66d
    rgb_set_col 4  6c99bb
    rgb_set_col 5  d197d9
    rgb_set_col 6  bed6ff
    rgb_set_col 7  eeeeec
    rgb_set_col 8  535353
    rgb_set_col 9  f00c0c
    rgb_set_col 10 c2e075
    rgb_set_col 11 e1e48b
    rgb_set_col 12 8ab7d9
    rgb_set_col 13 efb5f7
    rgb_set_col 14 dcf4ff
    rgb_set_col 15 ffffff
    rgb_set_bg 323232
    rgb_set_fg ffffff
} #}}}

function theme_flat { #{{{
    rgb_set_col 0  2c3e50
    rgb_set_col 1  c0392b
    rgb_set_col 2  27ae60
    rgb_set_col 3  f39c12
    rgb_set_col 4  2980b9
    rgb_set_col 5  8e44ad
    rgb_set_col 6  16a085
    rgb_set_col 7  bdc3c7
    rgb_set_col 8  34495e
    rgb_set_col 9  e74c3c
    rgb_set_col 10 2ecc71
    rgb_set_col 11 f1c40f
    rgb_set_col 12 3498db
    rgb_set_col 13 9b59b6
    rgb_set_col 14 2AA198
    rgb_set_col 15 ecf0f1
    rgb_set_bg 1F2D3A
    rgb_set_fg 1abc9c
} #}}}

function theme_srcery { #{{{
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
    rgb_set_bg 1C1B19
    rgb_set_fg FCE8C3
} #}}}

function theme_nightowl { #{{{
    rgb_set_col 0  011627
    rgb_set_col 1  EF5350
    rgb_set_col 2  22DA6E
    rgb_set_col 3  ADDB67
    rgb_set_col 4  82AAFF
    rgb_set_col 5  C792EA
    rgb_set_col 6  21C7A8
    rgb_set_col 7  D6DEEB
    rgb_set_col 8  575656
    rgb_set_col 9  EF5350
    rgb_set_col 10 22DA6E
    rgb_set_col 11 FFEB95
    rgb_set_col 12 82AAFF
    rgb_set_col 13 C792EA
    rgb_set_col 14 7FDBCA
    rgb_set_col 15 FFFFFF
    rgb_set_bg 011627
    rgb_set_fg FFFFFF
} #}}}

function theme_zenburn { #{{{
    rgb_set_col 0  4d4d4d
    rgb_set_col 1  705050
    rgb_set_col 2  60b48a
    rgb_set_col 3  f0dfaf
    rgb_set_col 4  506070
    rgb_set_col 5  dc8cc3
    rgb_set_col 6  8cd0d3
    rgb_set_col 7  dcdccc
    rgb_set_col 8  709080
    rgb_set_col 9  dca3a3
    rgb_set_col 10 c3bf9f
    rgb_set_col 11 e0cf9f
    rgb_set_col 12 94bff3
    rgb_set_col 13 ec93d3
    rgb_set_col 14 93e0e3
    rgb_set_col 15 ffffff
    rgb_set_bg 3f3f3f
    rgb_set_fg dcdccc
} # }}}

function theme_wombat { #{{{
    rgb_set_col 0  000000
    rgb_set_col 1  ff615a
    rgb_set_col 2  b1e969
    rgb_set_col 3  ebd99c
    rgb_set_col 4  5da9f6
    rgb_set_col 5  e86aff
    rgb_set_col 6  82fff7
    rgb_set_col 7  dedacf
    rgb_set_col 8  313131
    rgb_set_col 9  f58c80
    rgb_set_col 10 ddf88f
    rgb_set_col 11 eee5b2
    rgb_set_col 12 a5c7ff
    rgb_set_col 13 ddaaff
    rgb_set_col 14 b7fff9
    rgb_set_col 15 ffffff
    rgb_set_bg 171717
    rgb_set_fg dedacf
} #}}}

function theme_twilight { #{{{
    rgb_set_col 0  141414
    rgb_set_col 1  c06d44
    rgb_set_col 2  afb97a
    rgb_set_col 3  c2a86c
    rgb_set_col 4  44474a
    rgb_set_col 5  b4be7c
    rgb_set_col 6  778385
    rgb_set_col 7  ffffd4
    rgb_set_col 8  262626
    rgb_set_col 9  de7c4c
    rgb_set_col 10 ccd88c
    rgb_set_col 11 e2c47e
    rgb_set_col 12 5a5e62
    rgb_set_col 13 d0dc8e
    rgb_set_col 14 8a989b
    rgb_set_col 15 ffffd4
    rgb_set_bg 141414
    rgb_set_fg ffffd4
} #}}}

function theme_tomorrow_night_eighties { #{{{
    rgb_set_col 0  000000
    rgb_set_col 1  F27779
    rgb_set_col 2  99CC99
    rgb_set_col 3  FFCC66
    rgb_set_col 4  6699CC
    rgb_set_col 5  CC99CC
    rgb_set_col 6  66CCCC
    rgb_set_col 7  FFFEFE
    rgb_set_col 8  000000
    rgb_set_col 9  F17779
    rgb_set_col 10 99CC99
    rgb_set_col 11 FFCC66
    rgb_set_col 12 6699CC
    rgb_set_col 13 CC99CC
    rgb_set_col 14 66CCCC
    rgb_set_col 15 FFFEFE
    rgb_set_bg 2C2C2C
    rgb_set_fg CCCCCC
} #}}}

function theme_terminix { #{{{
    rgb_set_col 0  282a2e
    rgb_set_col 1  a54242
    rgb_set_col 2  a1b56c
    rgb_set_col 3  de935f
    rgb_set_col 4  225555
    rgb_set_col 5  85678f
    rgb_set_col 6  5e8d87
    rgb_set_col 7  777777
    rgb_set_col 8  373b41
    rgb_set_col 9  c63535
    rgb_set_col 10 608360
    rgb_set_col 11 fa805a
    rgb_set_col 12 449da1
    rgb_set_col 13 ba8baf
    rgb_set_col 14 86c1b9
    rgb_set_col 15 c5c8c6
    rgb_set_bg 091116
    rgb_set_fg 868A8C
} #}}}

function theme_spacegray_eighties { #{{{
    rgb_set_col 0  15171c
    rgb_set_col 1  ec5f67
    rgb_set_col 2  81a764
    rgb_set_col 3  fec254
    rgb_set_col 4  5486c0
    rgb_set_col 5  bf83c1
    rgb_set_col 6  57c2c1
    rgb_set_col 7  efece7
    rgb_set_col 8  555555
    rgb_set_col 9  ff6973
    rgb_set_col 10 93d493
    rgb_set_col 11 ffd256
    rgb_set_col 12 4d84d1
    rgb_set_col 13 ff55ff
    rgb_set_col 14 83e9e4
    rgb_set_col 15 ffffff
    rgb_set_bg 222222
    rgb_set_fg bdbaae
} #}}}

function theme_spacedust { #{{{
    rgb_set_col 0  6e5346
    rgb_set_col 1  e35b00
    rgb_set_col 2  5cab96
    rgb_set_col 3  e3cd7b
    rgb_set_col 4  0f548b
    rgb_set_col 5  e35b00
    rgb_set_col 6  06afc7
    rgb_set_col 7  f0f1ce
    rgb_set_col 8  684c31
    rgb_set_col 9  ff8a3a
    rgb_set_col 10 aecab8
    rgb_set_col 11 ffc878
    rgb_set_col 12 67a0ce
    rgb_set_col 13 ff8a3a
    rgb_set_col 14 83a7b4
    rgb_set_col 15 fefff1
    rgb_set_bg 0a1e24
    rgb_set_fg ecf0c1
} #}}}

function theme_shel { #{{{
    rgb_set_col 0  2c2423
    rgb_set_col 1  ab2463
    rgb_set_col 2  6ca323
    rgb_set_col 3  ab6423
    rgb_set_col 4  2c64a2
    rgb_set_col 5  6c24a2
    rgb_set_col 6  2ca363
    rgb_set_col 7  918988
    rgb_set_col 8  918988
    rgb_set_col 9  f588b9
    rgb_set_col 10 c2ee86
    rgb_set_col 11 f5ba86
    rgb_set_col 12 8fbaec
    rgb_set_col 13 c288ec
    rgb_set_col 14 8feeb9
    rgb_set_col 15 f5eeec
    rgb_set_bg 2a201f
    rgb_set_fg 4882cd
} #}}}

function theme_seafoam_pastel { #{{{
    rgb_set_col 0  757575
    rgb_set_col 1  825d4d
    rgb_set_col 2  728c62
    rgb_set_col 3  ada16d
    rgb_set_col 4  4d7b82
    rgb_set_col 5  8a7267
    rgb_set_col 6  729494
    rgb_set_col 7  e0e0e0
    rgb_set_col 8  8a8a8a
    rgb_set_col 9  cf937a
    rgb_set_col 10 98d9aa
    rgb_set_col 11 fae79d
    rgb_set_col 12 7ac3cf
    rgb_set_col 13 d6b2a1
    rgb_set_col 14 ade0e0
    rgb_set_col 15 e0e0e0
    rgb_set_bg 243435
    rgb_set_fg d4e7d4
} #}}}

function theme_pnevma { #{{{
    rgb_set_col 0  2f2e2d
    rgb_set_col 1  a36666
    rgb_set_col 2  90a57d
    rgb_set_col 3  d7af87
    rgb_set_col 4  7fa5bd
    rgb_set_col 5  c79ec4
    rgb_set_col 6  8adbb4
    rgb_set_col 7  d0d0d0
    rgb_set_col 8  4a4845
    rgb_set_col 9  d78787
    rgb_set_col 10 afbea2
    rgb_set_col 11 e4c9af
    rgb_set_col 12 a1bdce
    rgb_set_col 13 d7beda
    rgb_set_col 14 b1e7dd
    rgb_set_col 15 efefef
    rgb_set_bg 1c1c1c
    rgb_set_fg d0d0d0
} #}}}

function theme_freya { #{{{
    rgb_set_col 0  073642
    rgb_set_col 1  dc322f
    rgb_set_col 2  859900
    rgb_set_col 3  b58900
    rgb_set_col 4  268bd2
    rgb_set_col 5  ec0048
    rgb_set_col 6  2aa198
    rgb_set_col 7  94a3a5
    rgb_set_col 8  586e75
    rgb_set_col 9  cb4b16
    rgb_set_col 10 859900
    rgb_set_col 11 b58900
    rgb_set_col 12 268bd2
    rgb_set_col 13 d33682
    rgb_set_col 14 2aa198
    rgb_set_col 15 6c71c4
    rgb_set_bg 252e32
    rgb_set_fg 94a3a5
} #}}}

function theme_hemisu { #{{{
    rgb_set_col 0  444444
    rgb_set_col 1  FF0054
    rgb_set_col 2  B1D630
    rgb_set_col 3  9D895E
    rgb_set_col 4  67BEE3
    rgb_set_col 5  B576BC
    rgb_set_col 6  569A9F
    rgb_set_col 7  EDEDED
    rgb_set_col 8  777777
    rgb_set_col 9  D65E75
    rgb_set_col 10 BAFFAA
    rgb_set_col 11 ECE1C8
    rgb_set_col 12 9FD3E5
    rgb_set_col 13 DEB3DF
    rgb_set_col 14 B6E0E5
    rgb_set_col 15 FFFFFF
    rgb_set_bg 000000
    rgb_set_fg FFFFFF
}

function theme_hybrid { #{{{
    rgb_set_col 0  282a2e
    rgb_set_col 1  A54242
    rgb_set_col 2  8C9440
    rgb_set_col 3  de935f
    rgb_set_col 4  5F819D
    rgb_set_col 5  85678F
    rgb_set_col 6  5E8D87
    rgb_set_col 7  969896
    rgb_set_col 8  373b41
    rgb_set_col 9  cc6666
    rgb_set_col 10 b5bd68
    rgb_set_col 11 f0c674
    rgb_set_col 12 81a2be
    rgb_set_col 13 b294bb
    rgb_set_col 14 8abeb7
    rgb_set_col 15 c5c8c6
    rgb_set_bg 141414
    rgb_set_fg 94a3a5
} #}}}

function theme_idle_toes { #{{{
    rgb_set_col 0  323232
    rgb_set_col 1  d25252
    rgb_set_col 2  7fe173
    rgb_set_col 3  ffc66d
    rgb_set_col 4  4099ff
    rgb_set_col 5  f680ff
    rgb_set_col 6  bed6ff
    rgb_set_col 7  eeeeec
    rgb_set_col 8  535353
    rgb_set_col 9  f07070
    rgb_set_col 10 9dff91
    rgb_set_col 11 ffe48b
    rgb_set_col 12 5eb7f7
    rgb_set_col 13 ff9dff
    rgb_set_col 14 dcf4ff
    rgb_set_col 15 ffffff
    rgb_set_bg 323232
    rgb_set_fg ffffff
} #}}}

function theme_ibm3270 { #{{{
    rgb_set_col 0  222222
    rgb_set_col 1  F01818
    rgb_set_col 2  24D830
    rgb_set_col 3  F0D824
    rgb_set_col 4  7890F0
    rgb_set_col 5  F078D8
    rgb_set_col 6  54E4E4
    rgb_set_col 7  A5A5A5
    rgb_set_col 8  888888
    rgb_set_col 9  EF8383
    rgb_set_col 10 7ED684
    rgb_set_col 11 EFE28B
    rgb_set_col 12 B3BFEF
    rgb_set_col 13 EFB3E3
    rgb_set_col 14 9CE2E2
    rgb_set_col 15 FFFFFF
    rgb_set_bg 000000
    rgb_set_fg FDFDFD
} #}}}

function theme_japanesque { #{{{
    rgb_set_col 0  343935
    rgb_set_col 1  cf3f61
    rgb_set_col 2  7bb75b
    rgb_set_col 3  e9b32a
    rgb_set_col 4  4c9ad4
    rgb_set_col 5  a57fc4
    rgb_set_col 6  389aad
    rgb_set_col 7  fafaf6
    rgb_set_col 8  595b59
    rgb_set_col 9  d18fa6
    rgb_set_col 10 767f2c
    rgb_set_col 11 78592f
    rgb_set_col 12 135979
    rgb_set_col 13 604291
    rgb_set_col 14 76bbca
    rgb_set_col 15 b2b5ae
    rgb_set_bg 1e1e1e
    rgb_set_fg f7f6ec
} #}}}

function theme_jellybeans { #{{{
    rgb_set_col 0  929292
    rgb_set_col 1  e27373
    rgb_set_col 2  94b979
    rgb_set_col 3  ffba7b
    rgb_set_col 4  97bedc
    rgb_set_col 5  e1c0fa
    rgb_set_col 6  00988e
    rgb_set_col 7  dedede
    rgb_set_col 8  bdbdbd
    rgb_set_col 9  ffa1a1
    rgb_set_col 10 bddeab
    rgb_set_col 11 ffdca0
    rgb_set_col 12 b1d8f6
    rgb_set_col 13 fbdaff
    rgb_set_col 14 1ab2a8
    rgb_set_col 15 ffffff
    rgb_set_bg 121212
    rgb_set_fg dedede
} #}}}

function theme_nighty { #{{{
    rgb_set_col 0  373D48
    rgb_set_col 1  9B3E46
    rgb_set_col 2  095B32
    rgb_set_col 3  808020
    rgb_set_col 4  1D3E6F
    rgb_set_col 5  823065
    rgb_set_col 6  3A7458
    rgb_set_col 7  828282
    rgb_set_col 8  5C6370
    rgb_set_col 9  D0555F
    rgb_set_col 10 119955
    rgb_set_col 11 DFE048
    rgb_set_col 12 4674B8
    rgb_set_col 13 ED86C9
    rgb_set_col 14 70D2A4
    rgb_set_col 15 DFDFDF
    rgb_set_bg 2F2F2F
    rgb_set_fg DFDFDF
} #}}}

function theme_nord { #{{{
    rgb_set_col 0  353535
    rgb_set_col 1  E64569
    rgb_set_col 2  89D287
    rgb_set_col 3  DAB752
    rgb_set_col 4  439ECF
    rgb_set_col 5  D961DC
    rgb_set_col 6  64AAAF
    rgb_set_col 7  B3B3B3
    rgb_set_col 8  535353
    rgb_set_col 9  E4859A
    rgb_set_col 10 A2CCA1
    rgb_set_col 11 E1E387
    rgb_set_col 12 6FBBE2
    rgb_set_col 13 E586E7
    rgb_set_col 14 96DCDA
    rgb_set_col 15 DEDEDE
    rgb_set_bg 353535
    rgb_set_fg DEDEDE
} #}}}

function theme_onedark { #{{{
    rgb_set_col 0  000000
    rgb_set_col 1  E06C75
    rgb_set_col 2  98C379
    rgb_set_col 3  D19A66
    rgb_set_col 4  61AFEF
    rgb_set_col 5  C678DD
    rgb_set_col 6  56B6C2
    rgb_set_col 7  ABB2BF
    rgb_set_col 8  5C6370
    rgb_set_col 9  E06C75
    rgb_set_col 10 98C379
    rgb_set_col 11 D19A66
    rgb_set_col 12 61AFEF
    rgb_set_col 13 C678DD
    rgb_set_col 14 56B6C2
    rgb_set_col 15 FFFEFE
    rgb_set_bg 1E2127
    rgb_set_fg ABB2BF
} #}}}


