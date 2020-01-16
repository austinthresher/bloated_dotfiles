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
    export BASH_BLACK_FG="$(rgbfg 40 40 40)"
    export BASH_BLACK_BG="$(rgbbg 146 131 116)"
    export BASH_RED_FG="$(rgbfg 251 73 52)"
    export BASH_RED_BG="$(rgbbg 204 36 29)"
    export BASH_GREEN_FG="$(rgbfg 184 187 38)"
    export BASH_GREEN_BG="$(rgbbg 152 151 26)"
    export BASH_YELLOW_FG="$(rgbfg 250 189 47)"
    export BASH_YELLOW_BG="$(rgbbg 215 153 33)"
    export BASH_BLUE_FG="$(rgbfg 131 165 152)"
    export BASH_BLUE_BG="$(rgbbg 69 133 136)"
    export BASH_MAGENTA_FG="$(rgbfg 211 134 155)"
    export BASH_MAGENTA_BG="$(rgbbg 177 98 134)"
    export BASH_CYAN_FG="$(rgbfg 142 192 124)"
    export BASH_CYAN_BG="$(rgbbg 104 157 106)"
    export BASH_WHITE_FG="$(rgbfg 235 219 178)"
    export BASH_WHITE_BG="$(rgbbg 168 153 132)"
    export TMUX_BLACK_FG="fg=#282828"
    export TMUX_BLACK_BG="bg=#928374"
    export TMUX_RED_FG="fg=#fb4934"
    export TMUX_RED_BG="bg=#cc241d"
    export TMUX_GREEN_FG="fg=#b8bb26"
    export TMUX_GREEN_BG="bg=#98971a"
    export TMUX_YELLOW_FG="fg=#fabd2f"
    export TMUX_YELLOW_BG="bg=#d79921"
    export TMUX_BLUE_FG="fg=#83a598"
    export TMUX_BLUE_BG="bg=#458588"
    export TMUX_MAGENTA_FG="fg=#d3869b"
    export TMUX_MAGENTA_BG="bg=#b16286"
    export TMUX_CYAN_FG="fg=#8ec07c"
    export TMUX_CYAN_BG="bg=#689d6a"
    export TMUX_WHITE_FG="fg=#ebdbb2"
    export TMUX_WHITE_BG="bg=#a89984"
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
    export PROMPT_COLOR=$BASH_CYAN_FG
    export TMUX_PRIMARY_FG=$TMUX_CYAN_FG
    export TMUX_PRIMARY_BG=$TMUX_CYAN_BG
    export TMUX_ACCENT_FG=$TMUX_MAGENTA_FG
    export TMUX_ACCENT_BG=$TMUX_MAGENTA_BG
    ;;
  blue)
    export PROMPT_COLOR=$BASH_BLUE_FG
    export TMUX_PRIMARY_FG=$TMUX_BLUE_FG
    export TMUX_PRIMARY_BG=$TMUX_BLUE_BG
    export TMUX_ACCENT_FG=$TMUX_YELLOW_FG
    export TMUX_ACCENT_BG=$TMUX_YELLOW_BG
    ;;
  red)
    export PROMPT_COLOR=$BASH_RED_FG
    export TMUX_PRIMARY_FG=$TMUX_RED_FG
    export TMUX_PRIMARY_BG=$TMUX_RED_BG
    export TMUX_ACCENT_FG=$TMUX_GREEN_FG
    export TMUX_ACCENT_BG=$TMUX_GREEN_BG
    ;;
esac
