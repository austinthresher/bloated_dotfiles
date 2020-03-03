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

if exists('g:loaded_centerscroll') | finish | endif
let g:loaded_centerscroll = v:true

" Emacs style scrolling where the view re-centers on cursor
func! centerscroll#update()
    if !exists('b:last_topline')
        let b:last_topline = 1
    endif
    if !exists('b:last_curline')
        let b:last_curline = 1
    endif
    let l:topline = winsaveview()['topline']
    let l:curline = line('.')
    if l:topline != b:last_topline && l:curline != b:last_curline
        noa norm! zz
        let l:topline = winsaveview()['topline']
        let l:curline = line('.')
    endif
    let b:last_topline = l:topline
    let b:last_curline = l:curline
endfunc

" Don't let the cursor jump when scrolling with C-E/Y
nnoremap <silent> <C-E> <C-E>:let b:last_curline+=1<cr>gj:let b:last_topline = winsaveview()['topline']<cr>
nnoremap <silent> <C-Y> <C-Y>:let b:last_curline-=1<cr>gk:let b:last_topline = winsaveview()['topline']<cr>

augroup CenterScroll
    autocmd!
    autocmd! WinEnter * let b:last_topline = winsaveview()['topline'] | let b:last_curline = line('.')
    autocmd! CursorMoved,CursorMovedI * call centerscroll#update()
augroup END
