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

" Plugins {{{

call plug#begin('~/.config/nvim/plugins')

" Pretty colors
Plug 'morhetz/gruvbox'
Plug 'KeitaNakamura/neodark.vim'
Plug 'noahfrederick/vim-hemisu'
Plug 'connorholyday/vim-snazzy'
Plug 'vim-scripts/phd'
Plug 'vim-scripts/pyte'
Plug 'vim-scripts/twilight'
Plug 'haishanh/night-owl.vim'
Plug 'liuchengxu/space-vim-theme'
Plug 'jacoborus/tender'
Plug 'colepeters/spacemacs-theme.vim'
Plug 'nielsmadan/harlequin'
Plug 'aonemd/kuroi.vim'
Plug 'nequo/vim-allomancer'
Plug 'zanglg/nova.vim'
Plug 'sainnhe/vim-color-forest-night'
Plug 'alessandroyorba/alduin'
Plug 'srcery-colors/srcery-vim'
Plug 'nightsense/snow'
Plug 'shinchu/lightline-gruvbox.vim'
Plug 'phanviet/vim-monokai-pro'

" Fuzzy finder
Plug 'junegunn/fzf', {
	\ 'dir': '~/.fzf',
	\ 'do': './install --all'
	\ }
Plug 'junegunn/fzf.vim'
" lightline statusline
Plug 'itchyny/lightline.vim'
" Simple autocomplete
Plug 'ajh17/vimcompletesme'
" Adds a lot of useful next / prev maps
Plug 'tpope/vim-unimpaired'
" Adds cs and ds commands to change / delete surrounding chars
Plug 'tpope/vim-surround'
" Repeat plugin commands with .
Plug 'tpope/vim-repeat'
" Language megapack
Plug 'sheerun/vim-polyglot'
" Tag browser
Plug 'vim-scripts/taglist.vim'
" Filetype icons
Plug 'ryanoasis/vim-devicons'
" Auto detect project format settings
Plug 'tpope/vim-sleuth'
" Unix filesystem tools like :Rename and :SudoWrite
Plug 'tpope/vim-eunuch'
" Split or join a block with gS and gJ
Plug 'andrewradev/splitjoin.vim'
" Automatic tag management
Plug 'ludovicchabant/vim-gutentags'
" Navigate through indented areas with [- [+ [= ]- ]+ ]=
Plug 'jeetsukumaran/vim-indentwise'
" Protobuf syntax highlighting
Plug 'uarun/vim-protobuf'
" Updated syntax for C++11
Plug 'vim-jp/vim-cpp'
" requirements.txt highlighting
Plug 'raimon49/requirements.txt.vim'
" bison, flex, and better c syntax
Plug 'justinmk/vim-syntax-extra'
" View targets of f F t T commands with color
Plug 'unblevable/quick-scope'
" Visualize the region of text copied
Plug 'machakann/vim-highlightedyank'
" Automatically show completions
Plug 'vim-scripts/AutoComplPop'
" Show open buffers in statusline
Plug 'bling/vim-bufferline'
" Better lookups for K
Plug 'thinca/vim-ref'
" strip whitespace on save
Plug 'ntpeters/vim-better-whitespace'
" Select increasing region with Enter
Plug 'gcmt/wildfire.vim'
" rainbow parenthesis
Plug 'luochen1990/rainbow'
" Open files at the same place they were left
Plug 'farmergreg/vim-lastplace'
" i3 config syntax
Plug 'potatoesmaster/i3-vim-syntax'
" Automatically handle annoying swapfile messages
Plug 'gioele/vim-autoswap'
" Look up documentation on the cursor word with gK
Plug 'keith/investigate.vim'
" Automatically mkdir if path doesn't exist
Plug 'datawraith/auto_mkdir'
" Octave syntax highlighting
Plug 'jvirtanen/vim-octave'
" Show errors in realtime
Plug 'dense-analysis/ale'
" Open a visual selection in a split or resize split to selection \gr \gss
Plug 'wellle/visual-split.vim'
" Autocorrect common typos (this probably slows down loading a lot)
Plug 'panozzaj/vim-autocorrect'

call plug#end()

" }}}

let $FZF_DEFAULT_OPTS .= ' --border --margin=0,2'
function! FloatingFZF()
	let width = float2nr(&columns * 0.9)
	let height = float2nr(&lines * 0.6)
	let opts = {
		\ 'relative': 'editor',
		\ 'row': (&lines - height) / 2,
		\ 'col': (&columns - width) / 2,
		\ 'width': width,
		\ 'height': height
		\ }
	let win = nvim_open_win(nvim_create_buf(v:false, v:true), v:true, opts)
	call setwinvar(win, '&winhighlight', 'NormalFloat:Normal')
endfunction
let g:fzf_layout = { 'window': 'call FloatingFZF()' }
command! -bang -nargs=? -complete=dir Files
	\ call fzf#vim#files(
		\ <q-args>,
		\ {'options': ['--info=inline', '--preview', 'cat {}']}
		\)

autocmd FileType vim let b:vcm_tab_complete = 'vim'

set statusline+=%{gutentags#statusline()}
let g:gutentags_ctags_tagfile='.tags'
let g:qs_highlight_on_keys = ['f', 'F']
let g:qs_lazy_highlight = 1
let g:highlightedyank_highlight_duration = 100
let g:strip_whitespace_on_save = 1
let g:rainbow_active = 1
let g:neodark#terminal_transparent = 1
let g:SnazzyTransparent = 1


let g:lightline = {
	\ 'colorscheme': 'gruvbox'
	"\ 'colorscheme': 'snow_light'
	"\ 'colorscheme': 'snow_dark'
	"\ 'colorscheme': 'srcery'
	"\ 'colorscheme': 'forest_night'
	"\ 'colorscheme': 'tender'
	"\ 'colorscheme': 'neodark'
	"\ 'colorscheme': 'snazzy'
	\ }

" Tag List
nnoremap <leader>T :TlistToggle<cr>
" normal mode fzf
nnoremap <leader>f :Files<cr>
nnoremap <leader>g :Ag<cr>
nnoremap <leader>b :Buffers<cr>
nnoremap <leader>w :Lines<cr>
nnoremap <leader>t :Tags<cr>
nnoremap <leader>C :Colors<cr>

" Quick reload of vimrc
nnoremap <leader>R :source $MYVIMRC<cr>


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

" Experimental

set spelllang=en_us
nnoremap <leader>s :set spell!<cr>

" Keymap Summary
" ==============
"	ds      Delete Surround
"	cs      Change Surround
"	ys      surround text object ('you surround')
"	S       surround (visual mode)
"	\R      :source $MYVIMRC
"	\T      :TlistToggle
"	\f      :Files
"	\g      :Ag
"	\b      :Buffers
"	\w      :Lines
"	\t      :Tags
"	\C      :Colors
"	[a      :previous
"	]a      :next
"	[A      :first
"	]A      :last
"	[b      :bprevious
"	]b      :bnext
"	[B      :bfirst
"	]B      :blast
"	[l      :lprevious
"	]l      :lnext
"	[L      :lfirst
"	]L      :llast
"	[<C-L>* :lpfile
"	]<C-L>* :lnfile
"	[q      :cprevious
"	]q      :cnext
"	[Q      :cfirst
"	]Q      :clast
"	[t      :tprevious
"	]t      :tnext
"	[T      :tfirst
"	]T      :tlast
"	[<C-T>  :ptprevious
"	]<C-T>  :ptnext
