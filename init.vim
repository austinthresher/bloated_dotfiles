" Compatibility / System settings {{{
	set foldenable
	set foldmethod=marker
	set nocompatible
	set encoding=utf-8
	scriptencoding utf-8
	set noicon
	set notitle
	set titleold=
" }}}
" Vanilla AutoCommands {{{
	autocmd!
	au BufNewFile,BufRead *.cpp,*.tpp,*.hpp,*.c,*.h set cindent
" }}}
" General Configuration {{{
	syntax on
	set showcmd
	set noerrorbells
	set ruler
	set laststatus=2
	set confirm
	set modeline
	set cursorline
	set listchars=eol:$
	set showbreak=↪\
	set listchars+=tab:»\ ,extends:›,precedes:‹,nbsp:·,trail:·
	set shiftround
	set autoindent
	set matchtime=1
	set title
	set hidden
	set history=100
	set equalalways
	set eadirection=both
	set tabpagemax=50
	set showcmd
	set showmode
	set more
	set ignorecase
	set smartcase
	set hlsearch
	set incsearch
	set showmatch
	set nowrap
	set textwidth=0
	set undolevels=16000
	set backspace=indent,eol,start
	set nostartofline
	set fillchars=stl:\ ,stlnc:\ ,fold:\ ,eob:~
	set mouse=a
" }}}
" Mappings {{{
	" Insert date
	nnoremap <leader>d "=strftime("%b %d, %Y")<CR>P
	inoremap <leader>d <C-R>=strftime("%b %d, %Y")<CR>

	" Quick buffer list and selection
	nnoremap <leader>b :ls<CR>:b

	" Cycle through buffer
	nnoremap <leader>[ :bp<CR>
	nnoremap <leader>] :bn<CR>

	" vim ctrl+space for esc
	inoremap <NUL> <ESC>:noh<CR>
	" same for neovim
	inoremap <C-Space> <ESC>:noh<CR>

	" neovim terminal mode
	tnoremap <Esc> <C-\><C-n>
	tnoremap <C-Space> <C-\><C-n>

	" quick quit
	nnoremap <Leader>q :bd<CR>

" }}}
" List of Plugins {{{
	call plug#begin('~/.config/nvim/plugins')

	" colorschemes
	Plug 'haishanh/night-owl.vim'
	Plug 'sainnhe/vim-color-forest-night'

	" style / visual tweaks
	Plug 'luochen1990/rainbow'
	Plug 'ryanoasis/vim-devicons'
	Plug 'vim-scripts/errormarker.vim'
	Plug 'vim-scripts/ShowTrailingWhitespace'
	Plug 'unblevable/quick-scope'
	Plug 'airblade/vim-gitgutter'
	Plug 'justincampbell/vim-eighties'
	Plug 'itchyny/lightline.vim'
	Plug 'mengelbrecht/lightline-bufferline'
	Plug 'machakann/vim-highlightedyank'

	" documentation / help
	Plug 'thinca/vim-ref' "TODO: test these two individually
	Plug 'keith/investigate.vim'
	Plug 'sheerun/vim-polyglot'

	" movement / commands
	Plug 'tpope/vim-repeat'
	Plug 'tpope/vim-unimpaired'
	Plug 'tpope/vim-rsi'
	Plug 'tpope/vim-surround'
	Plug 'tpope/vim-commentary'
	Plug 'tpope/vim-characterize'
	Plug 'tpope/vim-eunuch'
	Plug 'tpope/vim-abolish'
	Plug 'justinmk/vim-sneak'
	Plug 'vim-scripts/DeleteTrailingWhitespace'

	" misc utility
	Plug 'pbrisbin/vim-mkdir'
	Plug 'tpope/vim-sleuth'
	Plug 'tpope/vim-apathy'
	Plug 'tpope/vim-vinegar'
	Plug 'jeetsukumaran/vim-indentwise'
	Plug 'sgur/vim-editorconfig'
	Plug 'valloric/listtoggle'
	Plug 'tpope/vim-fugitive'
	Plug 'ajh17/vimcompletesme'
	Plug 'majutsushi/tagbar'
	Plug 'wvffle/vimterm'
	" Plug 'fatih/vim-go'

	" TODO: test these
	" Plug 'terryma/vim-multiple-cursors'
	" Plug 'fatih/vim-go'
	" Plug 'Shougo/defx.nvim'
	" Plug 'tmux-plugins/vim-tmux-focus-events'
	" Plug 'dkprice/vim-easygrep'
	" Plug 'vim-voom/voom'
	" Plug 'liuchengxu/vim-which-key'
	" Plug 'mbbill/echofunc'
	" Plug 'aaronbieber/vim-quicktask'
	" Plug 'junegunn/vim-journal'
	" Plug 'amix/open_file_under_cursor.vim'

	call plug#end()
