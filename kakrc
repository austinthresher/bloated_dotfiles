# Plugins
source "%val{config}/plugins/plug.kak/rc/plug.kak"
plug "andreyorst/plug.kak" noload
plug "andreyorst/powerline.kak" defer powerline %{
        powerline-theme base16-gruvbox
        powerline-separator none
} config %{
        powerline-start
}
plug "andreyorst/smarttab.kak" defer smarttab %{
        set global softtabstop 4
} config %{
        hook global WinSetOption filetype=(python|markdown|kak|rust) expandtab
        hook global WinSetOption filetype=(c|cpp|sh) smarttab
}
plug "andreyorst/fzf.kak" defer fzf %{
        set global fzf_file_command 'ag'
}
plug "andreyorst/base16-gruvbox.kak" theme config %{
        colorscheme base16-gruvbox-dark-soft
}

# UI
set -add global autoinfo normal
set -add global ui_options ncurses_assistant=none
set -add global ui_options ncurses_enable_mouse=true
set -add global ui_options ncurses_change_colors=false
set -add global ui_options ncurses_set_title=false
hook global WinCreate .* %{ powerline-separator none }

# Mappings
map -docstring "next buffer" global goto n ': buffer-next<ret>'
map -docstring "previous buffer" global goto p ': buffer-previous<ret>'
map global normal <c-p> ': fzf-mode<ret>'

# Misc
set global indentwidth 0
