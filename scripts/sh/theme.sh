if [ -z "$THEME" ]; then
  export THEME="blue"
fi

case "$COLORS" in
  8)
    export BASH_BLACK_FG="$(color $COL_FG_BLACK)"
    export BASH_BLACK_BG="$(color $COL_BG_BLACK)"
    export BASH_RED_FG="$(color $COL_FG_RED)"
    export BASH_RED_BG="$(color $COL_BG_RED)"
    export BASH_GREEN_FG="$(color $COL_FG_GREEN)"
    export BASH_GREEN_BG="$(color $COL_BG_GREEN)"
    export BASH_YELLOW_FG="$(color $COL_FG_YELLOW)"
    export BASH_YELLOW_BG="$(color $COL_BG_YELLOW)"
    export BASH_BLUE_FG="$(color $COL_FG_BLUE)"
    export BASH_BLUE_BG="$(color $COL_BG_BLUE)"
    export BASH_MAGENTA_FG="$(color $COL_FG_MAGENTA)"
    export BASH_MAGENTA_BG="$(color $COL_BG_MAGENTA)"
    export BASH_CYAN_FG="$(color $COL_FG_CYAN)"
    export BASH_CYAN_BG="$(color $COL_BG_CYAN)"
    export BASH_WHITE_FG="$(color $COL_FG_WHITE)"
    export BASH_WHITE_BG="$(color $COL_BG_WHITE)"
    export TMUX_BLACK_FG="fg=0"
    export TMUX_BLACK_BG="bg=0"
    export TMUX_RED_FG="fg=1"
    export TMUX_RED_BG="bg=1"
    export TMUX_GREEN_FG="fg=2"
    export TMUX_GREEN_BG="bg=2"
    export TMUX_YELLOW_FG="fg=3"
    export TMUX_YELLOW_BG="bg=3"
    export TMUX_BLUE_FG="fg=4"
    export TMUX_BLUE_BG="bg=4"
    export TMUX_MAGENTA_FG="fg=5"
    export TMUX_MAGENTA_BG="bg=5"
    export TMUX_CYAN_FG="fg=6"
    export TMUX_CYAN_BG="bg=6"
    export TMUX_WHITE_FG="fg=7"
    export TMUX_WHITE_BG="bg=7"
    ;;
  256)
    export BASH_BLACK_FG="$(color256fg 236)"
    export BASH_BLACK_BG="$(color256bg 232)"
    export BASH_RED_FG="$(color256fg 124)"
    export BASH_RED_BG="$(color256bg 52)"
    export BASH_GREEN_FG="$(color256fg 35)"
    export BASH_GREEN_BG="$(color256bg 22)"
    export BASH_YELLOW_FG="$(color256fg 184)"
    export BASH_YELLOW_BG="$(color256bg 94)"
    export BASH_BLUE_FG="$(color256fg 32)"
    export BASH_BLUE_BG="$(color256bg 17)"
    export BASH_MAGENTA_FG="$(color256fg 129)"
    export BASH_MAGENTA_BG="$(color256bg 91)"
    export BASH_CYAN_FG="$(color256fg 122)"
    export BASH_CYAN_BG="$(color256bg 30)"
    export BASH_WHITE_FG="$(color256fg 231)"
    export BASH_WHITE_BG="$(color256bg 253)"
    export TMUX_BLACK_FG="fg=colour236"
    export TMUX_BLACK_BG="bg=colour232"
    export TMUX_RED_FG="fg=colour124"
    export TMUX_RED_BG="bg=colour52"
    export TMUX_GREEN_FG="fg=colour35"
    export TMUX_GREEN_BG="bg=colour22"
    export TMUX_YELLOW_FG="fg=colour184"
    export TMUX_YELLOW_BG="bg=colour94"
    export TMUX_BLUE_FG="fg=colour32"
    export TMUX_BLUE_BG="bg=colour17"
    export TMUX_MAGENTA_FG="fg=colour129"
    export TMUX_MAGENTA_BG="bg=colour91"
    export TMUX_CYAN_FG="fg=colour122"
    export TMUX_CYAN_BG="bg=colour30"
    export TMUX_WHITE_FG="fg=colour231"
    export TMUX_WHITE_BG="bg=colour253"
    ;;
  24)
    export BASH_BLACK_FG="$(rgbfg 32 32 32)"
    export BASH_BLACK_BG="$(rgbbg 16 16 16)"
    export BASH_RED_FG="$(rgbfg 204 102 102)"
    export BASH_RED_BG="$(rgbbg 115 32 32)"
    export BASH_GREEN_FG="$(rgbfg 102 236 150)"
    export BASH_GREEN_BG="$(rgbbg 64 115 80)"
    export BASH_YELLOW_FG="$(rgbfg 150 150 102)"
    export BASH_YELLOW_BG="$(rgbbg 115 115 32)"
    export BASH_BLUE_FG="$(rgbfg 102 150 236)"
    export BASH_BLUE_BG="$(rgbbg 64 80 115)"
    export BASH_MAGENTA_FG="$(rgbfg 150 102 150)"
    export BASH_MAGENTA_BG="$(rgbbg 115 32 115)"
    export BASH_CYAN_FG="$(rgbfg 150 102 150)"
    export BASH_CYAN_BG="$(rgbbg 32 115 115)"
    export BASH_WHITE_FG="$(rgbfg 255 255 255)"
    export BASH_WHITE_BG="$(rgbbg 240 240 240)"
    export TMUX_BLACK_FG="fg=#202020"
    export TMUX_BLACK_BG="bg=#101010"
    export TMUX_RED_FG="fg=#cc6666"
    export TMUX_RED_BG="bg=#732020"
    export TMUX_GREEN_FG="fg=#66ec96"
    export TMUX_GREEN_BG="bg=#407350"
    export TMUX_YELLOW_FG="fg=#969666"
    export TMUX_YELLOW_BG="bg=#737320"
    export TMUX_BLUE_FG="fg=#6696eC"
    export TMUX_BLUE_BG="bg=#405073"
    export TMUX_MAGENTA_FG="fg=#966696"
    export TMUX_MAGENTA_BG="bg=#732073"
    export TMUX_CYAN_FG="fg=#669696"
    export TMUX_CYAN_BG="bg=#207373"
    export TMUX_WHITE_FG="fg=#ffffff"
    export TMUX_WHITE_BG="bg=#f0f0f0"
    ;;
  *)
    export TMUX_BLACK_FG="default"
    export TMUX_BLACK_BG="default"
    export TMUX_RED_FG="default"
    export TMUX_RED_BG="default"
    export TMUX_GREEN_FG="default"
    export TMUX_GREEN_BG="default"
    export TMUX_YELLOW_FG="default"
    export TMUX_YELLOW_BG="default"
    export TMUX_BLUE_FG="default"
    export TMUX_BLUE_BG="default"
    export TMUX_MAGENTA_FG="default"
    export TMUX_MAGENTA_BG="default"
    export TMUX_CYAN_FG="default"
    export TMUX_CYAN_BG="default"
    export TMUX_WHITE_FG="default"
    export TMUX_WHITE_BG="default"
    ;;
esac

case "$THEME" in
  green)
    export PROMPT_COLOR=$BASH_GREEN_FG
    export TMUX_PRIMARY_FG=$TMUX_GREEN_FG
    export TMUX_PRIMARY_BG=$TMUX_GREEN_BG
    export TMUX_ACCENT_FG=$TMUX_MAGENTA_FG
    export TMUX_ACCENT_BG=$TMUX_MAGENTA_BG
    ;;
  blue)
    export PROMPT_COLOR=$BASH_BLUE_FG
    export TMUX_PRIMARY_FG=$TMUX_BLUE_FG
    export TMUX_PRIMARY_BG=$TMUX_BLUE_BG
    export TMUX_ACCENT_FG=$TMUX_CYAN_FG
    export TMUX_ACCENT_BG=$TMUX_CYAN_BG
    ;;
  red)
    export PROMPT_COLOR=$BASH_RED_FG
    export TMUX_PRIMARY_FG=$TMUX_RED_FG
    export TMUX_PRIMARY_BG=$TMUX_RED_BG
    export TMUX_ACCENT_FG=$TMUX_GREEN_FG
    export TMUX_ACCENT_BG=$TMUX_GREEN_BG
    ;;
esac
