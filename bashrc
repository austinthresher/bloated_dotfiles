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


PROMPT_COLOR=2
if [ ! -z "$SSH_CLIENT" ]; then
    PROMPT_COLOR=$(expr $PROMPT_COLOR \+ 1)
fi
if [ -z "$TMUX" ]; then
    TMUX_PROMPT_COLOR=$PROMPT_COLOR
    PROMPT_COLOR=$(expr $PROMPT_COLOR \- 1)
else
    TMUX_PROMPT_COLOR=$(expr $PROMPT_COLOR \- 1)
fi
case "$TMUX_PROMPT_COLOR" in
    0) export TMUX_COLOR=black ;;
    1) export TMUX_COLOR=red ;;
    2) export TMUX_COLOR=green ;;
    3) export TMUX_COLOR=yellow ;;
    4) export TMUX_COLOR=blue ;;
    5) export TMUX_COLOR=magenta ;;
    6) export TMUX_COLOR=cyan ;;
    7) export TMUX_COLOR=white ;;
    *) ;;
esac
export PS1="\[$(reverse)$(colorfg $PROMPT_COLOR)\] \w \[$(norm)\] "
