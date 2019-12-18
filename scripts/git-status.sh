#!/bin/bash
source $HOME/.dotfiles/scripts/sh/git.sh
printf "#[push-default]#[fg=$TMUX_ICON_COLOR]$GIT_ICON#[default]#[pop-default]"
git_prompt
printf " "
