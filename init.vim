" compatibility / system settings {{{
	set foldenable
	set foldmethod=marker
	set nocompatible
	set encoding=utf-8
	scriptencoding utf-8
" }}}
" vanilla autocommands {{{
	autocmd!
	au bufnewfile,bufread *.cpp,*.tpp,*.hpp,*.c,*.h set cindent
	au bufnewfile,bufread conkyrc set filetype=lua
" }}}
" general configuration {{{
	syntax on
	set showcmd
	set noerrorbells
	set ruler
	set laststatus=2
	set confirm
	set modeline
	set listchars=eol:$
	set showbreak=↪\
	set listchars+=tab:»\ ,extends:›,precedes:‹,nbsp:·,trail:·
	set shiftround
	set autoindent
	set matchtime=1
	set hidden
	set history=100
	set equalalways
	set eadirection=both
	set tabpagemax=50
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
" mappings {{{
	" quick buffer list and selection
	nnoremap <leader>b :ls<cr>:b

	" cycle through buffer
	nnoremap <leader>[ :bp<cr>
	nnoremap <leader>] :bn<cr>

	" vim ctrl+space for esc
	inoremap <nul> <esc>:noh<cr>
	" same for neovim
	inoremap <c-space> <esc>:noh<cr>

	" neovim terminal mode
	tnoremap <esc> <c-\><c-n>
	tnoremap <c-space> <c-\><c-n>

	" quick quit
	nnoremap <leader>q :bd<cr>

" }}}
" list of plugins {{{
	call plug#begin('~/.config/nvim/plugins')

	Plug 'haishanh/night-owl.vim'
	Plug 'sainnhe/vim-color-forest-night'
	Plug 'sickill/vim-monokai'
	Plug 'sonph/onehalf'
	Plug 'altercation/vim-colors-solarized'
	Plug 'dracula/vim'
	Plug 'morhetz/gruvbox'
	Plug 'luochen1990/rainbow'
	Plug 'ryanoasis/vim-devicons'
	Plug 'itchyny/lightline.vim'
	Plug 'mengelbrecht/lightline-bufferline'
	Plug 'machakann/vim-highlightedyank'
	Plug 'thinca/vim-ref'
	Plug 'keith/investigate.vim'
	Plug 'sheerun/vim-polyglot'
	Plug 'pbrisbin/vim-mkdir'
	Plug 'tpope/vim-sleuth'
	Plug 'tpope/vim-apathy'
	Plug 'tpope/vim-vinegar'
	Plug 'tpope/vim-endwise'
	Plug 'jeetsukumaran/vim-indentwise'
	Plug 'sgur/vim-editorconfig'
	Plug 'tpope/vim-fugitive'
	Plug 'ajh17/vimcompletesme'
	Plug 'vim-scripts/taglist.vim'
	Plug 'wvffle/vimterm'
	Plug 'mattboehm/vim-unstack'
	Plug 'justincampbell/vim-eighties'
	Plug 'bfrg/vim-cpp-modern'
	Plug 'tbastos/vim-lua'
	Plug 'vim-scripts/ScrollColors'
	Plug 'vitalk/vim-shebang'
	Plug 'lfv89/vim-interestingwords'

	call plug#end()
" }}}
" Plugin Configuration {{{
	" highlightedyank {{{
		let g:highlightedyank_highlight_duration = 100
	" }}}
	" vimcompletesme {{{
		autocmd FileType vim let b:vcm_tab_complete = 'vim'
	" }}}
	" rainbow {{{
		let g:rainbow_active = 1
	" }}}
	" vimterm {{{
		nnoremap <leader>T :call vimterm#toggle() <CR>
		tnoremap <leader>T <C-\><C-n>:call vimterm#toggle() <CR>
	" }}}
	" taglist {{{
		nmap <leader>t :TlistToggle<CR>
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

		let g:lightline = { 'colorscheme': 'jellybeans' }
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
	" rainbow_levels.vim {{{
		nnoremap <leader>r :RainbowLevelsToggle<CR>
		hi! RainbowLevel0 ctermbg=240 guibg=#585858
		hi! RainbowLevel1 ctermbg=239 guibg=#4e4e4e
		hi! RainbowLevel2 ctermbg=238 guibg=#444444
		hi! RainbowLevel3 ctermbg=237 guibg=#3a3a3a
		hi! RainbowLevel4 ctermbg=236 guibg=#303030
		hi! RainbowLevel5 ctermbg=235 guibg=#262626
		hi! RainbowLevel6 ctermbg=234 guibg=#1c1c1c
		hi! RainbowLevel7 ctermbg=233 guibg=#121212
		hi! RainbowLevel8 ctermbg=232 guibg=#080808
	" }}}
	" interestingwords {{{
		" let g:interestingWordsGUIColors = ['#8CCBEA', '#A4E57E', '#FFDB72', '#FF7272', '#FFB3FF', '#9999FF']
		" let g:interestingWordsTermColors = ['154', '121', '211', '137', '214', '222']
	" }}}
" }}}
" Theme {{{
	set termguicolors
	set background=dark
	let g:gruvbox_italic=1
	colorscheme gruvbox
	if exists('$TMUX')
		highlight Normal ctermbg=NONE guibg=NONE
	endif
	highlight Folded ctermbg=NONE guibg=NONE cterm=italic gui=italic
" }}}
