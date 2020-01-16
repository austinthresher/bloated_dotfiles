" compatibility / system settings {{{
	set foldenable
	set foldmethod=marker
	set nocompatible
	set encoding=utf-8
	scriptencoding utf-8
	set noicon
	set notitle
	set titleold=
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
" mappings {{{
	" insert date
	nnoremap <leader>d "=strftime("%b %d, %y")<cr>p
	inoremap <leader>d <c-r>=strftime("%b %d, %y")<cr>

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

	" colorschemes
	Plug 'haishanh/night-owl.vim'
	Plug 'sainnhe/vim-color-forest-night'
	Plug 'sickill/vim-monokai'
	Plug 'sonph/onehalf'
	Plug 'altercation/vim-colors-solarized'
	Plug 'dracula/vim'
	Plug 'morhetz/gruvbox'

	" style / visual tweaks
	Plug 'luochen1990/rainbow'
	Plug 'ryanoasis/vim-devicons'
	Plug 'vim-scripts/errormarker.vim'
	Plug 'unblevable/quick-scope'
	Plug 'airblade/vim-gitgutter'
	Plug 'itchyny/lightline.vim'
	Plug 'mengelbrecht/lightline-bufferline'
	Plug 'machakann/vim-highlightedyank'
	Plug 'jaxbot/semantic-highlight.vim'
	Plug 'thiagoalessio/rainbow_levels.vim'
	Plug 'valloric/vim-indent-guides'

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

	" misc utility
	Plug 'pbrisbin/vim-mkdir'
	Plug 'tpope/vim-sleuth'
	Plug 'tpope/vim-apathy'
	Plug 'tpope/vim-vinegar'
	Plug 'tpope/vim-endwise'
	Plug 'jeetsukumaran/vim-indentwise'
	Plug 'sgur/vim-editorconfig'
	Plug 'valloric/listtoggle'
	Plug 'tpope/vim-fugitive'
	Plug 'ajh17/vimcompletesme'
	Plug 'majutsushi/tagbar' " TODO: Decide between these two
	Plug 'vim-scripts/taglist.vim'
	Plug 'wvffle/vimterm'
	Plug 'mattboehm/vim-unstack'

	" TODO: make these play nice together or write something similar
	Plug 'mattboehm/vim-accordion'
	Plug 'justincampbell/vim-eighties'

	" TODO: organize/test these
	Plug 'ehamberg/vim-cute-python'
	Plug 'bfrg/vim-cpp-modern'
	Plug 'tbastos/vim-lua'
	Plug 'skywind3000/vim-quickui'
	Plug 'vim-scripts/ScrollColors'
	Plug 'godlygeek/tabular'
	Plug 'irrationalistic/vim-tasks'
	Plug 'vim-scripts/json-formatter.vim'
	Plug 'vitalk/vim-shebang'
	Plug 'dkprice/vim-easygrep'
	Plug 'amix/open_file_under_cursor.vim'
	Plug 'lfv89/vim-interestingwords'

	" TODO: test these
	" Plug 'lfv89/vim-foldfocus'
	" Plug 'thirtythreeforty/lessspace.vim'
	" Plug 'metakirby5/codi.vim'
	" Plug 'terryma/vim-multiple-cursors'
	" Plug 'Shougo/defx.nvim'
	" Plug 'tmux-plugins/vim-tmux-focus-events'
	" Plug 'vim-voom/voom'
	" Plug 'liuchengxu/vim-which-key'
	" Plug 'mbbill/echofunc'
	" Plug 'aaronbieber/vim-quicktask'
	" Plug 'junegunn/vim-journal'
	" Plug 'andrewradev/splitjoin.vim'
	" Plug 'kana/vim-submode'
	" Plug 'tommcdo/vim-lion'

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
	" semantic-highlight.vim {{{
		nnoremap <leader>h :SemanticHighlightToggle<CR>
		" leg s:semanticGUIColors = [ '#72d572', '#c5e1a5', '#e6ee9c', '#fff59d', '#ffe082', '#ffcc80', '#ffab91', '#bcaaa4', '#b0bec5', '#ffa726', '#ff8a65', '#f9bdbb', '#f9bdbb', '#f8bbd0', '#e1bee7', '#d1c4e9', '#ffe0b2', '#c5cae9', '#d0d9ff', '#b3e5fc', '#b2ebf2', '#b2dfdb', '#a3e9a4', '#dcedc8' , '#f0f4c3', '#ffb74d' ]
		" let g:semanticTermColors = [28,1,2,3,4,5,6,7,25,9,10,34,12,13,14,15,16,125,124,19]
	"}}}
	" filestyle {{{
"		let g:filestyle_ignore = ['text', 'tagbar', 'help']
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
	highlight Normal ctermbg=NONE guibg=NONE
	highlight Folded ctermbg=NONE guibg=NONE
" }}}
