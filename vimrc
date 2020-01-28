" Disable vi-compatible defaults
set nocompatible
" Allow folding in files using {{{ and }}}
set foldenable
set foldmethod=marker
" Always use UTF-8
set encoding=utf-8
scriptencoding utf-8
" No annoying sounds / flashes
set noerrorbells
" Allow files to customize settings on open
set modeline
" Characters used when list=on
set listchars=eol:$,tab:>\ ,extends:>,precedes:<,nbsp:+,trail:_
" Character used to mark wrapped lines
set showbreak==>\
" Copy the indentation from the previous line
set autoindent
" Short blink when typing matching parens
set showmatch
set matchtime=1
" Allow leaving modified buffers without saving
set hidden
" Try to keep windows similarly sized
set equalalways
set eadirection=both
" Don't show the active mode
set noshowmode
" Search as you're typing
set incsearch
" Allow backspacing over everything
set backspace=indent,eol,start
" Spaces for status line and fold
"set fillchars=stl:\ ,stlnc:\ ,fold:\ ,eob:~
" Enable the mouse
set mouse=a
" Set US English for spellcheck
set spelllang=en_us
" Always show statusbar
set laststatus=2
" Don't wrap lines by default
set nowrap
" Don't page output
set nomore
" Use relative line numbers
set relativenumber
set number


function StatusMode(modestr)
	let result = ' '
	if a:modestr ==# 'i'
		hi link StatusLine InsertMode
		let result = ' INSERT '
	elseif a:modestr ==# 'r'
		hi link StatusLine ReplaceMode
		let result = ' REPLACE '
	elseif a:modestr ==# 't'
		hi link StatusLine TerminalMode
		let result = ' TERMINAL '
	elseif a:modestr ==# 'n'
		hi link StatusLine NormalMode
		let result = ' NORMAL '
	elseif a:modestr ==# 'v'
		hi link StatusLine VisualMode
		let result = ' VISUAL '
	elseif a:modestr ==# 'c'
		hi link StatusLine CommandMode
		let result = ' COMMAND '
	elseif a:modestr ==# '!'
		let result = ' SHELL '
		hi link StatusLine ShellMode
	else
		let result = ' NORMAL '
		hi link StatusLine InactiveMode
	endif
	return ' '.result
endfunc

function LabeledStatusWithFile()
	return b:status_label.' '.expand('%:t')
endfunc

function LabeledStatus()
	return b:status_label
endfunc

function StatusLeft()
	let filename = expand('%') !=# '' ? expand('%') : '[No Name]'
	let modified = &modified ? '+' : ''
	let ro = &readonly ? ' [RO]' : ''
	return '  '.filename.modified.ro
endfunc

function StatusRight()
	let lchars = strlen(line('$'))
	return virtcol('.').' : '.printf('%'.lchars.'d / %'.lchars.'d', line('.'), line('$'))
	return result
endfunc

function SetColors()
	hi NormalMode   guifg='#000000' guibg='#D0BFA1' gui=bold
	hi VisualMode   guifg='#000000' guibg='#2C78BF' gui=bold
	hi InsertMode   guifg='#000000' guibg='#FBB829' gui=bold
	hi ReplaceMode  guifg='#000000' guibg='#FF5F00' gui=bold
	hi TerminalMode guifg='#000000' guibg='#519F50' gui=bold
	hi CommandMode  guifg='#000000' guibg='#E02C6D' gui=bold
	hi ShellMode    guifg='#000000' guibg='#53FDE9' gui=bold
	hi OtherMode    guifg='#000000' guibg='#EF2F27' gui=bold
	hi InactiveMode guifg='#000000' guibg='#3A3A3A'
	return ''
endfunc

