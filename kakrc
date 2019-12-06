# UI
colorscheme mono
set -add global autoinfo normal
set -add global ui_options ncurses_assistant=none
set -add global ui_options ncurses_enable_mouse=true
set -add global ui_options ncurses_change_colors=false
set -add global ui_options ncurses_set_title=false
# Mappings
map -docstring "next buffer" global goto n ' :buffer-next<ret>'
map -docstring "previous buffer" global goto p ' :buffer-previous<ret>'
# Misc
set global indentwidth 0
