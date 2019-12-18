# Generate all transition pairs for powerline symbols in tmux. Expects
# environment variables to exist for each style used, where STYLE_FG is the
# foreground color for the style naemd 'style' and STYLE_BG is the background.
#
# Each style should start with a unique letter. This script creates
# environment variables named X_R_Y and X_L_Y, where X is the 'from' style and
# Y is the 'to' style, and the letter in the middle indicates the powerline
# arrow's direction. The variables $POWERLINE_FILLED_RIGHT and LEFT should
# contain the desired character to use for the transition. Variables named
# STYLE are also created to set both BG and FG at once.
#
# Additionally, R_RV, R_NO, L_RV, and L_NO are defined to create powerline
# transitions by turning on reverse video instead of changing styles.

BEGIN {
	n_styles = split("WINDOW SEPARATOR INACTIVE NORM ALT GRAY BRIGHT URGENT ", styles, " ")
	for (i=1;i<=n_styles;i++) {
		short_styles[i] = substr(styles[i],1,1)
	}
  # BG_USE_STYLE_BG expands to #[bg=$STYLE_BG]
  # BG_USE_STYLE_FG expands to #[bg=$STYLE_FG]
  # FG_USE_STYLE_BG expands to #[fg=$STYLE_BG]
  # FG_USE_STYLE_FG expands to #[fg=$STYLE_FG]
	for (i=1;i<=n_styles;i++) {
		print("BG_USE_" styles[i] "_BG=#[bg=$" styles[i] "_BG]")
		print("BG_USE_" styles[i] "_FG=#[bg=$" styles[i] "_FG]")
		print("FG_USE_" styles[i] "_BG=#[fg=$" styles[i] "_BG]")
		print("FG_USE_" styles[i] "_FG=#[fg=$" styles[i] "_FG]")
		print("export " styles[i] "=$BG_USE_" styles[i] "_BG$FG_USE_" styles[i] "_FG")
	}
	for (i=1;i<=n_styles;i++) {
		for (j=1;j<=n_styles;j++) {
      # Transition from style[i] to style[j], left to right
      left_style = styles[i]
      left_short = short_styles[i]
      right_style = styles[j]
      right_short = short_styles[j]
      name_r = left_short "_R_" right_short
      name_l = left_short "_L_" right_short

      if (left_style != right_style) {
        # Right arrow
        # BG of char is on right, FG on left, so:
        #   FG = left style bg
        #   BG = right style bg
        from_r = "${FG_USE_" left_style "_BG}" "${BG_USE_" right_style "_BG}"
        to_r = "${" right_style "}"
        print("export " name_r "=\"" from_r "$POWERLINE_FILLED_RIGHT" to_r "\"")

        # Left arrow
        # BG of char is on left, FG on right, so:
        #   FG = right style bg
        #   BG = left style bg
        from_l = "${FG_USE_" right_style "_BG}" "${BG_USE_" left_style "_BG}"
        to_l = "${" right_style "}"
        print("export " name_l "=\"" from_l "$POWERLINE_FILLED_LEFT" to_l "\"")
      } else {
        # Non-filled versions
        print("export " name_r "=\"$POWERLINE_RIGHT\"")
        print("export " name_l "=\"$POWERLINE_LEFT\"")
      }
		}
	}
	print("export R_RV=\"#[reverse]$POWERLINE_FILLED_RIGHT\"")
	print("export R_NO=\"#[noreverse]$POWERLINE_FILLED_RIGHT\"")
	print("export L_RV=\"$POWERLINE_FILLED_LEFT#[reverse]\"")
	print("export L_NO=\"$POWERLINE_FILLED_LEFT#[noreverse]\"")
}
