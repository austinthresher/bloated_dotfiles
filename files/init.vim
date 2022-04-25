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

" TODO: System clipboard configuration

" Disable netrw, dirvish is way nicer
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1

let g:loaded_python_provider = v:false
let g:loaded_ruby_provider = v:false
let g:loaded_node_provider = v:false

" Plugins
" =======

    call plug#begin()
    Plug 'austinthresher/vim-lyra'
    Plug 'austinthresher/vim-flip'
    Plug 'google/vim-searchindex'
    Plug 'tpope/vim-unimpaired'
    Plug 'tpope/vim-eunuch'
    Plug 'jonhiggs/vim-readline'
    Plug 'farmergreg/vim-lastplace'
    Plug 'ekalinin/dockerfile.vim'
    Plug 'lbrayner/vim-rzip'
    Plug 'justinmk/vim-dirvish'
    call plug#end()

" /Plugins

syntax on
try
    let g:lyra_use_system_colors = v:false
    let g:lyra_transparent = v:false
    let g:lyra_no_highlighting = v:false
    let g:lyra_dim_inactive = v:true
    colorscheme lyra
catch
endtry

" Use tab and shift-tab to indent lines
nnoremap <tab> >>
nnoremap <s-tab> <<
xnoremap <tab> >
xnoremap <s-tab> <

" Delete buffer while keeping window open
nmap <leader>bd :bp\|bd #<cr>

" Clear search with <C-l>
nnoremap <c-l> :noh<cr><c-l>
" * Sets word under cursor to search term but doesn't go to the next match
nnoremap * *N

nnoremap <leader>R :source $MYVIMRC<cr>

" Navigate out of terminal mode more easily
tnoremap <esc><esc> <c-\><c-n>
set termwinkey=<ins>
"TODO: Decide if these should stay for nvim
"tnoremap <c-w>H <c-\><c-n><c-w>H
"tnoremap <c-w>J <c-\><c-n><c-w>J
"tnoremap <c-w>K <c-\><c-n><c-w>K
"tnoremap <c-w>L <c-\><c-n><c-w>L
"tnoremap <c-w>h <c-\><c-n><c-w>h
"tnoremap <c-w>j <c-\><c-n><c-w>j
"tnoremap <c-w>k <c-\><c-n><c-w>k
"tnoremap <c-w>l <c-\><c-n><c-w>l
"tnoremap <c-w>p <c-\><c-n><c-w>p

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

function! NVimTermOpen()
    if has('nvim')
        setlocal winhl=Normal:Terminal
        setlocal statusline=%{b:term_title}
        set nobuflisted
    endif
endfunc

" Automatically enter insert mode when selecting terminal window
augroup Terminal
    autocmd!
    autocmd ColorScheme * exec 'hi Terminal guifg='.s:term_fg.' guibg='.s:term_bg
    autocmd BufEnter * if &buftype ==# 'terminal' | exec 'norm i' | endif
    if has('nvim')
        autocmd TermOpen * call NVimTermOpen()
    else
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

augroup filter_syntax
    autocmd!
    autocmd BufRead,BufNewFile *.filter setfiletype filter
augroup END

augroup yml_indent
    autocmd!
    autocmd BufRead,BufNewFile *.yml,*.yaml setlocal shiftwidth=2
augroup END

" Custom functions
" ================

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

" Repeatedly join lines until doing so would pass the 80 column limit
function! JoinTo80()
    let l:limit = 80 "FIXME: don't hardcode this
    " If the line is already too long, don't do
    " anything, otherwise start our Join loop
    while strwidth(getline('.')) < l:limit
        " We can't join past the last line of the buffer
        if line('.') == line('$')
            return
        endif
        let l:lineno = line('.')
        " Save state of this line and the next
        let l:current_line = getline(l:lineno)
        let l:next_line = getline(l:lineno+1)
        " Do the join instead of calculating length manually
        " because some filetypes will modify the line during
        " the join (remove comment characters, whitespace, etc)
        normal! J
        if strwidth(getline(l:lineno)) >= l:limit
            " We're too long, revert our change
            call setline(l:lineno, l:current_line)
            if strwidth(l:next_line) > 0
                call append(l:lineno, l:next_line)
            endif
            return
        endif
    endwhile
endfunction

nnoremap <silent> <leader>j :call JoinTo80()<cr>

function! GetOuterParenContents(string)
    let l:left = stridx(a:string, '(') + 1
    if l:left <= 0 | return '' | endif
    let l:right = strridx(a:string, ')')
    if l:right < l:left | return '' | endif
    let l:contents = strpart(a:string, l:left, l:right - l:left)
    return l:contents
endfunction

function! SplitOuterParens()
    let l:curline = getline('.')
    let l:args = GetOuterParenContents(l:curline)
    if empty(l:args) | return v:false | endif
    let l:split_at_left = match(l:curline, l:args)
    let l:split_at_right = l:split_at_left + len(l:args)
    let l:failed = setline('.', l:curline[:l:split_at_left-1])
    if l:failed | return v:false | endif
    let l:failed = append('.', [ l:args, l:curline[l:split_at_right:] ])
    if l:failed | return v:false | endif
    return v:true
endfunction

function! ReIndent(line, indentation)
    return repeat(' ', a:indentation) . trim(a:line)
endfunction

function! SplitSingleLineArgs(indentation)
    let inner_indent = a:indentation + &softtabstop*2
    let curline = getline('.')
    let arglist = split(l:curline, ',')
    call setline('.', ReIndent(arglist[0], inner_indent) . ',')
    for line in arglist[1:]
        call append('.', ReIndent(line, inner_indent) . ',')
        norm! j
    endfor
    " Remove last comma and move to end of the added lines
    norm! $xj$
endfunction

" Split a single-line Python-style function definition into multiple lines
" FIXME: This breaks with nested calls
function! SplitPyFunc()
    let indentation = indent('.')
    if SplitOuterParens()
        norm! j
        call SplitSingleLineArgs(indentation)
        call setline('.', ReIndent(getline('.'), indentation + &softtabstop))
    endif
endfunction

nnoremap <silent> <leader>p :call SplitPyFunc()<cr>

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