function SetFocusedStatus()
	if &ft ==# 'help'
		let b:status_label = 'help:'
		setlocal statusline=%{LabeledStatusWithFile()}
	elseif &ft =~ 'man'
		let b:status_label = 'man'
		setlocal statusline=%{LabeledStatusWithFile()}
	else
		setlocal statusline=%{SetColors()}
		setlocal statusline+=%#InsertMode#%{(mode()[0]==#'i')?StatusMode('i'):''}
		setlocal statusline+=%#ReplaceMode#%{(mode()[0]==#'R')?StatusMode('r'):''}
		setlocal statusline+=%#TerminalMode#%{(mode()[0]==#'t')?StatusMode('t'):''}
		setlocal statusline+=%#VisualMode#%{(mode()[0]==#'v')?StatusMode('v'):''}
		setlocal statusline+=%#VisualMode#%{(mode()[0]==#'V')?StatusMode('v'):''}
		setlocal statusline+=%#VisualMode#%{(char2nr(mode()[0])==0x16)?StatusMode('v'):''}
		setlocal statusline+=%#CommandMode#%{(mode()[0]==#'c')?StatusMode('c'):''}
		setlocal statusline+=%#OtherMode#%{(mode()[0]==#'r')?StatusMode('r'):''}
		setlocal statusline+=%#OtherMode#%{(mode()[0]==#'!')?StatusMode('!'):''}
		setlocal statusline+=%#NormalMode#%{(mode()[0]==#'n')?StatusMode('n'):''}
		setlocal statusline+=%*
		setlocal statusline+=%{StatusLeft()}
		setlocal statusline+=%=
		setlocal statusline+=%{StatusRight()}
	endif
endfunc

function SetUnfocusedStatus()
	if &ft ==# 'help'
		let b:status_label = 'help:'
		setlocal statusline=%{LabeledStatusWithFile()}
	elseif &ft =~ 'man'
		let b:status_label = 'man'
		setlocal statusline=%{LabeledStatusWithFile()}
	else
		setlocal statusline=%{SetColors()}
		setlocal statusline+=%#InactiveMode#%{StatusMode('')}
		setlocal statusline+=%*
		setlocal statusline+=%{StatusLeft()}
		setlocal statusline+=%=
		setlocal statusline+=%{StatusRight()}
	endif
endfunc

augroup StatusStuff
	au!
	au WinEnter,BufEnter * call SetFocusedStatus()
	au WinLeave,BufLeave * call SetUnfocusedStatus()
augroup END

if has("nvim")
	" Navigate out of terminal mode more easily
	tnoremap <esc> <c-\><c-n>
	tnoremap <c-w> <c-\><c-n><c-w>
endif
" Reset layout
nnoremap <leader>r <C-W>=
" Quick reload of vimrc
nnoremap <leader>R :source $MYVIMRC<cr>
" Toggle spellcheck
nnoremap <leader>S :set spell!<cr>
" Quickly close a window
nnoremap <leader>q :q<cr>

