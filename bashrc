[ -e "$HOME/.proxy" ] && source "$HOME/.proxy"
unset -f command_not_found_handle
export HISTCONTROL=ignoreboth:erasedups

case $- in
    *i*) # Interactive session
        # Ignore legacy scroll lock on <C-S> and <C-Q>
        stty -ixon
        ;;
    *) # Non interactive
        ;;
esac

if [[ $OSTYPE == *darwin* ]]; then
    alias ls='ls -F'
    export BASH_SILENCE_DEPRECATION_WARNING=1
else
    alias ls='ls -F --color=auto'
fi

if command -v vim &> /dev/null; then
    alias vi='vim -u ~/.virc'
fi
alias tmux='tmux -u'

if [ ! -z "$WSL_DISTRO_NAME" -o "${OSTYPE}" == cygwin ]; then
    export WINDOWS=1
    # If we're on WSL, assume there's an X server running
    if [ -z "$DISPLAY" ]; then
        export DISPLAY=0:0
    fi
fi

if command -v mdvl &> /dev/null; then
    alias md='mdvl'
fi

export SCREENDIR="$HOME/.screen"
[ ! -d "$SCREENDIR" ] && mkdir "$SCREENDIR"

function norm    { printf "\e[0m"; }
function bold    { printf "\e[1m"; }
function reverse { printf "\e[7m"; }
function noreverse { printf "\e[27m"; }
function under   { printf "\e[4m"; }
function colorfg { printf "\e[3$1m"; }
function colorbg { printf "\e[4$1m"; }
function brightfg { printf "\e[9$1m"; }
function brightbg { printf "\e[10$1m"; }

function colortest {
    local TEXT=" Test "
    local SEP="$(norm)    "
    local WIDTH=$(expr 8 \* ${#TEXT})
    printf "%-${WIDTH}s" "Normal on Normal"
    printf "$SEP"
    printf "%-${WIDTH}s" "Normal on Bright"
    printf "\n"
    for n in {0..7}; do
        for m in {0..7}; do
            echo -n "$(colorbg $n)$(colorfg $m)${TEXT}"
        done
        printf "$SEP"
        for m in {0..7}; do
            echo -n "$(brightbg $n)$(colorfg $m)${TEXT}"
        done
        echo "$(norm)"
    done
    printf "%-${WIDTH}s" "Bright on Normal"
    printf "$SEP"
    printf "%-${WIDTH}s" "Bright on Bright"
    printf "\n"
    for n in {0..7}; do
        for m in {0..7}; do
            echo -n "$(colorbg $n)$(brightfg $m)${TEXT}"
        done
        printf "$SEP"
        for m in {0..7}; do
            echo -n "$(brightbg $n)$(brightfg $m)${TEXT}"
        done
        echo "$(norm)"
    done
}

alias rgrep='grep -Iirn'
alias more='less'
alias gdb='gdb -q'
alias preview='feh --scale -d . &'
if [ ! -z "$WSL_DISTRO_NAME" ]; then
    alias st='env -i LANG=$LANG HOME=$HOME DISPLAY=${DISPLAY:-:0.0} WSL_DISTRO_NAME=$WSL_DISTRO_NAME ST=1 $(which st) -e /bin/bash -l'
else
    alias st='env -i LANG=$LANG HOME=$HOME DISPLAY=${DISPLAY:-:0.0} $(which st) -e /bin/bash -l'
fi

export EDITOR=vi
export VISUAL=vi
export PAGER=less
export PATH="$HOME/.dotfiles/scripts:$HOME/go/bin:$PATH"

# Configure homebrew paths if present
if command -v brew 2>&1 > /dev/null; then
    BREWPATH="$(brew --prefix)"
else
    BREWPATH="$HOME/homebrew"
fi

if [ -d "$BREWPATH/bin" ] ; then
    PATH="$BREWPATH/bin:$PATH"
fi

# The rest of the file picks a "theme" color for
# the shell and tmux based on the hostname

# Accepts a single string and writes a hash to stdout
function simple_hash {
    # Assign all letters an arbitrary number value
    local num=$(echo "$1" \
        | sed -e 's/[^A-Za-z0-9]//g' \
        | tr ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz \
             123456789ABCDEF123456789ABCDEF123456789ABCDEF1234567)

    local hashed=1
    # Ghetto for loop to compute a hash, hash function taken from:
    # https://stackoverflow.com/a/107657
    seq ${#num} | while read i; do
        local digit="${num:$i:1}"
        if [ ! -z "$digit" ]; then
            local b16="0x${digit}"
            hashed=$((hashed * 101 + b16))
        else
            echo $hashed
        fi
    done
}

# Predefined colors for specific hosts
case $(simple_hash $(hostname -f)) in
    # work
    "2000859944153293065") PROMPT_COLOR_IDX=10 ;;
    "4252336200651278864") PROMPT_COLOR_IDX=4  ;;
    # home
    "5262292903289373391") PROMPT_COLOR_IDX=1  ;;
    "1105816367849791686") PROMPT_COLOR_IDX=6  ;; 
    "7435254907764971302") PROMPT_COLOR_IDX=3  ;;
    "3634829238533771921") PROMPT_COLOR_IDX=5  ;;
    *)
        # Randomize color based on hostname for all else
        PROMPT_COLOR_IDX=$(expr $(simple_hash $(hostname)) % 12 + 1)
        ;;
esac

# Map color index to escape sequences
case "$PROMPT_COLOR_IDX" in
    0) # black
        export TMUX_COLOR=black
        export PROMPT_COLOR=$(colorfg 0)
        ;;
    1) # red
        export TMUX_COLOR=red
        export PROMPT_COLOR=$(colorfg 1)
        ;;
    2) # green
        export TMUX_COLOR=green
        export PROMPT_COLOR=$(colorfg 2)
        ;;
    3) # yellow
        export TMUX_COLOR=yellow
        export PROMPT_COLOR=$(colorfg 3)
        ;;
    4) # blue
        export TMUX_COLOR=blue
        export PROMPT_COLOR=$(colorfg 4)
        ;;
    5) # magenta
        export TMUX_COLOR=magenta
        export PROMPT_COLOR=$(colorfg 5)
        ;;
    6) # cyan
        export TMUX_COLOR=cyan
        export PROMPT_COLOR=$(colorfg 6)
        ;;
    7) # white (light grey)
        export TMUX_COLOR=white
        export PROMPT_COLOR=$(colorfg 7)
        ;;
    8) # bright black (dark grey)
        export TMUX_COLOR=colour8
        export PROMPT_COLOR=$(brightfg 0)
        ;;
    9) # bright red
        export TMUX_COLOR=colour9
        export PROMPT_COLOR=$(brightfg 1)
        ;;
    10) # bright green
        export TMUX_COLOR=colour10
        export PROMPT_COLOR=$(brightfg 2)
        ;;
    11) # bright yellow
        export TMUX_COLOR=colour11
        export PROMPT_COLOR=$(brightfg 3)
        ;;
    12) # bright blue
        export TMUX_COLOR=colour12
        export PROMPT_COLOR=$(brightfg 4)
        ;;
    13) # bright magenta
        export TMUX_COLOR=colour13
        export PROMPT_COLOR=$(brightfg 5)
        ;;
    14) # bright cyan
        export TMUX_COLOR=colour14
        export PROMPT_COLOR=$(brightfg 6)
        ;;
    15|*) # bright white
        export TMUX_COLOR=colour15
        export PROMPT_COLOR=$(brightfg 7)
        ;;
esac
export PS1="\[$PROMPT_COLOR\]\u @ \h \[$(reverse)\] \w \[$(norm)\] "

