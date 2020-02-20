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

if exists("g:statuslime_loaded") | finish | endif
let g:statuslime_loaded = v:true

" Highlights
" FIXME: Prune this list to what's actually used
for m in ['Normal', 'Visual', 'Insert', 'Replace', 'Terminal', 'Command',
            \ 'Shell', 'Preview', 'Help', 'Other', 'File', 'Error',
            \ 'Right', 'Left', 'InactiveBar', 'InactiveMode' ]
    if hlexists('Lime'.m) == 0
        exe 'hi link Lime'.m.' StatusLine'
    endif
endfor

func! statuslime#filename()
    let filename = expand('%') !=# '' ? expand('%') : '[No Name]'
    let modified = &modified ? '+' : ''
    let ro = &readonly ? ' [RO]' : ''
    return '  '.filename.modified.ro.' '
endfunc

func! statuslime#ruler()
    let lchars = strlen(line('$'))
    return '  '.printf('%'.lchars.'d / %'.lchars.'d',
                \ line('.'), line('$')).' : '.virtcol('.').' '
endfunc

func! Pad(str)
    return '  '.a:str.' '
endfunc

func! s:add_state(condition, hlname, text)
    exe 'setlocal statusline+=%#'
                \ .a:hlname.'#%{('.a:condition.')?Pad('''.a:text.'''):''''}'
endfunc

func! statuslime#left()
    if exists("b:statuslime_left")
        return Pad(b:statuslime_left)
    endif
    return ''
endfunc

func! statuslime#right()
    if exists("b:statuslime_right")
        return Pad(b:statuslime_right)
    endif
    return ''
endfunc

" User should define a function called SetStatusLime()
" that updates the values of g:statuslime_left and
" g:statuslime_right

func! statuslime#focused()
    try
        if type(SetStatusLime()) == type('')
            setlocal statusline=%{SetStatusLime()}
        else
            setlocal statusline=
        endif
    catch
        setlocal statusline=
    endtry
    call s:add_state('mode()[0]==#''n''', 'LimeNormal', 'NORMAL')
    call s:add_state('mode()[0]==#''i''', 'LimeInsert', 'INSERT')
    call s:add_state('mode()[0]==#''R''', 'LimeReplace', 'REPLACE')
    call s:add_state('mode()[0]==#''t''', 'LimeTerminal', 'TERMINAL')
    call s:add_state('mode()[0]==#''v''', 'LimeVisual', 'VISUAL')
    call s:add_state('mode()[0]==#''V''', 'LimeVisual', 'VISUAL-LINE')
    call s:add_state('char2nr(mode()[0])==0x16', 'LimeVisual', 'VISUAL-BLOCK')
    call s:add_state('mode()[0]==#''c''', 'LimeCommand', 'COMMAND')
    call s:add_state('mode()[0]==#''r''', 'LimeOther', 'CONTINUE')
    call s:add_state('mode()[0]==#''!''', 'LimeOther', 'SHELL')
    call s:add_state('mode()==#''no''', 'LimeNormal', 'PENDING')
    setlocal statusline+=%<
    setlocal statusline+=%#LimeFile#%{statuslime#filename()}
    setlocal statusline+=%*
    setlocal statusline+=%#LimeLeft#%{statuslime#left()}
    setlocal statusline+=%*
    setlocal statusline+=%=
    setlocal statusline+=%#LimeRight#%{statuslime#right()}
    setlocal statusline+=%#LimeRuler#%{statuslime#ruler()}
endfunc

func! statuslime#unfocused()
    try
        if type(SetStatusLime()) == type('')
            setlocal statusline=%{SetStatusLime()}
        else
            setlocal statusline=
        endif
    catch
        setlocal statusline=
    endtry
    if &previewwindow
        call s:add_state('v:true', 'LimeInactiveMode', 'PREVIEW')
        setlocal statusline+=%<
        setlocal statusline+=%*
    else
        call s:add_state('v:true', 'LimeInactiveMode', 'NORMAL')
        setlocal statusline+=%<
        setlocal statusline+=%#LimeInactiveBar#%{statuslime#filename()}
        setlocal statusline+=%*
        setlocal statusline+=%=
        setlocal statusline+=%#LimeInactiveBar#%{statuslime#ruler()}
    endif
endfunc
