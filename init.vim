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


" Normal Mode Overview
"	H, h, L, l		Move to {start,end} of {next,prev} word
"	J, j, K, k		Move {down,up> a {paragraph,line}
"	Alt+{h,j,k,l}		Scroll view (small)
"	Alt+{J,K}		Scroll view (half page)
"	Alt+{H,L}		{next,prev} buffer
" 	C-h, C-l		Move to {start,end} of line
" Not sure I like this one
" 	C-j, C-k		New line {below,above} current line
" What about insert / append before / after current word?

" Insert Mode Overview
" 	C-h, C-l		Move to {start,end} of line
" 	Alt+{h,j,k,l}		Basic movement
" 	Alt+{H,J,K,L}		Scroll view (small)

" Enter insert mode
noremap <silent> <c-space> i
noremap <silent> <esc> :

" Navigate to start of words
noremap <silent> H B
noremap <silent> l W

" Navigate to end of words
noremap <silent> h gE
noremap <silent> L E

" Home / End 
noremap <silent> <c-h> ^
noremap <silent> <c-l> $
inoremap <silent> <c-h> <c-o>^
inoremap <silent> <c-l> <c-o>$

" Insert mode navigation
inoremap <silent> <m-h> <c-o>h
inoremap <silent> <m-l> <c-o>l
inoremap <silent> <m-j> <c-o>j
inoremap <silent> <m-k> <c-o>k

" Line navigation
noremap <silent> j j
noremap <silent> k k

" Insert new blank line below / above
noremap <silent> <c-j> o
noremap <silent> <c-k> O

" Next / prev blank line
noremap <silent> J }
noremap <silent> K {

" Switch buffer
noremap <silent> <m-s-h> :bp<cr>
noremap <silent> <m-s-l> :bn<cr>

" Scroll view
noremap <silent> <m-s-k> <c-u>
noremap <silent> <m-s-j> <c-d>
noremap <silent> <m-k> <c-y>
noremap <silent> <m-j> <c-e>
noremap <silent> <m-h> 10zh
noremap <silent> <m-l> 10zl

inoremap <silent> <m-s-k> <c-o><c-y>
inoremap <silent> <m-s-j> <c-o><c-e>
inoremap <silent> <m-s-h> <c-o>10zh
inoremap <silent> <m-s-l> <c-o>10zl

" Leave insert mode; pick one of these to use
inoremap <silent> <c-space> <esc> 
inoremap <silent> <c-c> <esc>
inoremap <silent> <c-d> <esc>

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
