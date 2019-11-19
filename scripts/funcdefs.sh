#!/bin/bash

# include guard
[ -n "$FUNCDEFS" ] && return || readonly FUNCDEFS=1

# private / non-exported functions
ghetto_cut() {
	for i in $1; do echo $i; break; done
}

#public / exported functions

# https://stackoverflow.com/questions/59895/get-the-source-directory-of-a-bash-script-from-within-the-script-itself
get_script_dir() {
	printf "%s" "$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
}
export -f get_script_dir

# DIY simple package installer, backpack 
# ======================================

bp_init() {
	export LOCAL_PREFIX="$HOME/.local"
	export LOCAL_BIN=$LOCAL_PREFIX/bin
	export LOCAL_SRC=$LOCAL_PREFIX/src
	export LOCAL_TMP=$LOCAL_PREFIX/tmp
	mkdir -p $LOCAL_BIN
	mkdir -p $LOCAL_SRC
	mkdir -p $LOCAL_TMP
	export SELECTED_PKGS=$@
	export BP_CMD=none
}

bp_command() {
	case $1 in
		"install"|"uninstall"|"reinstall")
			export BP_CMD=$1
			;;
		*)
			echo "Unrecognized command: $1"
			exit 1
			;;
	esac
}

bp_process() {
	if [ "$BP_CMD" == "none" ]; then
		echo "No command given"
		exit 1
	fi
	source $1
}

bp_package() {
	if [[ " $SELECTED_PKGS " =~ .*\ $1\ .* || -z "$SELECTED_PKGS" ]]; then
		export PKG_NAME=$1
		export PKG_URL=$2
		export SRC_DEST=$LOCAL_SRC/$PKG_NAME
		export BIN_DEST=$LOCAL_BIN/$PKG_NAME
		case $BP_CMD in
			"reinstall")
				printf "reinstalling package '$PKG_NAME'"
				bp_remove_existing
				bp_fetch_tar $PKG_URL
				bp_configure_make_install "${@:3}"
				;;
			"install")
				printf "installing package '$PKG_NAME'"
				bp_fetch_tar $PKG_URL			
				bp_configure_make_install "${@:3}"
				;;
			"uninstall")
				printf "uninstalling package '$PKG_NAME'"
				bp_make_uninstall
				;;
			*)
				echo "Unrecognized command: $BP_CMD"
				exit 1
				;;
		esac
	fi
}
export -f bp_package

bp_remove_existing() {
	[ -e "$SRC_DEST" ] && rm -rf "$SRC_DEST"
}

bp_fetch_git() {
	{
		[ ! -e "$SRC_DEST" ] \
			&& git clone "https://github.com/$1" "$SRC_DEST"
	}	>  $LOCAL_TMP/$PKG_NAME.fetch.out \
		2> $LOCAL_TMP/$PKG_NAME.fetch.err
}

bp_fetch_tar() {
	{
		FNAME=${1##*\/}
		[ ! -e "$SRC_DEST" ] && mkdir -p "$SRC_DEST"
		[ ! -e "$LOCAL_TMP/$FNAME" ] && wget -P "$LOCAL_TMP" "$1"
		tar --extract --overwrite --file="$LOCAL_TMP/$FNAME" --directory="$SRC_DEST"
		# Assume a single directory was extracted, try to get its name
		NEW_DIR=$(ghetto_cut $(ls -t -w 0 --hide=*.tar* "$SRC_DEST"))
		# Move all of its contents one directory up
		cd "$SRC_DEST/$NEW_DIR" \
			&& mv * ../ \
			&& cd .. \
			&& rmdir "$SRC_DEST/$NEW_DIR"
	}	>  $LOCAL_TMP/$PKG_NAME.fetch.out \
		2> $LOCAL_TMP/$PKG_NAME.fetch.err
}

bp_make_uninstall() {
	export SUCCESS=0
	{
		cd "$SRC_DEST" \
		&& ./configure --prefix=$LOCAL_PREFIX $@\
		&& make -j uninstall \
		&& export SUCCESS=1
	}	>  $LOCAL_TMP/$PKG_NAME.make.out \
		2> $LOCAL_TMP/$PKG_NAME.make.err
	bp_remove_existing
	if [ "$SUCCESS" -eq 0 ]; then
		printf " failed. Logs written to $LOCAL_TMP\n"
	else
		printf " completed\n"
	fi
}

bp_configure_make_install() {
	export SUCCESS=0
	{
		cd "$SRC_DEST" 
		if [ -e "configure" ]; then
			./configure --prefix=$LOCAL_PREFIX $@\
			&& make -j \
			&& make install \
			&& export SUCCESS=1
		elif [ -e "autogen.sh" ]; then
			./autogen.sh \
			&& ./configure --prefix=$LOCAL_PREFIX $@\
			&& make -j \
			&& make install \
			&& export SUCCESS=1
		fi
	}	>  $LOCAL_TMP/$PKG_NAME.make.out \
		2> $LOCAL_TMP/$PKG_NAME.make.err
	if [ "$SUCCESS" -eq 0 ]; then
		printf " failed. Logs written to $LOCAL_TMP\n"
	else
		printf " completed\n" 
	fi
}
