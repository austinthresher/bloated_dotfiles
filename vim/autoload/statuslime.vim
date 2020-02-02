if exists("g:statuslime_loaded")
    finish
endif
let g:statuslime_loaded = 1

" Highlights
func! statuslime#defaulthl(name)
endfunc

for m in ['Normal', 'Visual', 'Insert', 'Replace', 'Terminal', 'Command',
            \ 'Shell', 'Inactive', 'Preview', 'Help', 'Other', 'File', 'Func',
            \ 'Error' ]
    if hlexists('Lime'.m) == 0
        exe 'hi link Lime'.m.' StatusLine'
    endif
endfor

func! statuslime#left()
	let filename = expand('%') !=# '' ? expand('%') : '[No Name]'
	let modified = &modified ? '+' : ''
	let ro = &readonly ? ' [RO]' : ''
	return '  '.filename.modified.ro.' '
endfunc

func! statuslime#right()
	let lchars = strlen(line('$'))
	return '  '.virtcol('.').' : '.printf('%'.lchars.'d / %'.lchars.'d',
		    \line('.'), line('$')).' '
endfunc

func! Pad(str)
	return '  '.a:str.' '
endfunc

func! s:add_state(condition, hlname, text)
    exe 'setlocal statusline+=%#'
    	\.a:hlname.'#%{('.a:condition.')?Pad('''.a:text.'''):''''}'
endfunc

func! statuslime#focused()
    setlocal statusline=
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
    setlocal statusline+=%#LimeFile#%{statuslime#left()}
    setlocal statusline+=%*
    setlocal statusline+=%=
    setlocal statusline+=%#LimeRuler#%{statuslime#right()}
endfunc

func! statuslime#unfocused()
    setlocal statusline=
    call s:add_state('v:true', 'LimeInactive', 'NORMAL')
    setlocal statusline+=%#LimeInactive#%{statuslime#left()}
    setlocal statusline+=%*
    setlocal statusline+=%=
    setlocal statusline+=%#LimeInactive#%{statuslime#right()}
endfunc
