#!/bin/bash

if require rgb_color ; then
	export TMUX_LOCAL_PRIMARY_COLOR="#407350"
	export TMUX_LOCAL_ACCENT_COLOR="#66EC96"
	export TMUX_REMOTE_PRIMARY_COLOR="#732020#"
	export TMUX_REMOTE_ACCENT_COLOR="#CC6666#"
	export TMUX_BLACK="colour0"
	export TMUX_GRAY="colour8"
	export TMUX_WHITE="colour15"
elif require color ; then
	export TMUX_LOCAL_PRIMARY_COLOR="colour2"
	export TMUX_LOCAL_ACCENT_COLOR="colour10"
	export TMUX_REMOTE_PRIMARY_COLOR="colour1"
	export TMUX_REMOTE_ACCENT_COLOR="colour9"
	export TMUX_BLACK="colour0"
	export TMUX_GRAY="colour8"
	export TMUX_WHITE="colour15"
else
	export TMUX_LOCAL_PRIMARY_COLOR="default"
	export TMUX_LOCAL_ACCENT_COLOR="default"
	export TMUX_REMOTE_PRIMARY_COLOR="default"
	export TMUX_REMOTE_ACCENT_COLOR="default"
	export TMUX_BLACK="default"
	export TMUX_GRAY="default"
	export TMUX_WHITE="default"
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

export TMUX_LEFT_CHARS=$( expr $SCREEN_WIDTH / 2 + 8 )
export TMUX_RIGHT_CHARS=$( expr $SCREEN_WIDTH / 3 )

if require hook_pre ; then
	export TMUX_PANE_PATH="#{pane_path}"
	export TMUX_PANE_TITLE="#{pane_title}"
else
	export TMUX_PANE_PATH="#{pane_current_path}"
	export TMUX_PANE_TITLE="#{pane_current_command}"
fi