nnoremap ` <c-w>
nnoremap <c-w>` `


" Color Theme

" srcery color palette
let s:black          = ['#1C1B19', 0]
let s:red            = ['#EF2F27', 1]
let s:green          = ['#519F50', 2]
let s:yellow         = ['#FBB829', 3]
let s:blue           = ['#2C78BF', 4]
let s:magenta        = ['#E02C6D', 5]
let s:cyan           = ['#0AAEB3', 6]
let s:white          = ['#D0BFA1', 7]
let s:bright_black   = ['#918175', 8]
let s:bright_red     = ['#F75341', 9]
let s:bright_green   = ['#98BC37', 10]
let s:bright_yellow  = ['#FED06E', 11]
let s:bright_blue    = ['#68A8E4', 12]
let s:bright_magenta = ['#FF5C8F', 13]
let s:bright_cyan    = ['#53FDE9', 14]
let s:bright_white   = ['#FCE8C3', 15]

" xterm colors.
let s:orange        = ['#FF5F00', 202]
let s:bright_orange = ['#FF8700', 208]
let s:hard_black    = ['#121212', 233]
let s:xgray1        = ['#262626', 235]
let s:xgray2        = ['#303030', 236]
let s:xgray3        = ['#3A3A3A', 237]
let s:xgray4        = ['#444444', 238]
let s:xgray5        = ['#4E4E4E', 239]
let s:xgray6        = ['#585858', 240]

let s:none = ['NONE', 'NONE']

function! s:hi(group, fg, bg, attr)
	let l:cmd = [ 'hi', a:group, 'guifg='.a:fg[0], 'guibg='.a:bg[0],
		\ 'gui='.a:attr, 'ctermfg='.a:fg[1], 'ctermbg='.a:bg[1],
		\ 'cterm='.a:attr ]
	execute join(l:cmd, ' ')
endfunc

call s:hi('Normal', s:bright_white, s:black, 'NONE')

for group in ['Visual', 'VisualNOS', 'Search', 'IncSearch']
	call s:hi(group, s:none, s:none, 'inverse')
endfor

for group in ['NonText', 'SpecialKey']
	call s:hi(group, s:xgray4, s:none, 'NONE')
endfor

call s:hi('MatchParen', s:bright_magenta, s:none, 'bold')
call s:hi('Conceal', s:blue, s:none, 'NONE')
call s:hi('StatusLine', s:bright_white, s:xgray2, 'NONE')
call s:hi('VertSplit', s:bright_white, s:none, 'NONE')
call s:hi('WildMenu', s:blue, s:black, 'bold')
call s:hi('ErrorMsg', s:bright_white, s:red, 'NONE')
call s:hi('Directory', s:green, s:none, 'bold')
call s:hi('Title', s:green, s:none, 'bold')
call s:hi('MoreMsg', s:yellow, s:none, 'bold')
call s:hi('Question', s:orange, s:none, 'bold')
call s:hi('Warning', s:red, s:none, 'bold')

call s:hi('Cursor', s:black, s:yellow, 'NONE')
hi! link vCursor Cursor
hi! link iCursor Cursor
hi! link lCursor Cursor

call s:hi('Special', s:orange, s:none, 'NONE')
call s:hi('Comment', s:bright_black, s:none, 'italic')
call s:hi('Todo', s:bright_white, s:black, 'bold,italic')
call s:hi('Error', s:bright_white, s:red, 'bold')
call s:hi('String', s:bright_green, s:none, 'italic')

for group in ['Statement', 'Conditional', 'Repeat', 'Label', 'Exception', 'Keyword']
	call s:hi(group, s:red, s:none, 'NONE')
endfor

for group in ['Identifier', 'PreProc', 'Include', 'Define', 'PreCondit', 'Structure']
	call s:hi(group, s:cyan, s:none, 'NONE')
endfor

call s:hi('Function', s:yellow, s:none, 'NONE')
call s:hi('Macro', s:orange, s:none, 'NONE')

for group in ['Constant', 'Character', 'Boolean', 'Number', 'Float']
	call s:hi(group, s:bright_magenta, s:none, 'NONE')
endfor

call s:hi('Type', s:bright_blue, s:none, 'NONE')
call s:hi('StorageClass', s:orange, s:none, 'NONE')
call s:hi('Typedef', s:magenta, s:none, 'NONE')
call s:hi('Delimiter', s:bright_black, s:none, 'NONE')

" Make folds blend in so that the status bar and splits are easier to identify
call s:hi('Folded', s:none, s:none, 'italic')
call s:hi('LineNr', s:white, s:xgray1, 'NONE')
call s:hi('CursorLineNr', s:xgray1, s:bright_black, 'NONE')
call s:hi('StatusLineNC', s:xgray1, s:hard_black, 'NONE')

call s:hi('Pmenu', s:bright_white, s:xgray2, 'NONE')
call s:hi('PmenuSel', s:bright_white, s:magenta, 'bold')

call s:hi('DiffDelete', s:red, s:black, 'none')
call s:hi('DiffAdd', s:green, s:black, 'none')
call s:hi('DiffChange', s:cyan, s:black, 'none')
call s:hi('DiffText', s:yellow, s:black, 'none')

if has('spell')
	call s:hi('SpellCap', s:none, s:magenta, 'underline')
	call s:hi('SpellBad', s:none, s:red, 'underline')
	call s:hi('SpellLocal', s:none, s:yellow, 'underline')
	call s:hi('SpellRare', s:none, s:cyan, 'underline')
endif
if has('terminal')
	call s:hi('Terminal', s:bright_white, s:hard_black, 'NONE')
endif


set termguicolors