" }}}
" Plugin Configuration {{{
	" highlightedyank {{{
		let g:highlightedyank_highlight_duration = 100
	" }}}
	" vimcompletesme {{{
		autocmd FileType vim let b:vcm_tab_complete = 'vim'
	" }}}
	" listtoggle {{{
		let g:lt_location_list_toggle_map = '<leader>L'
		let g:lt_quickfix_list_toggle_map = '<leader>l'
	" }}}
	" rainbow {{{
		let g:rainbow_active = 1
	" }}}
	" quick-scope {{{
		let g:qs_highlight_on_keys = ['f', 'F']
	" }}}
	" vimterm {{{
		nnoremap <leader>T :call vimterm#toggle() <CR>
		tnoremap <leader>T <C-\><C-n>:call vimterm#toggle() <CR>
	" }}}
	" tagbar {{{
		nmap <leader>t :TagbarToggle<CR>
	" }}}
	" vim-eighties {{{
		let g:eighties_enabled = 1
		let g:eighties_minimum_width = 80
		let g:eighties_extra_width = 0
		let g:eighties_compute = 1
		let g:eighties_bufname_additional_patterns = []
	" }}}
	" lightline-vim {{{
		function! LightlineGit()
			return fugitive#head() !=# '' ? $GIT_ICON . ' ' . fugitive#head() : ''
		endfunction

		function! LightlineFilename()
			let filename = expand('%:t') !=# '' ? expand('%:t') : '[No Name]'
			let modified = &modified ? '+' : ''
			return filename . modified
		endfunction

		function! LightlineFormat()
			let format = &ff
			return (format !=# '' && format !=# 'unix') ? format : ''
		endfunction

		function! LightlineEncoding()
			let encoding = (&fenc !=# "") ? &fenc : &enc
			return (encoding !=# '' && encoding !=# 'utf-8') ? encoding : ''
		endfunction

		let g:lightline = { 'colorscheme': 'custom' }
		let g:lightline.active = { 'left': [], 'right': [] }
		let g:lightline.inactive = { 'left': [], 'right': [] }
		let g:lightline.active.left = [
			\ [ 'mode', 'paste' ],
			\ [ 'readonly', 'filename' ],
			\ [ 'gitbranch' ],
			\ ]
		let g:lightline.active.right = [
			\ [ 'lineinfo' ],
			\ [ 'percent' ],
			\ [ 'charvaluehex', 'fileformat', 'fileencoding', 'filetype' ]
			\ ]
		let g:lightline.inactive.left = [
			\ [], [ 'readonly', 'filename' ]
			\ ]
		let g:lightline.inactive.right = [
			\ [ 'lineinfo' ],
			\ [ 'percent' ],
			\ [ 'filetype' ]
			\ ]
		let g:lightline.tabline = { 'left': [['buffers']], 'right': [['tabs']] }
		let g:lightline.component_expand = {
			\ 'buffers': 'lightline#bufferline#buffers'
			\ }
		let g:lightline.component_type = { 'buffers': 'tabsel' }
		let g:lightline.component_function = {
			\ 'gitbranch': 'LightlineGit',
			\ 'filename': 'LightlineFilename',
			\ 'fileformat': 'LightlineFormat',
			\ 'fileencoding': 'LightlineEncoding'
			\ }
		let g:lightline.tab = {
			\ 'active': [ 'active_l', 'tabnum', 'active_r' ],
			\ 'inactive': [ 'inactive', 'tabnum', 'inactive' ]
			\ }
		let g:lightline.tab_component = {
			\ 'active_l': '<',
			\ 'active_r': '>',
			\ 'inactive': ' '
			\ }
		autocmd BufWritePost,TextChanged,TextChangedI * call lightline#update()
	" }}}
	" lightline-bufferline {{{
		if !empty($UNICODE_FONT)
			let g:lightline#bufferline#enable_devicons = 1
			let g:lightline#bufferline#unicode_symbols = 1
		endif
		let g:lightline#bufferline#show_number=2
		let g:lightline#bufferline#unnamed="[No Name]"
		nmap <Leader>1 <Plug>lightline#bufferline#go(1)
		nmap <Leader>2 <Plug>lightline#bufferline#go(2)
		nmap <Leader>3 <Plug>lightline#bufferline#go(3)
		nmap <Leader>4 <Plug>lightline#bufferline#go(4)
		nmap <Leader>5 <Plug>lightline#bufferline#go(5)
		nmap <Leader>6 <Plug>lightline#bufferline#go(6)
		nmap <Leader>7 <Plug>lightline#bufferline#go(7)
		nmap <Leader>8 <Plug>lightline#bufferline#go(8)
		nmap <Leader>9 <Plug>lightline#bufferline#go(9)
		nmap <Leader>0 <Plug>lightline#bufferline#go(10)
		set laststatus=2
		set showtabline=2
		set noshowmode
	" }}}
	" vim-go {{{
		let g:go_bin_path = $HOME . '/.backpack/pkg/go/bin'
	"}}}
" }}}
" Theme {{{
	set termguicolors
	set background=dark
	colorscheme night-owl
" }}}
