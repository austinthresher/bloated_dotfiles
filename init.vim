" Basic Configuration {{{
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
	" Show position in file
	set ruler
	" Allow files to customize settings on open
	set modeline
	" Characters used when list=on
	set listchars=eol:$,tab:»\ ,extends:›,precedes:‹,nbsp:·,trail:·
	" Character used to mark wrapped lines
	set showbreak=↪\
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
	" Show the active mode
	set showmode
	" Ignore case for lowercase searches
	set ignorecase
	set smartcase
	" Search as you're typing
	set incsearch
	" Allow backspacing over everything
	set backspace=indent,eol,start
	" Spaces for status line and fold
	set fillchars=stl:\ ,stlnc:\ ,fold:\ ,eob:~
	" Enable the mouse
	set mouse=a
" }}}

let g:fuzzyfinder = 'fzf'


" keymap from scratch {{{
source $HOME/.dotfiles/tabula.vim

" NOTES ON KEYMAP CHOICES
" =======================

" inclusive / exclusive operations should be a toggle or prefix

" Operations that use 4 directions:
"	insert / append before / after / above / below line
"	navigating panes
"
" Operations that user 4 directions sometimes, but only 2 most times:
"	character movement 
"	view movement

" Operations that use 2 directions:
"	start / end of line
"	start / end of buffer
"	start / end of screen
"	indent / unindent
"	next / previous tab or buffer
"	start / end of next word
"	end / start of prev word
"	next / previous match
"	insert / append before / after word (maybe exclusive / inclusive too?)
"	jump to next / previous character
"	increase / decrease value

" Keys that work well for 4 direction commands:
"	h j k l
"	w a s d
"	up down left right
"	pageup pagedown home end

" Keys that work well for 2 direction commands:
"	[ ]
"	{ }
"	( )
"	< >
"	- + (less / more)
"	| _ (vert / horiz)
"	n p ('next' 'prev')
"	f b ('forward', 'backwards')
"	a z (beginning / end of alphabet)
"	, . (location, both punctuation)
"	g ; (left and right of h and l)
"	n m (location + almost alphabetic)
"	q e (left and right of w in wasd)
"	tab shift-tab
"	- = (kind of awkward because of asymmetric shift key)
"	c v (location)

" Using h j k l as 4 directions, with g and ; as extra side directions,
" we can use Shift to increase the scope of a movement and Alt to combine
" it with an append / insert operation.

"	G	start of prev word
"	g	end of prev word
"	;	start of next word
"	:	end of next word
"	h l	next / prev char
"	j k	next / prev line
"	J K	start / end of paragraph
"	H L	start / end of line
"	M-h	insert before char
"	M-l	insert after char
"	M-H	insert at start of line
"	M-L	insert at end of line
"	M-g	append at end of prev word
"	M-G	insert at start of prev word
"	M-;	insert at start of next word
"	M-:	append at end of next word
"	M-j	insert new line below current line
"	M-k	insert new line above current line
"	M-J	insert new line above current paragraph
"	M-K	insert new line below current paragraph

" In insert mode, alt + the above keys perform the cursor movement-related ops

" Esc to enter command mode
noremap <silent><nowait>	<esc>	:
inoremap <silent><nowait>	<esc>	<c-o>:

