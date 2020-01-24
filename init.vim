
" {{{
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
" Don't show the active mode
set noshowmode
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
" Set US English for spellcheck
set spelllang=en_us
" Always show statusbar
set laststatus=2
" Don't wrap lines by default
set nowrap
" Don't page output
set nomore
" Use relative line numbers
set relativenumber
set number
" }}}

" Plugins {{{
call plug#begin('~/.config/nvim/plugins')

Plug 'junegunn/fzf', {
	\'dir': '~/.fzf',
	\'do': './install --all' }    " Fuzzy finder
Plug 'junegunn/fzf.vim'               " FZF helpful functions
Plug 'srcery-colors/srcery-vim'       " Pretty colors
Plug 'ajh17/vimcompletesme'           " Simple autocomplete
Plug 'tpope/vim-unimpaired'           " Adds a lot of useful next / prev maps
Plug 'machakann/vim-sandwich'         " Adds sa, sc, and sd commands to change / delete surrounding chars
Plug 'tpope/vim-repeat'               " Repeat plugin commands with .
Plug 'tpope/vim-abolish'              " Gives :S that does search and replace maintaining case, and more
Plug 'sheerun/vim-polyglot'           " Language megapack
Plug 'vim-scripts/taglist.vim'        " Tag browser
Plug 'tpope/vim-sleuth'               " Auto detect project format settings
Plug 'tpope/vim-eunuch'               " Unix filesystem tools like :Rename and :SudoWrite
Plug 'ludovicchabant/vim-gutentags'   " Automatic tag management
Plug 'jeetsukumaran/vim-indentwise'   " Navigate through indented areas with [- [+ [= ]- ]+ ]=
Plug 'uarun/vim-protobuf'             " Protobuf syntax highlighting
Plug 'vim-jp/vim-cpp'                 " Updated syntax for C++11
Plug 'raimon49/requirements.txt.vim'  " requirements.txt highlighting
Plug 'justinmk/vim-syntax-extra'      " bison, flex, and better c syntax
Plug 'unblevable/quick-scope'         " View targets of f F t T commands with color
Plug 'machakann/vim-highlightedyank'  " Visualize the region of text copied
Plug 'bling/vim-bufferline'           " Show open buffers in statusline
Plug 'thinca/vim-ref'                 " Better lookups for K
Plug 'luochen1990/rainbow'            " rainbow parenthesis
Plug 'potatoesmaster/i3-vim-syntax'   " i3 config syntax
Plug 'gioele/vim-autoswap'            " Automatically handle annoying swapfile messages
Plug 'keith/investigate.vim'          " Look up documentation on the cursor word with gK
Plug 'datawraith/auto_mkdir'          " Automatically mkdir if path doesn't exist
Plug 'jvirtanen/vim-octave'           " Octave syntax highlighting
Plug 'wellle/visual-split.vim'        " Open a visual selection in a split or resize split to selection \gr \gss
Plug 'tweekmonster/gofmt.vim'         " Call gofmt on save of .go files
Plug 'Lenovsky/nuake'                 " Quick drop-down terminal
Plug 'andymass/vim-matchup'           " Extend % to work with language specific keywords. Adds [% ]%
Plug 'auxiliary/vim-layout'           " Automatically open files in splits when passed as cli args
Plug 'thaerkh/vim-workspace'          " Persistent auto-loading workspaces
Plug 'reedes/vim-litecorrect'         " Lightweight auto-correct
Plug 'dbestevez/keepcursor.vim'       " Don't move cursor when leaving insert mode
Plug 'FooSoft/vim-argwrap'            " wrap / unwrap argument lists with a command
Plug 'machakann/vim-swap'             " Manipulate argument lists with g< g>, interactively with gs
Plug 'tpope/vim-vinegar'              " File Browser
Plug 'junegunn/vim-easy-align'        " Adds operator to align text

call plug#end()
" }}}

let g:matchup_matchparen_offscreen = {}

" From FZF example configs, opens FZF in floating window
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

augroup ColorModifications
	autocmd!
	autocmd ColorScheme * highlight QuickScopePrimary
		\ guibg='#00ff00' guifg='#000000' gui=underline,bold,reverse
		\ ctermfg=2 ctermbg=0 cterm=underline,bold,reverse
	autocmd ColorScheme * highlight QuickScopeSecondary
		\ guibg='#00ffff' guifg='#000000' gui=underline,bold,reverse
		\ ctermfg=6 ctermbg=0 cterm=underline,bold,reverse
	" Make folds blend in so that the status bar and splits are easier to identify
	autocmd ColorScheme * hi Folded ctermbg=None guibg=None cterm=italic gui=italic
	autocmd ColorScheme * hi LineNr ctermbg=7 ctermfg=16 guifg='#D0BFA1' guibg='#262626'
	autocmd ColorScheme * hi CursorLineNr ctermbg=7 ctermfg=16 guifg='#D0BFA1' guibg='#918175'
	autocmd ColorScheme * hi StatusLineNC guibg='#121212' gui=none ctermbg=0 cterm=none
