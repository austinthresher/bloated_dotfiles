#!/bin/bash

function git_branch() {
	git branch 2> /dev/null | sed '/^[^*]/d;s/* \(.*\)/\1/'
}

function git_repo() {
	git remote -v 2> /dev/null | sed \
		-e '1s/.*\/\(.*\)\.git.*/\1/;1s/.*\/\(.*\) .*$/\1/;2d'
}

function git_changes() {
	git status 2> /dev/null | sed \
		-e '/^Changes/!d' \
		-e 's/^Changes not.*$/\-/g' \
		-e 's/^Changes to.*$/\+/g' \
		| tr -d "\n" \
		| sed -e 's/+-/±/'
}

function git_prompt() {
	if [ ! -z "$PS1_GIT" ]; then
		_R=$(git_repo)
		_B=$(git_branch)
		_C=$(git_changes)
		_P=$(printf "%s" $(git_repo)/$(git_branch)$(git_changes))
		if [ "${#_R}" != "0" ]; then
			printf "❰%s/%s%s❱" "$_R" "$_B" "$_C"
		fi
	fi
}