" Normal Mode cursor movement
noremap <silent> <nowait>	n	B
noremap <silent> <nowait>	N	gE
noremap <silent> <nowait>	m	W
noremap <silent> <nowait>	M	E
noremap <silent> <nowait>	h	h
noremap <silent> <nowait>	l	l
noremap <silent> <nowait>	j	j
noremap <silent> <nowait>	k	k
noremap <silent> <nowait>	H	^
noremap <silent> <nowait>	L	$
noremap <silent> <nowait>	J	}
noremap <silent> <nowait>	K	{

" Normal Mode cursor movement + switch to Insert Mode
noremap <silent> <nowait>	<M-h>	i
noremap <silent> <nowait>	<M-l>	a
noremap <silent> <nowait>	<M-j>	o
noremap <silent> <nowait>	<M-k>	O
noremap <silent> <nowait>	<M-H>	I
noremap <silent> <nowait>	<M-L>	A
noremap <silent> <nowait>	<M-J>	}o
noremap <silent> <nowait>	<M-K>	{O
noremap <silent> <nowait>	<M-n>	Wi
noremap <silent> <nowait>	<M-N>	Ea
noremap <silent> <nowait>	<M-m>	gEa
noremap <silent> <nowait>	<M-M>	Bi

" Insert Mode cursor movement
inoremap <silent> <nowait>	<M-n>	<C-o>B
inoremap <silent> <nowait>	<M-N>	<C-o>gE
inoremap <silent> <nowait>	<M-m>	<C-o>W
inoremap <silent> <nowait>	<M-M>	<C-o>E
inoremap <silent> <nowait>	<M-h>	<C-o>h
inoremap <silent> <nowait>	<M-l>	<C-o>l
inoremap <silent> <nowait>	<M-j>	<C-o>j
inoremap <silent> <nowait>	<M-k>	<C-o>k
inoremap <silent> <nowait>	<M-H>	<C-o>^
inoremap <silent> <nowait>	<M-L>	<C-o>$
inoremap <silent> <nowait>	<M-J>	<C-o>}
inoremap <silent> <nowait>	<M-K>	<C-o>{

" Leave insert mode (and perform pending ops) TODO: how to make these two different
inoremap <silent> <nowait>	<c-d>	<esc>

" Leave insert mode (cancel pending ops)
inoremap <silent> <nowait>	<c-c>	<esc>


" }}}

" Essential Plugins {{{ 
	call plug#begin('~/.config/nvim/plugins')

	" Pretty colors
	Plug 'morhetz/gruvbox'

	" For search / quick access.
	if g:fuzzyfinder ==# 'unite'
		Plug 'Shougo/unite.vim'
		Plug 'Shougo/vimproc.vim', {'do' : 'make'}
	endif

	call plug#end()
" }}}

" Per-plugin configs + keymaps {{{

	if exists('g:loaded_unite')
		" Use ag instead of grep
		let g:unite_source_grep_command = 'ag'
		let g:unite_source_grep_default_opts =
			\ '--follow --nocolor --nogroup --hidden'

		" Find file
		nnoremap <C-o> :Unite file_rec/neovim -auto-preview<cr>i
		" Find line
		nnoremap <C-f> :Unite line -auto-preview<cr>i
		" Find in file
		nnoremap <C-g> :Unite -auto-preview grep:.<cr>i
	endif
" }}}


" Notes on commonly used operations:
	" center view on cursor / put view with cursor at top
	" insert after or before a word
	" switch buffer



	" Quick reload of vimrc
	nnoremap <leader>R :source $MYVIMRC<cr>
	" Makes testing plugins faster
	nnoremap <leader>+Pi :PlugInstall<cr>
	nnoremap <leader>+Pu :PlugUpdate<cr>
	nnoremap <leader>+Pc :PlugClean<cr>
" }}}

" Theme {{{
	let g:gruvbox_italic=1
	try
		set termguicolors
		colorscheme gruvbox

	catch /.*/
		try
			colorscheme gruvbox
		catch /.*/
			colorscheme blue
		endtry
	endtry
	" Use a transparent background for tmux, and make folds blend in so
	" that the status bar and splits are easiser to identify
	if exists('$TMUX')
		hi Normal ctermbg=None guibg=None
		hi Folded ctermbg=None guibg=None cterm=italic gui=italic
	else
		hi Folded ctermbg=None guibg=None cterm=italic gui=italic
		"hi Folded ctermbg=237 guibg='#3c3836' cterm=italic gui=italic
	endif
" }}}
