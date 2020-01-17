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

" source 'tabula.vim'

" Essential Plugins {{{ 
	call plug#begin('~/.config/nvim/plugins')

	" Pretty colors
	Plug 'morhetz/gruvbox'
	Plug 'Shougo/unite.vim'
	Plug 'Shougo/vimproc.vim', {'do' : 'make'}

	call plug#end()
" }}}

" Per-plugin configs + keymaps {{{
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
" }}}


" Notes on commonly used operations:
	" center view on cursor / put view with cursor at top
	" insert after or before a word
	" switch buffer



	" Quick reload of vimrc
	nnoremap <leader>R :source $MYVIMRC<cr>
	" Makes testing plugins faster
	nnoremap <leader>Pi :PlugInstall<cr>
	nnoremap <leader>Pu :PlugUpdate<cr>
	nnoremap <leader>Pc :PlugClean<cr>
" }}}

" Theme {{{
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
" }}}
