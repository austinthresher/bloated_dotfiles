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

" TODO: System clipboard configuration

let g:loaded_python_provider = v:false
let g:loaded_ruby_provider = v:false
let g:loaded_node_provider = v:false

let g:gitgutter_set_sign_backgrounds = v:false
let g:gitgutter_sign_added = '++'
let g:gitgutter_sign_modified = '~~'
let g:gitgutter_sign_removed = '--'
let g:gitgutter_sign_modified_removed = '**'
let g:gitgutter_sign_removed_first_line = '^^'
let g:gitgutter_sign_removed_above_and_below = '%%'

let g:airline_theme = 'simple'

let g:ale_enabled = v:false
let g:ale_sign_error = 'E:'
let g:ale_sign_warning = 'W:'
let g:ale_open_list = v:true
let g:ale_list_window_size = 5
let g:ale_virtualenv_dir_names = []
let g:airline#extensions#ale#enabled = v:true

let test#strategy = 'vimux'

let g:jedi#popup_on_dot = v:false

" Plugins
" =======

    call plug#begin()
    Plug 'austinthresher/vim-lyra'
    Plug 'austinthresher/vim-flip'
    Plug 'google/vim-searchindex'
    Plug 'tpope/vim-unimpaired'
    Plug 'jonhiggs/vim-readline'
    Plug 'yggdroot/indentline'
    Plug 'farmergreg/vim-lastplace'
    Plug 'airblade/vim-gitgutter'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'rhysd/conflict-marker.vim'
    Plug 'dense-analysis/ale'
    Plug 'vim-test/vim-test'
    Plug 'benmills/vimux'
    Plug 'tpope/vim-dispatch'
    Plug 'ekalinin/dockerfile.vim'
    Plug 'davidhalter/jedi-vim'
    Plug 'ervandew/supertab'
    call plug#end()

" /Plugins

try
    let g:lyra_use_system_colors = v:false
    let g:lyra_transparent = v:false
    let g:lyra_no_highlighting = v:false
    colorscheme lyra
    syntax on
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
" List buffers with <leader>b
nmap <leader>b :ls<cr>:b

nnoremap <leader>V :source ~/.config/nvim/init.vim<cr>

" Navigate out of terminal mode more easily
tnoremap <esc> <c-\><c-n>
tnoremap <c-w>H <c-\><c-n><c-w>H
tnoremap <c-w>J <c-\><c-n><c-w>J
tnoremap <c-w>K <c-\><c-n><c-w>K
tnoremap <c-w>L <c-\><c-n><c-w>L
tnoremap <c-w>h <c-\><c-n><c-w>h
tnoremap <c-w>j <c-\><c-n><c-w>j
tnoremap <c-w>k <c-\><c-n><c-w>k
tnoremap <c-w>l <c-\><c-n><c-w>l
tnoremap <c-w>p <c-\><c-n><c-w>p

" Automatically enter insert mode when selecting terminal window
augroup Terminal
    autocmd!
    if has('nvim')
        autocmd TermOpen * startinsert
    else
        autocmd BufEnter * silent! if &buftype ==# 'terminal' | exec 'norm i' | endif
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

" insert before current word
nnoremap <leader>i bi

" append after current word
nnoremap <leader>a ea

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

nnoremap <leader>s :ShowSpaces 1<cr>
nnoremap <leader>S m`:TrimSpaces<cr>``
vnoremap <leader>S :TrimSpaces<CR>

nnoremap <leader>gt :GitGutterToggle<cr>

nnoremap <leader>t :TestNearest<cr>
nnoremap <leader>T :TestFile<cr>

function! GitRoot()
    let root = system("git rev-parse --show-toplevel 2>&1 | tr -d '\\n'")
    if root =~ 'fatal: not a git repository'
        return v:false
    endif
    return root
endfunction

function! ConfigureNotesWindow()
    resize 5
    setlocal winfixheight
endfunction

function! ShowProjectNotes()
    let root = GitRoot()
    if root == v:false
        echo "Could not find git root, aborting."
        return
    endif
    " TODO: if notes window already exists, jump to it
    exec 'bot sp ' . root . '/.notes'
    call ConfigureNotesWindow()
endfunction

nnoremap <leader>N :call ShowProjectNotes()<cr>


" Install plugins if this looks like a fresh setup
let s:checkfile = expand("~/.config/nvim/updated")
if ! filereadable(s:checkfile)
    execute 'PlugInstall | PlugUpdate | PlugClean! | q | !touch ' . s:checkfile
endif
