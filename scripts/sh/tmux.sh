#!/bin/bash
function prepare_tmux() {
	if require rgb_color ; then
		export TMUX_LOCAL_PRIMARY_COLOR="#407350"
		export TMUX_LOCAL_ACCENT_COLOR="#66EC96"
		export TMUX_REMOTE_PRIMARY_COLOR="#732020"
		export TMUX_REMOTE_ACCENT_COLOR="#CC6666"
		export TMUX_BLACK="colour0"
		export TMUX_GRAY="colour8"
		export TMUX_WHITE="colour15"
		export TMUX_LOCAL_WINDOW_COLOR="#051007"
		export TMUX_LOCAL_SEPARATOR_COLOR="#020603"
	elif require color ; then
		export TMUX_LOCAL_PRIMARY_COLOR="colour2"
		export TMUX_LOCAL_ACCENT_COLOR="colour10"
		export TMUX_REMOTE_PRIMARY_COLOR="colour1"
		export TMUX_REMOTE_ACCENT_COLOR="colour9"
		export TMUX_BLACK="colour0"
		export TMUX_GRAY="colour8"
		export TMUX_WHITE="colour15"
		export TMUX_LOCAL_WINDOW_COLOR="colour0"
		export TMUX_LOCAL_SEPARATOR_COLOR="colour236"
	else
		export TMUX_LOCAL_PRIMARY_COLOR="default"
		export TMUX_LOCAL_ACCENT_COLOR="default"
		export TMUX_REMOTE_PRIMARY_COLOR="default"
		export TMUX_REMOTE_ACCENT_COLOR="default"
		export TMUX_BLACK="default"
		export TMUX_GRAY="default"
		export TMUX_WHITE="default"
		export TMUX_LOCAL_WINDOW_COLOR="default"
		export TMUX_LOCAL_SEPARATOR_COLOR="default"
	fi
	
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
  # TODO: check SSH_CLIENT
  export TMUX_SEPARATOR_COLOR=$TMUX_LOCAL_SEPARATOR_COLOR
  export TMUX_ACCENT_COLOR=$TMUX_LOCAL_ACCENT_COLOR
  export TMUX_PRIMARY_COLOR=$TMUX_LOCAL_PRIMARY_COLOR
  export TMUX_WINDOW_COLOR=$TMUX_LOCAL_WINDOW_COLOR
  export TMUX_ICON_COLOR=$TMUX_BLACK

  export TMUX_PUSH="#[push-default]#[fg=$TMUX_ICON_COLOR]"
  export TMUX_POP="#[default]#[pop-default]"

  export WINDOW_BG=$TMUX_WINDOW_COLOR
  export WINDOW_FG="default"

  export SEPARATOR_FG=$TMUX_SEPARATOR_COLOR
  export SEPARATOR_BG=$TMUX_SEPARATOR_COLOR

  export INACTIVE_BG=$TMUX_GRAY
  export INACTIVE_FG=$TMUX_BLACK

  export NORM_FG=$TMUX_LOCAL_PRIMARY_COLOR
  export NORM_BG=$TMUX_BLACK

  export ALT_FG=$TMUX_LOCAL_ACCENT_COLOR
  export ALT_BG=$TMUX_LOCAL_PRIMARY_COLOR

  export GRAY_BG=$TMUX_GRAY
  export GRAY_FG=$TMUX_LOCAL_ACCENT_COLOR

  export BRIGHT_BG=$TMUX_LOCAL_ACCENT_COLOR
  export BRIGHT_FG=$TMUX_BLACK

  export URGENT_BG=$TMUX_WHITE
  export URGENT_FG=$TMUX_BLACK

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
