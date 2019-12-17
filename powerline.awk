BEGIN {
	n_styles = split("OUTER INFO STATUS ACTIVE BELL ", styles, " ")
	for (i=1;i<=n_styles;i++) {
		short_styles[i] = substr(styles[i],1,1)
	}
	for (i=1;i<=n_styles;i++) {
		print("BG_USE_" styles[i] "_BG=#[bg=$" styles[i] "_BG]")
		print("BG_USE_" styles[i] "_FG=#[bg=$" styles[i] "_FG]")
		print("FG_USE_" styles[i] "_BG=#[fg=$" styles[i] "_BG]")
		print("FG_USE_" styles[i] "_FG=#[fg=$" styles[i] "_FG]")
		print(styles[i] "=$BG_USE_" styles[i] "_BG$FG_USE_" styles[i] "_FG")
	}
	for (i=1;i<=n_styles;i++) {
		for (j=1;j<=n_styles;j++) {
			print(short_styles[i] "_R_" short_styles[j] "=$FG_USE_" styles[i] "_BG$BG_USE_" styles[j] "_BG$POWERLINE_FILLED_RIGHT$FG_USE_" styles[j] "_FG")	
			print(short_styles[i] "_L_" short_styles[j] "=$FG_USE_" styles[i] "_BG$BG_USE_" styles[j] "_BG$POWERLINE_FILLED_LEFT$FG_USE_" styles[j] "_FG")	
		}
	}
}
