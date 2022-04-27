set encoding=utf-8 | scriptencoding utf-8

set autoindent
set backspace=indent,eol,start
set eadirection=both
set equalalways
set expandtab
set fillchars=vert:│,fold:\ ,diff:-
set hidden
set hlsearch
set ignorecase
set incsearch
set lazyredraw
set listchars=eol:$,tab:>\ ,extends:>,precedes:<,nbsp:+,trail:_
set matchtime=1
set noerrorbells
set path+=**
set ruler
set scrolloff=0
set shiftwidth=4
set showbreak==>\
set showcmd
set showmatch
set sidescroll=1
set sidescrolloff=1
set smartcase
set softtabstop=4
set splitbelow
set wildmenu
set winminheight=1
set winminwidth=1
set updatetime=100
set mouse=a
set termguicolors
if has('nvim')
    set inccommand=nosplit
endif

" Ignore files when searching
set wildignore+=*.pyc,*.egg-info/,*__pycache__/

" Disable netrw, dirvish is way nicer
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1

let g:loaded_python_provider = v:false
let g:loaded_ruby_provider = v:false
let g:loaded_node_provider = v:false

call plug#begin()
    Plug 'austinthresher/vim-lyra'
    Plug 'austinthresher/vim-flip'
    Plug 'google/vim-searchindex'
    Plug 'tpope/vim-unimpaired'
    Plug 'tpope/vim-eunuch'
    Plug 'jonhiggs/vim-readline'
    Plug 'ekalinin/dockerfile.vim'
    Plug 'lbrayner/vim-rzip'
    Plug 'justinmk/vim-dirvish'
    Plug 'vim-scripts/cmdalias.vim'
    Plug 'ludovicchabant/vim-gutentags'
call plug#end()


" Use tab and shift-tab to indent lines
nnoremap <tab> >>
nnoremap <s-tab> <<
xnoremap <tab> >
xnoremap <s-tab> <

" Delete buffer while keeping window open
nmap <leader>bd :set nobuflisted\|bp\|bd #<cr>

" Clear search with <C-l>
nnoremap <c-l> :noh<cr><c-l>
" * Sets word under cursor to search term but doesn't go to the next match
nnoremap * *N

nnoremap <leader>R :source $MYVIMRC<cr>

" Navigate out of terminal mode more easily
tnoremap <esc><esc> <c-\><c-n>
if !has('nvim')
    set termwinkey=<ins>
endif

" Terminal colorscheme (Gruvbox Dark)
let s:term_fg        = '#ebdbb2'
let s:term_bg        = '#1d2021'
let s:term_black     = '#282828'
let s:term_red       = '#cc241d'
let s:term_green     = '#98971a'
let s:term_yellow    = '#d79921'
let s:term_blue      = '#458588'
let s:term_purple    = '#b16286'
let s:term_cyan      = '#689d6a'
let s:term_white     = '#a89984'
let s:term_br_black  = '#928374'
let s:term_br_red    = '#fb4934'
let s:term_br_green  = '#b8bb26'
let s:term_br_yellow = '#fabd2f'
let s:term_br_blue   = '#83a598'
let s:term_br_purple = '#d3869b'
let s:term_br_cyan   = '#8ec07c'
let s:term_br_white  = '#fbf1c7'

if has('nvim')
    let g:terminal_color_0 = s:term_black
    let g:terminal_color_1 = s:term_red
    let g:terminal_color_2 = s:term_green
    let g:terminal_color_3 = s:term_yellow
    let g:terminal_color_4 = s:term_blue
    let g:terminal_color_5 = s:term_purple
    let g:terminal_color_6 = s:term_cyan
    let g:terminal_color_7 = s:term_white
    let g:terminal_color_8 = s:term_br_black
    let g:terminal_color_9 = s:term_br_red
    let g:terminal_color_10 = s:term_br_green
    let g:terminal_color_11 = s:term_br_yellow
    let g:terminal_color_12 = s:term_br_blue
    let g:terminal_color_13 = s:term_br_purple
    let g:terminal_color_14 = s:term_br_cyan
    let g:terminal_color_15 = s:term_br_white
elseif has('terminal')
    let g:terminal_ansi_colors = [
            \ s:term_black,
            \ s:term_red,
            \ s:term_green,
            \ s:term_yellow,
            \ s:term_blue,
            \ s:term_purple,
            \ s:term_cyan,
            \ s:term_white,
            \ s:term_br_black,
            \ s:term_br_red,
            \ s:term_br_green,
            \ s:term_br_yellow,
            \ s:term_br_blue,
            \ s:term_br_purple,
            \ s:term_br_cyan,
            \ s:term_br_white
        \ ]
