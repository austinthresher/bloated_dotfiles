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

set fillchars=stl:\ ,stlnc:\ ,fold:\ ,vert:'

" === maps ===

" Edit and source .vimrc shortcuts
nnoremap <leader>ev :vsplit $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>

nnoremap <F5> "=strftime("%b %d, %Y")<CR>P
inoremap <F5> <C-R>=strftime("%b %d, %Y")<CR>

" Quick buffer list and selection
nnoremap <leader>b :ls<CR>:b

" Cycle through buffer
nnoremap <leader>[ :bp<CR>
nnoremap <leader>] :bn<CR>

" vim ctrl+space for esc
inoremap <NUL> <ESC>:noh<CR>
" same for neovim
inoremap <C-Space> <ESC>:noh<CR>

" Readline / emacs style navigation in input mode
inoremap <c-a> <c-o>^
inoremap <c-e> <c-o>$
inoremap <c-f> <c-o>l
inoremap <c-b> <c-o>h
inoremap <c-d> <c-o>x
inoremap <c-k> <c-o>d$
inoremap <c-u> <c-o>d0
inoremap <c-w> <c-o>dB
inoremap <c-x> <c-o>dW

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

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'
Plug 'sheerun/vim-polyglot'
Plug 'sainnhe/vim-color-forest-night'
Plug 'luochen1990/rainbow'
Plug 'justinmk/vim-sneak'
Plug 'bling/vim-bufferline'
Plug 'thinca/vim-ref'
Plug 'danro/rename.vim'
Plug 'pbrisbin/vim-mkdir'
Plug 'vim-scripts/ShowTrailingWhitespace'
Plug 'vim-scripts/DeleteTrailingWhitespace'
Plug 'ciaranm/detectindent'
Plug 'roman/golden-ratio'
Plug 'ajh17/vimcompletesme'
Plug 'unblevable/quick-scope'

Plug 'terryma/vim-multiple-cursors'
Plug 'fatih/vim-go'
Plug 'Shougo/defx.nvim'
Plug 'ryanoasis/vim-devicons'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'tell-k/vim-autopep8'
Plug 'dkprice/vim-easygrep'
Plug 'thinca/vim-ref'
Plug 'valloric/listtoggle'
Plug 'vim-voom/voom'
Plug 'jeetsukumaran/vim-indentwise'
Plug 'keith/investigate.vim'
Plug 'sgur/vim-editorconfig'
Plug 'haishanh/night-owl.vim'
Plug 'vim-scripts/errormarker.vim'
Plug 'liuchengxu/vim-which-key'
Plug 'mbbill/echofunc'
Plug 'aaronbieber/vim-quicktask'
Plug 'junegunn/vim-journal'
Plug 'amix/open_file_under_cursor.vim'

call plug#end()

let g:rainbow_active = 1
let g:autopep8_on_save = 1
let g:qs_highlight_on_keys = ['f', 'F']

set termguicolors
set background=dark
colorscheme night-owl
