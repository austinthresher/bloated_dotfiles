" Copyright (c) 2020 Austin Thresher
"
" MIT License
"
" Permission is hereby granted, free of charge, to any person obtaining
" a copy of this software and associated documentation files (the
" "Software"), to deal in the Software without restriction, including
" without limitation the rights to use, copy, modify, merge, publish,
" distribute, sublicense, and/or sell copies of the Software, and to
" permit persons to whom the Software is furnished to do so, subject to
" the following conditions:
"
" The above copyright notice and this permission notice shall be
" included in all copies or substantial portions of the Software.
"
" THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
" EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
" MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
" NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
" LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
" OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
" WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

" helper.vim provides a quick and easy way to see what plugins have
" documentation available. The command :Helper has tab completion for
" any plugin's help files, and :HelperToggle shows a menu that allows
" selecting the name of a plugin interactively to view its help file.

if exists('g:autoloaded_helper') | finish | endif
let g:autoloaded_helper = v:true

" Requires junegunn/vim-plug and skywind3000/quickmenu.vim
" Automatically includes quickmenu, so no need to include
" it in your vimrc.

" Wraps vim-plug's plug#begin(). Set g:helper_plug_path to
" specify the directory that vim-plug uses.
function! helper#begin() abort
    if exists('g:helper_plug_path') == v:false
        let g:helper_plug_path = has('nvim') ?
                    \ $HOME.'/.config/nvim/plugged' :
                    \ $HOME.'/.vim/plugged'
    endif
    try
        call plug#begin(g:helper_plug_path)
    catch
        echoerr 'helper#begin failed: vim-plug is missing or broken'
    endtry
    let s:plugin_list = []
    let s:found_help_list = []
endfunction

" Wraps vim-plug's Plug command and tracks plugin repos
" in an internal list
function! helper#plug(repo) abort
    try
        call plug#(a:repo)
        let s:plugin_list = s:plugin_list + [a:repo]
    catch
        echoerr 'helper#plug failed for plugin '.a:repo
    endtry
endfunction

" If you need to use any of the advanced features of vim-plug,
" use Plug like normal instead of helper#plug() and just include
" this afterwards to add that plugin's folder to the locations
" searched for help files.
function! helper#manual(repo) abort
    let s:plugin_list = s:plugin_list + [a:repo]
endfunction

" Find help docs for each plugin registered with helper#plug()
function! s:populate() abort
    " quickmenu supports multiple menus with unique ids, pick one if it
    " hasn't already been set
    if exists('g:helper_menu_id') == v:false
        let g:helper_menu_id = 42
    endif
    let g:quickmenu_options = 'H'
    try
        " Populate quickmenu with installed plugins with helpfiles
        call quickmenu#current(g:helper_menu_id)
        call quickmenu#reset()
        call quickmenu#header('plugin help')
        for plug in s:plugin_list
            " Grab the plugin's directory name from author/repo pairing
            let l:dir = split(plug, '/')[1]
            " Check if a directory named doc exists in the plugin
            let l:doc = g:helper_plug_path.'/'.l:dir.'/doc'
            if isdirectory(l:doc)
                " Get the plugin's name without 'vim' as a prefix or suffix
                let l:short = substitute(
                            \ substitute(l:dir, 'vim-', '', 'g'),
                            \ '.vim', '', 'g')
                " Help files are usually at one of these filenames
                let l:potentials = [
                            \ l:doc.'/'.l:short.'.txt',
                            \ l:doc.'/'.l:dir.'.txt'
                            \ ]
                let l:globbed = glob(l:doc.'/*.txt')
                if type(l:globbed) == type([])
                    let l:potentials = l:potentials + l:globbed
                else
                    let l:potentials = l:potentials + [string(l:globbed)]
                endif
                " Add a menu entry if we find a help file
                for txt in l:potentials
                    if filereadable(txt)
                        " It appears that vim uses the name listed at the top
                        " of the help file to determine the name of that help
                        " section
                        let l:head = split(system('head -n 1 '.txt), '*')[0]
                        call quickmenu#append(l:short, 'h '.l:head, '')
                        let s:found_help_list = s:found_help_list + [l:head]
                        break
                    endif
                endfor
            endif
        endfor
    catch
        echom 'helper#populate was unsuccessful'
    endtry
endfunction

let s:loaded_on_demand = v:false
function! s:lazyload() abort
    if !s:loaded_on_demand
        call s:populate()
        let s:loaded_on_demand = v:true
    endif
endfunction

" Toggle menu visibility
function! helper#toggle() abort
    call s:lazyload()
    call quickmenu#toggle(g:helper_menu_id)
endfunction

" Wraps vim-plug's plug#end()
function! helper#end() abort
    call plug#('skywind3000/quickmenu.vim')
    call plug#end()
endfunction

" Returns a list of the help docs that were found
function! helper#found() abort
    call s:lazyload()
    return s:found_help_list
endfunction
