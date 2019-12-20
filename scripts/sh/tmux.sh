#!/bin/bash
function prepare_tmux() {
	
	if [ ! -z "$LIMITED_SPACE" ]; then
		export TMUX_DATE="%b %d"
		export TMUX_TIME="%l:%M"
		export TMUX_WINDOW_NAME=""
	else
		export TMUX_DATE="%A, %B %d"
		export TMUX_TIME="%l:%M %p"
		export TMUX_WINDOW_NAME=" #{window_name} "
	fi
	
	export TMUX_LEFT_CHARS=1
	export TMUX_RIGHT_CHARS=$( expr $SCREEN_WIDTH \* 3 / 2 )
	
	if loaded trap ; then
		export TMUX_PANE_PATH="#{pane_path}"
		export TMUX_PANE_TITLE="#{pane_title}"
	else
		export TMUX_PANE_PATH="#{pane_current_path}"
		export TMUX_PANE_TITLE="#{pane_current_command}"
	fi

  export TMUX_PUSH="#[push-default]${TMUX_BLACK_FG}"
  export TMUX_POP="#[default]#[pop-default]"

  export WINDOW_BG=$TMUX_BLACK_BG
  export WINDOW_FG="default"

  export SEPARATOR_FG=$TMUX_FG_COLOR
  export SEPARATOR_BG=$TMUX_BLACK_BG

  export INACTIVE_BG=$TMUX_WHITE_BG
  export INACTIVE_FG=$TMUX_BLACK_FG

  export NORM_FG=$TMUX_FG_COLOR
  export NORM_BG=$TMUX_BLACK

  export ALT_FG=$TMUX_BLACK_FG
  export ALT_BG=$TMUX_BG_COLOR

  export GRAY_BG=$TMUX_WHITE_BG
  export GRAY_FG=$TMUX_FG_COLOR

  export BRIGHT_BG=$TMUX_BG_COLOR
  export BRIGHT_FG=$TMUX_WHITE_FG

  export URGENT_BG=$TMUX_WHITE_BG
  export URGENT_FG=$TMUX_BLACK_FG

	source $HOME/.generated/tmux-powerline-env
}

function launch_tmux() {
  prepare_tmux
  if [ "$#" == 0 ]; then
    # If no arguments are given, try to attach to an existing session
    if $(which tmux) has-session &> /dev/null; then
      echo "attaching to session"
      sleep 0.25 #TODO: Round to 1 on platforms that don't support floats
      $(which tmux) attach
    else
      echo "creating new session"
      sleep 0.25
      $(which tmux)
    fi
  else
    $(which tmux) "$@"
  fi
}

alias tmux='launch_tmux'
