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

if exists('g:autoloaded_neomakelist') | finish | endif
let g:autoloaded_neomakelist = v:true

" TODO: Make this plugin play nicely with a quickfix list

function! neomakelist#listfollowcursor() abort
    if &filetype is# 'qf' | return | endif
    let l:loclist = getloclist(0)
    if empty(l:loclist) | return | endif 
    let l:ln = line('.')
    if l:ln < str2nr(l:loclist[0]['lnum']) | return | endif
    if l:ln > str2nr(l:loclist[-1]['lnum']) | return | endif
    let l:idx = 1
    for entry in l:loclist
        let l:intbn = str2nr(entry['bufnr'])
        let l:intln = str2nr(entry['lnum'])
        if l:ln < l:intln | return | endif
        if l:ln == l:intln && bufnr('%') == l:intbn
            let l:pos = getcurpos()
            execute 'll '.l:idx
            call setpos('.', l:pos)
            break
        endif
        let l:idx += 1
    endfor
endfunction

function! s:closelists() abort
    if &filetype ==# 'qf' | return | endif
    let l:lists = filter(range(1, winnr('$')), 'getwinvar(v:val, "&ft") ==# "qf"')
    let l:stack = []
    " Reverse order so that we close from highest winnr to lowest
    for entry in reverse(l:lists)
        execute string(entry).'wincmd c'
    endfor
    let g:ll_winnr = 0
endfunc

function! s:showloclist() abort
    let l:wnr = winnr()
    if !empty(getloclist(l:wnr))
        if g:ll_winnr != l:wnr
            let g:ll_winnr = l:wnr
            call s:closelists()
            lwindow 3  " 3 lines tall
            wincmd J " Force list to bottom of screen
            doautocmd WinLeave
            wincmd p " Go back to active window
        endif
    endif
endfunction

let s:ll_winnr = 0 
let s:ll_startup_timer = 0

function! s:stop_startup_timer() abort
    if s:ll_startup_timer
        call timer_stop(s:ll_startup_timer)
        let s:ll_startup_timer = 0
    endif
endfunction

function! neomakelist#enter() abort
    if !&modifiable | return | endif
    call s:stop_startup_timer()
    call s:showloclist()
endfunction

function! neomakelist#delayed_enter(timer) abort
    if !&modifiable | return | endif
    if !empty(getloclist(s:ll_winnr))
        let s:ll_winnr = 0 " Clear to force enter() to display the window
        call neomakelist#enter()
        if !s:ll_winnr " In case it failed
            let s:ll_winnr = winnr()
        endif
    endif
endfunction

function! neomakelist#startup() abort
    if !&modifiable | return | endif
    let s:ll_winnr = winnr()
    let s:ll_startup_timer = timer_start(100,
                \'neomakelist#delayed_enter', {'repeat': -1})
endfunction

function! neomakelist#bufenter() abort
    if !&modifiable | return | endif
    call neomake#Make({})
    if !s:ll_winnr
        call neomakelist#enter()
    endif
endfunction