augroup END

let g:workspace_autosave = 0
let g:gutentags_ctags_tagfile='.tags'
" Nuake
let g:nuake_position = 'top'
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
let g:highlightedyank_highlight_duration = 100
let g:strip_whitespace_on_save = 1
let g:rainbow_active = 1
let g:srcery_italic = 1

function StatusMode(modestr)
	let result = ' '
	if a:modestr ==# 'i'
		hi link StatusLine InsertMode
		let result = ' INSERT '
	elseif a:modestr ==# 'r'
		hi link StatusLine ReplaceMode
		let result = ' REPLACE '
	elseif a:modestr ==# 't'
		hi link StatusLine TerminalMode
		let result = ' TERMINAL '
	elseif a:modestr ==# 'n'
		hi link StatusLine NormalMode
		let result = ' NORMAL '
	elseif a:modestr ==# 'v'
		hi link StatusLine VisualMode
		let result = ' VISUAL '
	elseif a:modestr ==# 'c'
		hi link StatusLine CommandMode
		let result = ' COMMAND '
	elseif a:modestr ==# '!'
		let result = ' SHELL '
		hi link StatusLine ShellMode
	else
		let result = ' NORMAL '
		hi link StatusLine InactiveMode
	endif
	return ' '.result
endfunc

function HelpStatus()
	return 'Help: '.expand('%:t')
endfunc

function TagListStatus()
	return 'Tag List'
endfunc

function StatusLeft()
	let filename = expand('%') !=# '' ? expand('%') : '[No Name]'
	let modified = &modified ? '+' : ''
	let ro = &readonly ? ' [RO]' : ''
	return '  '.filename.modified.ro
endfunc

function StatusRight()
	let lchars = strlen(line('$'))
	return virtcol('.').' : '.printf('%'.lchars.'d / %'.lchars.'d', line('.'), line('$'))
	return result
endfunc

function SetColors()
	hi NormalMode   guifg='#000000' guibg='#D0BFA1' gui=bold
	hi VisualMode   guifg='#000000' guibg='#2C78BF' gui=bold
	hi InsertMode   guifg='#000000' guibg='#FBB829' gui=bold
	hi ReplaceMode  guifg='#000000' guibg='#FF5F00' gui=bold
	hi TerminalMode guifg='#000000' guibg='#519F50' gui=bold
	hi CommandMode  guifg='#000000' guibg='#E02C6D' gui=bold
	hi ShellMode    guifg='#000000' guibg='#53FDE9' gui=bold
	hi OtherMode    guifg='#000000' guibg='#EF2F27' gui=bold
	hi InactiveMode guifg='#000000' guibg='#3A3A3A'
	return ''
endfunc

function SetFocusedStatus()
	if &ft ==# 'help'
		setlocal statusline=%{HelpStatus()}
	elseif &ft ==# 'taglist'
		setlocal statusline=%{TagListStatus()}
	else
		setlocal statusline=%{SetColors()}
		setlocal statusline+=%#InsertMode#%{(mode()[0]==#'i')?StatusMode('i'):''}
		setlocal statusline+=%#ReplaceMode#%{(mode()[0]==#'R')?StatusMode('r'):''}
		setlocal statusline+=%#TerminalMode#%{(mode()[0]==#'t')?StatusMode('t'):''}
		setlocal statusline+=%#VisualMode#%{(mode()[0]==#'v')?StatusMode('v'):''}
		setlocal statusline+=%#VisualMode#%{(mode()[0]==#'V')?StatusMode('v'):''}
		setlocal statusline+=%#VisualMode#%{(char2nr(mode()[0])==0x16)?StatusMode('v'):''}
		setlocal statusline+=%#CommandMode#%{(mode()[0]==#'c')?StatusMode('c'):''}
		setlocal statusline+=%#OtherMode#%{(mode()[0]==#'r')?StatusMode('r'):''}
		setlocal statusline+=%#OtherMode#%{(mode()[0]==#'!')?StatusMode('!'):''}
		setlocal statusline+=%#NormalMode#%{(mode()[0]==#'n')?StatusMode('n'):''}
		setlocal statusline+=%*
		setlocal statusline+=%{StatusLeft()}
		setlocal statusline+=%=
		setlocal statusline+=%{StatusRight()}
	endif
endfunc


