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
    export BASH_BLACK_FG="$(color256fg 235)"
    export BASH_BLACK_BG="$(color256bg 234)"
    export BASH_RED_FG="$(color256fg 124)"
    export BASH_RED_BG="$(color256bg 167)"
    export BASH_GREEN_FG="$(color256fg 142)"
    export BASH_GREEN_BG="$(color256bg 106)"
    export BASH_YELLOW_FG="$(color256fg 214)"
    export BASH_YELLOW_BG="$(color256bg 172)"
    export BASH_BLUE_FG="$(color256fg 109)"
    export BASH_BLUE_BG="$(color256bg 66)"
    export BASH_MAGENTA_FG="$(color256fg 175)"
    export BASH_MAGENTA_BG="$(color256bg 132)"
    export BASH_CYAN_FG="$(color256fg 108)"
    export BASH_CYAN_BG="$(color256bg 72)"
    export BASH_WHITE_FG="$(color256fg 223)"
    export BASH_WHITE_BG="$(color256bg 246)"
    export TMUX_BLACK_FG="fg=colour235"
    export TMUX_BLACK_BG="bg=colour234"
    export TMUX_RED_FG="fg=colour124"
    export TMUX_RED_BG="bg=colour167"
    export TMUX_GREEN_FG="fg=colour142"
    export TMUX_GREEN_BG="bg=colour106"
    export TMUX_YELLOW_FG="fg=colour214"
    export TMUX_YELLOW_BG="bg=colour172"
    export TMUX_BLUE_FG="fg=colour109"
    export TMUX_BLUE_BG="bg=colour66"
    export TMUX_MAGENTA_FG="fg=colour175"
    export TMUX_MAGENTA_BG="bg=colour132"
    export TMUX_CYAN_FG="fg=colour108"
    export TMUX_CYAN_BG="bg=colour72"
    export TMUX_WHITE_FG="fg=colour223"
    export TMUX_WHITE_BG="bg=colour246"
    ;;
  24)
    export BASH_BLACK_FG="$(rgbfg 28 27 25)"
    export BASH_BLACK_BG="$(rgbbg 28 27 25)"
    export BASH_RED_FG="$(rgbfg 239 47 39)"
    export BASH_RED_BG="$(rgbbg 239 47 39)"
    export BASH_GREEN_FG="$(rgbfg 81 159 80)"
    export BASH_GREEN_BG="$(rgbbg 81 159 80)"
    export BASH_YELLOW_FG="$(rgbfg 251 184 41)"
    export BASH_YELLOW_BG="$(rgbbg 251 184 41)"
    export BASH_BLUE_FG="$(rgbfg 44 120 191)"
    export BASH_BLUE_BG="$(rgbbg 44 120 191)"
    export BASH_MAGENTA_FG="$(rgbfg 238 34 204)"
    export BASH_MAGENTA_BG="$(rgbbg 238 34 204)"
    export BASH_CYAN_FG="$(rgbfg 10 174 179)"
    export BASH_CYAN_BG="$(rgbbg 10 174 179)"
    export BASH_WHITE_FG="$(rgbfg 208 191 161)"
    export BASH_WHITE_BG="$(rgbbg 208 191 161)"
    export TMUX_BLACK_FG="fg=#1C1B19"
    export TMUX_BLACK_BG="bg=#1C1B19"
    export TMUX_RED_FG="fg=#F75341"
    export TMUX_RED_BG="bg=#F75341"
    export TMUX_GREEN_FG="fg=#419F50"
    export TMUX_GREEN_BG="bg=#419F50"
    export TMUX_YELLOW_FG="fg=#FBB829"
    export TMUX_YELLOW_BG="bg=#FBB829"
    export TMUX_BLUE_FG="fg=#2C78BF"
    export TMUX_BLUE_BG="bg=#2C78BF"
    export TMUX_MAGENTA_FG="fg=#E02C6D"
    export TMUX_MAGENTA_BG="bg=#E02C6D"
    export TMUX_CYAN_FG="fg=#0AAEB3"
    export TMUX_CYAN_BG="bg=#0AAEB3"
    export TMUX_WHITE_FG="fg=#D0BFA1"
    export TMUX_WHITE_BG="bg=#F0BFA1"
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
  yellow)
    export PROMPT_COLOR=$BASH_MAGENTA_FG
    export TMUX_PRIMARY_FG=$TMUX_YELLOW_FG
    export TMUX_PRIMARY_BG=$TMUX_YELLOW_BG
    export TMUX_ACCENT_FG=$TMUX_MAGENTA_FG
    export TMUX_ACCENT_BG=$TMUX_MAGENTA_BG
    ;;
  blue)
    export PROMPT_COLOR=$BASH_BLUE_FG
    export TMUX_PRIMARY_FG=$TMUX_CYAN_FG
    export TMUX_PRIMARY_BG=$TMUX_CYAN_BG
    export TMUX_ACCENT_FG=$TMUX_BLUE_FG
    export TMUX_ACCENT_BG=$TMUX_BLUE_BG
    ;;
  red)
    export PROMPT_COLOR=$BASH_RED_FG
    export TMUX_PRIMARY_FG=$TMUX_RED_FG
    export TMUX_PRIMARY_BG=$TMUX_RED_BG
    export TMUX_ACCENT_FG=$TMUX_GREEN_FG
    export TMUX_ACCENT_BG=$TMUX_GREEN_BG
    ;;
esac
