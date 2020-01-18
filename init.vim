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

" Enter insert mode
noremap <c-space> i
noremap <esc> :

" Navigate to start of words
noremap h B
noremap l W
" Navigate to end of words
noremap H gE
noremap L E
" Home / End 
noremap <c-h> ^
noremap <c-l> $
" Line navigation
noremap j j
noremap k k
noremap J }
noremap K {

" Leave insert mode
inoremap <c-space> <esc> 
inoremap <c-c> <esc>
inoremap <c-d>

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