endif

if has('nvim')
    function! SaneTerm(args)
        " Start terminals in a new split instead of taking over the window
        exec 'new | startinsert | terminal '.a:args
        " Automatically close interactive terminals but not one-off commands
        let b:autoclose = (len(trim(a:args)) == 0)
    endfunc
    command! -nargs=* -complete=file Terminal call SaneTerm('<args>')
    function! RemapTerminal()
        " This is so dumb but it effectively replaces the built-in command
        if exists("*CmdAlias")
            for i in range(1, len('terminal'))
                call CmdAlias('terminal'[:i], 'Terminal')
            endfor
        endif
    endfunc
    augroup RemapTermOnStartup
        autocmd!
        autocmd VimEnter * call RemapTerminal()
    augroup END
endif

augroup TerminalAuto
    autocmd!
    " Terminal FG / BG are set separately from colors 0-15
    autocmd ColorScheme *
                \ exec 'hi Terminal guifg='.s:term_fg.' guibg='.s:term_bg
    " Automatically enter insert mode when selecting terminal window
    autocmd BufEnter *
                \ if &buftype ==# 'terminal' |
                \ exec 'norm i' | exec 'redraw!' |
                \ endif
    if has('nvim')
        autocmd TermOpen *
                    \ setlocal 
                    \ winhl=Normal:Terminal
                    \ statusline=%{b:term_title}
                    \ nobuflisted 
        " Autoclose buffer if we set the flag above
        autocmd TermClose * 
                    \ try | if b:autoclose |
                    \ sil exec 'bdelete! '.expand('<abuf>') |
                    \ endif | catch | endtry
    else
        " Unlist terminals so we don't hit them with bprev / bnext
        autocmd TerminalOpen * set nobuflisted
    endif
augroup END


" Show and jump to quickfix, close quickfix when in the list
function! ToggleQuickfix()
    if &buftype ==# 'quickfix'
        wincmd p
        exec 'cclose'
    else
        exec 'copen 5'
        silent! exec '/\<error\>'
    endif
endfunction
nnoremap <silent> Q :call ToggleQuickfix()<cr>

augroup yml_indent
    autocmd!
    autocmd BufRead,BufNewFile *.yml,*.yaml setlocal shiftwidth=2
augroup END

" Snap view to left if line length is <= win width
function! ViewSnap()
    let l:view = winsaveview()
    let l:left = l:view['leftcol']
    let l:col = l:view['col']
    let l:linelen = strwidth(getline('.'))
    let l:winlen = winwidth(0)
    if l:left > 0 && l:linelen < l:winlen
        let l:view['leftcol'] = 0
        call winrestview(l:view)
    endif
endfunction
augroup Snap
    autocmd!
    autocmd CursorMoved,CursorMovedI * call ViewSnap()
augroup END

" Find and highlight trailing whitespace, based on:
" https://vim.fandom.com/wiki/Remove_unwanted_spaces
function! ShowSpaces(...)
    let @/='\v(\s+$)|( +\ze\t)'
    let oldhlsearch=&hlsearch
    if !a:0
        let &hlsearch=!&hlsearch
    else
        let &hlsearch=a:1
    endif
    return oldhlsearch
endfunction

function! TrimSpaces() range
    let oldhlsearch = ShowSpaces(1)
    execute a:firstline.",".a:lastline."substitute ///gec"
    let &hlsearch = oldhlsearch
endfunction

command! -bar -nargs=? ShowSpaces call ShowSpaces(<args>)
command! -bar -nargs=0 -range=% TrimSpaces <line1>,<line2>call TrimSpaces()

command! -nargs=1 F :execute 'vimgrep /<args>/j **' | copen | wincmd J

nnoremap <leader>s :ShowSpaces 1<cr>
nnoremap <leader>S m`:TrimSpaces<cr>``
vnoremap <leader>S :TrimSpaces<CR>

nnoremap <leader>! :!!<cr>

" Install plugins if this looks like a fresh setup
if has('nvim')
    let s:checkfile = expand("~/.config/nvim/updated")
else
    let s:checkfile = expand("~/.vim_updated")
endif

if ! filereadable(s:checkfile)
    execute 'PlugInstall | PlugUpdate | PlugClean! | q | !touch ' . s:checkfile
endif

syntax on
try
    let g:lyra_use_system_colors = v:false
    let g:lyra_transparent = v:false
    let g:lyra_no_highlighting = v:false
    let g:lyra_dim_inactive = v:false
    colorscheme lyra
catch
    colorscheme darkblue
endtry
