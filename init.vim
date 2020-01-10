set nocompatible
set encoding=utf-8
scriptencoding utf-8

set noicon
set notitle
set titleold=

function! KernelTabs()
	set shiftwidth=8
	set tabstop=8
	set softtabstop=8
	set noexpandtab
endfunction

function! SpaceTabs()
	set shiftwidth=4
	set softtabstop=4
	set expandtab
endfunction

function! PVTabs()
	set shiftwidth=3
	set tabstop=3
	set softtabstop=3
	set expandtab
endfunction

function! TODODate()
	let pos = getpos(".")
	let lines = line("$")
	silent! execute "normal! :1g/^[A-Z][a-z]*,.*,.*$/d\<cr>"
	silent! execute "normal! :1g/^=*$/d\<cr>"
	" Either replace the deleted lines, or insert
	" new lines because there was no date at the top
	let removed = lines - line("$")
	if removed
		execute "normal! :0\<cr>" . removed . "O\<Esc>"
	else
		execute "normal! :0\<cr>2O\<Esc>"
	endif
	let newtime = strftime("%A, %B %d, %Y")
	execute "normal! :1\<cr>i" . newtime . "\<Esc>"
	execute "normal! :2\<cr>" . strlen(newtime) . "i=\<Esc>"
	call setpos(".", pos)
endfunction

call KernelTabs()

autocmd!

au BufNewFile,BufRead *.py call SpaceTabs()

au BufNewFile,BufRead *.s set syntax=a65
au BufNewFile,BufRead *.s,*.asm,*.z80,*.inc call KernelTabs()

au BufNewFile,BufRead *.tpp set filetype=cpp
au BufNewFile,BufRead */OpenPV/*,$HOME/OpenPV call PVTabs()

au BufNewFile,BufRead *.cpp,*.tpp,*.hpp,*.c,*.h set cindent

" Automatically update the date on my todo list when saved
au BufWritePre TODO.md call TODODate()

set background=dark
"colorscheme luna

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

" === maps ===

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

set mouse=a

" neovim terminal mode
:tnoremap <Esc> <C-\><C-n>
:tnoremap <C-Space> <C-\><C-n>

nnoremap <Leader>q :bd<CR>

let g:highlightedyank_highlight_duration = 100

autocmd FileType vim let b:vcm_tab_complete = 'vim'

let g:lt_location_list_toggle_map = '<leader>L'
let g:lt_quickfix_list_toggle_map = '<leader>l'

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

" luochen1990/rainbow
let g:rainbow_active = 1

" unblevable/quick-scope
let g:qs_highlight_on_keys = ['f', 'F']

" wvffle/vimterm
nnoremap <leader>T :call vimterm#toggle() <CR>
tnoremap <leader>T <C-\><C-n>:call vimterm#toggle() <CR>

" majutsushi/tagbar
nmap <leader>t :TagbarToggle<CR>

" justincampbell/vim-eighties
let g:eighties_enabled = 1
let g:eighties_minimum_width = 80
let g:eighties_extra_width = 0
let g:eighties_compute = 1
let g:eighties_bufname_additional_patterns = []

" itchyny/lightline-vim
function! LightlineGit()
	return fugitive#head() !=# '' ? $GIT_ICON . ' ' . fugitive#head() : ''
endfunction
function! LightlineFilename()
	let filename = expand('%:t') !=# '' ? expand('%:t') : '[No Name]'
	let modified = &modified ? '+' : ''
	return filename . modified
endfunction
let g:lightline = { 'colorscheme': 'powerlineish' }
let g:lightline.active = { 'left': [], 'right': [] }
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
let g:lightline.tabline = { 'left': [['buffers']], 'right': [['tabs']] }
let g:lightline.component_expand = {
	\ 'buffers': 'lightline#bufferline#buffers'
	\ }
let g:lightline.component_type = { 'buffers': 'tabsel' }
let g:lightline.component_function = {
	\ 'gitbranch': 'LightlineGit',
	\ 'filename': 'LightlineFilename'
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

" lightline-bufferline
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

" colorscheme
set termguicolors
set background=dark
colorscheme night-owl

