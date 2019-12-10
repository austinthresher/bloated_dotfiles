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
plug "delapouite/kakoune-buffers" %{
        map global normal ^ q
        map global normal <a-^> Q
        map global normal q b
        map global normal Q B
        map global normal <a-q> <a-b>
        map global normal <a-Q> <a-B>
        map global normal b ': enter-buffers-mode<ret>' -docstring 'buffers'
        map global normal B ': enter-user-mode -lock buffers<ret>' -docstring 'buffers (lock)'
}
plug "andreyorst/kaktree" defer kaktree %{
    # settings for fancy icons as on the screenshot above.
    set-option global kaktree_dir_icon_open  '▾ 🗁 ' # 📂 📁
    set-option global kaktree_dir_icon_close '▸ 🗀 '
    set-option global kaktree_file_icon      '⠀⠀🖹 ' # 🖺 🖻
} config %{
    hook global WinSetOption filetype=kaktree %{
        remove-highlighter buffer/numbers
        remove-highlighter buffer/matching
        remove-highlighter buffer/wrap
        remove-highlighter buffer/show-whitespaces
    }
}

# UI
set -add global autoinfo normal
set -add global ui_options ncurses_assistant=none
set -add global ui_options ncurses_enable_mouse=true
set -add global ui_options ncurses_change_colors=false
set -add global ui_options ncurses_set_title=false
hook global WinCreate .* %{ powerline-separator none }
add-highlighter global/ show-matching

# Mappings
map global normal '\' , -docstring 'leader'
map global user 'p' ': fzf-mode<ret>' -docstring 'fzf'
map global user 't' ': kaktree-enable<ret>: kaktree-toggle<ret>' -docstring 'filetree'
map global normal  '[w]w: ctags-search<ret>'
# Misc
set global indentwidth 0
