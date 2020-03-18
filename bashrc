[ -e "$HOME/.proxy" ] && source "$HOME/.proxy"
unset -f command_not_found_handle

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
else
    alias ls='ls -F --color=auto'

    if [[ $(hostname) == *wraeclast* ]]; then
        source "$HOME/.dotfiles/scripts/themes.sh"
        HOUR=$(date +%H)
        case $HOUR in
            05|06|07)
                # Early theme
                theme_zenburn
                ;;
            08|09|10)
                # Morning theme
                theme_seafoam_pastel
                ;;
            11|12|13)
                # Midday theme
                theme_espresso
                ;;
            14|15|16|17)
                # Afternoon theme
                theme_nord
                ;;
            18|19|20|21)
                # Evening theme
                theme_onedark
                ;;
            22|23|01|02|03|04)
                # Night theme
                theme_terminix
                ;;
        esac
    fi
fi

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
    printf "%-${WIDTH}s" "Bright on Normal"
    printf "\n"
    for n in {0..7}; do
        for m in {0..7}; do
            echo -n "$(colorbg $n)$(colorfg $m)${TEXT}"
        done
        printf "$SEP"
        for m in {0..7}; do
            echo -n "$(colorbg $n)$(brightfg $m)${TEXT}"
        done
        echo "$(norm)"
    done
    printf "%-${WIDTH}s" "Normal on Bright"
    printf "$SEP"
    printf "%-${WIDTH}s" "Bright on Bright"
    printf "\n"
    for n in {0..7}; do
        for m in {0..7}; do
            echo -n "$(brightbg $n)$(colorfg $m)${TEXT}"
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

export PATH="$HOME/.dotfiles/scripts:$HOME/go/bin:$PATH"
export EDITOR=vi
export VISUAL=vi
export PAGER=less

HASH=$(hostname | shasum)
SEED=$(echo $HASH | sed 's/[^0-9]//g')

# Predefined colors for specific hosts
case $HASH in
    938d55*)
        PROMPT_COLOR_IDX=4
        ;;
    cbccc7*)
        PROMPT_COLOR_IDX=2
        ;;
    *)
        # Randomize color based on hostname for all else
        PROMPT_COLOR_IDX=$(expr ${SEED:1:4} % 12 + 1)
        ;;
esac

# Map color index to escape sequences
case "$PROMPT_COLOR_IDX" in
    0)
        export TMUX_COLOR=black
        export PROMPT_COLOR=$(colorfg 0)
        ;;
    1)
        export TMUX_COLOR=red
        export PROMPT_COLOR=$(colorfg 1)
        ;;
    2)
        export TMUX_COLOR=green
        export PROMPT_COLOR=$(colorfg 2)
        ;;
    3)
        export TMUX_COLOR=yellow
        export PROMPT_COLOR=$(colorfg 3)
        ;;
    4)
        export TMUX_COLOR=blue
        export PROMPT_COLOR=$(colorfg 4)
        ;;
    5)
        export TMUX_COLOR=magenta
        export PROMPT_COLOR=$(colorfg 5)
        ;;
    6)
        export TMUX_COLOR=cyan
        export PROMPT_COLOR=$(colorfg 6)
        ;;
    7)
        export TMUX_COLOR=white
        export PROMPT_COLOR=$(colorfg 7)
        ;;
    8)
        export TMUX_COLOR=colour8
        export PROMPT_COLOR=$(brightfg 0)
        ;;
    9)
        export TMUX_COLOR=colour9
        export PROMPT_COLOR=$(brightfg 1)
        ;;
    10)
        export TMUX_COLOR=colour10
        export PROMPT_COLOR=$(brightfg 2)
        ;;
    11)
        export TMUX_COLOR=colour11
        export PROMPT_COLOR=$(brightfg 3)
        ;;
    12)
        export TMUX_COLOR=colour12
        export PROMPT_COLOR=$(brightfg 4)
        ;;
    13)
        export TMUX_COLOR=colour13
        export PROMPT_COLOR=$(brightfg 5)
        ;;
    14)
        export TMUX_COLOR=colour14
        export PROMPT_COLOR=$(brightfg 6)
        ;;
    15|*)
        export TMUX_COLOR=colour15
        export PROMPT_COLOR=$(brightfg 7)
        ;;
esac
export PS1="\[$PROMPT_COLOR\]\h \[$(reverse)\] \w \[$(norm)\] "