function SetUnfocusedStatus()
	if &ft ==# 'help'
		setlocal statusline=%{HelpStatus()}
	elseif &ft ==# 'taglist'
		setlocal statusline=%{TagListStatus()}
	else
		setlocal statusline=%{SetColors()}
		setlocal statusline+=%#InactiveMode#%{StatusMode('')}
		setlocal statusline+=%*
		setlocal statusline+=%{StatusLeft()}
		setlocal statusline+=%=
		setlocal statusline+=%{StatusRight()}
	endif
endfunc

augroup StatusStuff
	au!
	au WinEnter,BufEnter * call SetFocusedStatus()
	au WinLeave,BufLeave * call SetUnfocusedStatus()
augroup END

" TODO: set statusline contents for terminal and help

xmap <leader>a <Plug>(EasyAlign)
nmap <leader>a <Plug>(EasyAlign)

" Nuake quick-terminal toggle with Ctrl+Enter
nnoremap <c-j> :Nuake<cr>
inoremap <c-j> <c-\><c-n>:Nuake<cr>
tnoremap <c-j> <c-\><c-n>:Nuake<cr>
" Navigate out of terminal mode more easily
tnoremap <esc> <c-\><c-n>
tnoremap <c-w> <c-\><c-n><c-w>
" Pin visual selection at top of screen in new split
vnoremap <pageup> :VSSplitAbove<cr>
" Pin visual selection at bottom of screen in new split
vnoremap <pagedown> :VSSplitBelow<cr>
" Resize split to selection
vnoremap <return> :VSResize<cr>
" Tag List
nnoremap <leader>T :TlistToggle<cr>
" normal mode fzf
nnoremap <leader>f :Files<cr>
nnoremap <leader>g :Ag<cr>
nnoremap <leader>b :Buffers<cr>
nnoremap <leader>w :Lines<cr>
nnoremap <leader>t :Tags<cr>
nnoremap <leader>C :Colors<cr>
" Reset layout
nnoremap <leader>r <C-W>=
" Quick reload of vimrc
nnoremap <leader>R :source $MYVIMRC<cr>
" Toggle spellcheck
nnoremap <leader>S :set spell!<cr>
" Quickly close a window
nnoremap <leader>q :q<cr>
" Set the current working directory as a workspace
nnoremap <leader>W :ToggleWorkspace<cr>
" , . make more sense for navigating back / forward with last movement
nnoremap . ;
nnoremap ; .
" Split / join toggle
nnoremap <leader>s :ArgWrap<cr> "

" Theme {{{

try
	set termguicolors
	colorscheme srcery

catch /.*/
	try
		colorscheme srcery
	catch /.*/
		colorscheme blue
	endtry
endtry


" }}}

" Keymap Summary
" ==============
"	\R              :source $MYVIMRC
" 	\s              toggle spellcheck
" 	\r              reset window sizes
" argwrap
" 	\a              Toggles wrap for current block
" swap
" 	gs              Enter interactive swap
" 	g<              Move comma separated item left
" 	g>              Move comma separated item right
" Nuake Terminal
" 	Ctrl-j          terminal Toggle
" Easy Indent
" 	ga<align-char>  Align section by align-char (normal or visual)
" Surround
"	ds              Delete Surround
"	cs              Change Surround
"	ys              Surround text object ('you surround')
"	S               Surround (visual mode)
" TagList
"	\T              Toggle taglist
" FZF
"	\f              Find file
"	\g              Grep
"	\b              Select buffer
"	\w              Find in open buffers
"	\t              Find in tags
"	\C              List of colorschemes
" Visual Split (all in visual mode)
"	<Enter>         Resize split to visual selection
"	<PageUp>        Split out visual selection above
"	<PageDown>      Split out visual selection below
" IndentWise
"	[-              Previous block with less indentation
"	[+              Previous block with more indentation
"	[=              Previous block with same indentation
"	]-              Next block with less indentation
"	]+              Next block with more indentation
"	]=              Next block with same indentation
" Unimpaired
"	[a              Previous file in arglist
"	]a              Next file in arglist
"	[A              First file in arglist
"	]A              Last file in arglist
"	[b              Previous buffer
"	]b              Next buffer
"	[B              First buffer
"	]B              Last buffer
"	[l              Previous location list entry
"	]l              Next location list entry
"	[L              First location list entry
"	]L              Last location list entry
"	[<C-L>*         Previous file in location list
"	]<C-L>*         Next file in location list
"	[q              Previous quickfix list entry
"	]q              Next quickfix list entry
"	[Q              First quickfix list entry
"	]Q              Last quickfix list entry
"	[t              Previous tag match
"	]t              Next tag match
"	[T              First tag match
"	]T              Last tag match
"	[<C-T>          Previous preview tag match
"	]<C-T>          Next preview tag match
