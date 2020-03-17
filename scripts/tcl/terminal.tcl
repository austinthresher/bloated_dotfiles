package require Tk

font configure TkFixedFont -size 14

proc termstyle {} {
    set font "-font TkFixedFont"
    set cursor "-insertbackground #00FF00 -insertwidth 1"
    set selection "-selectbackground #0044AA -selectforeground #FFFFFF"
    set background "-fg #CCCCCC -bg #121212"
    set style "-selectborderwidth 0 -bd 0"
    return "$font $selection $background $style $cursor"
}

grid [text .term -state disabled -wrap none {*}[termstyle]] -sticky nsew
grid [entry .input -textvariable input {*}[termstyle]] -sticky ew -row 1
grid rowconfigure . 0 -weight 1
grid rowconfigure . 1 -weight 1
grid columnconfigure . 0 -weight 1

focus .input

proc put_stdout {str} {
    .term configure -state normal
    .term insert end "$str\n"
    .term configure -state disabled
    .term see end
}

proc readevent {ch} {
    if {[gets $ch line] < 0} {
        return
        close $ch
        put_stdout "<closed>"
    } else {
        put_stdout $line
    }
}

set ::ch [open {|/bin/sh -il} RDWR]
fconfigure $::ch -blocking false -buffering none
fileevent $::ch readable "readevent $::ch"

proc userinput {} {
    set cmd $::input
    set ::input {}
    puts $::ch "$cmd\n"
}

bind . <Return> userinput
