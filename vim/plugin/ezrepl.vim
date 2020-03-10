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

if exists('g:loaded_ezrepl') | finish | endif
let g:loaded_ezrepl = v:true

if !has('nvim')
    function! s:init_repl() abort
        if exists('b:repl_initialized') && b:repl_initialized
            if empty(getbufinfo(b:repl_buf))
                " Old REPL is gone, needs a new buf + win
                let b:repl_initialized = v:false
            elseif empty(getwininfo(b:repl_win))
                " Old REPL is still around, but needs new win
                split
                exec 'norm :b '.b:repl_buf
                let l:repl_win = winnr()
                wincmd p
                let b:repl_win = l:repl_win
            endif
        endif
        if !exists('b:repl_initialized') || !b:repl_initialized
            " Make a new split for this window's REPL
            noautocmd terminal ++rows=8
            " Store info about the new window to carry back
            let l:repl_buf = bufnr('%')
            let l:repl_win = winnr()
            " Return to starting window
            wincmd p
            let b:repl_buf = l:repl_buf
            let b:repl_win = l:repl_win
            let b:repl_initialized = v:true
        endif
    endfunction

    function! g:Repl(...) abort
        if !exists('b:repl_initialized') || !b:repl_initialized
           call s:init_repl()
        endif
        let l:repl_ch = job_getchannel(term_getjob(b:repl_buf))
        if ch_status(l:repl_ch) !=# 'open'
            let b:repl_initialized = v:false
            call s:init_repl()
            let l:repl_ch = job_getchannel(term_getjob(b:repl_buf))
        endif
        call ch_evalraw(l:repl_ch, join(a:000)."\n")
        redraw!
    endfunction

    function! g:ReplExecLine() abort
        call Repl(getline('.'))
    endfunction

    command -nargs=* Repl call Repl('<args>')

    nnoremap <Plug>ReplExecLine :call ReplExecLine()<cr>
else " has('nvim')
endif
