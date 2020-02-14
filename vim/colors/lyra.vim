" Copyright (c) 2020 Austin Thresher
"
" MIT License
"
" Permission is hereby granted, free of charge, to any person obtaining
" a copy of this software and associated documentation files (the
" "Software"), to deal in the Software without restriction, including
" without limitation the rights to use, copy, modify, merge, publish,
" distribute, sublicense, and/or sell copies of the Software, and to
" permit persons to whom the Software is furnished to do so, subject to
" the following conditions:
"
" The above copyright notice and this permission notice shall be
" included in all copies or substantial portions of the Software.
"
" THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
" EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
" MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
" NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
" LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
" OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
" WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

highlight clear
if exists("syntax_on")
    syntax reset
endif

let g:colors_name = 'Lyra'

" Wrapper for setting highlights
function! s:hi(group, fg, bg, attr)
    let l:cmd = [ 'hi', a:group, 'guifg='.a:fg[0], 'guibg='.a:bg[0],
                \ 'gui='.a:attr, 'ctermfg='.a:fg[1], 'ctermbg='.a:bg[1],
                \ 'cterm='.a:attr ]
    execute join(l:cmd, ' ')
endfunc

" Set palette based on t_Co
if &t_Co || &termguicolors
    if &t_Co < 16 || &t_Co is ''
        let s:pal = range(0, 7) + range(0, 7)
        let s:grays = [0, 0, 0, 0, 0, 7, 7, 7, 7]
    elseif &t_Co < 256
        let s:pal = range(0, 15)
        let s:grays = [0, 0, 0, 8, 8, 7, 7, 15, 15]
    else
        if has('nvim')
            let s:pal = [ 234, 197, 112, 221,  75, 127,  84, 252,
                        \ 241, 203, 118, 227, 147, 165, 122, 255]
        else
            let s:pal = [ 233,  52,  22, 208,  32, 199,  49, 252,
                        \  59, 196,  41, 220,  45, 170, 159, 231]
        endif
        let s:grays = [ 232, 235, 237, 239, 243, 245, 247 ]
    endif
else
    finish
endif

" Map palette to names

" 16 ANSI colors
let s:xterm_black      = s:pal[0]
let s:xterm_red        = s:pal[1]
let s:xterm_green      = s:pal[2]
let s:xterm_yellow     = s:pal[3]
let s:xterm_blue       = s:pal[4]
let s:xterm_magenta    = s:pal[5]
let s:xterm_cyan       = s:pal[6]
let s:xterm_white      = s:pal[7]
let s:xterm_br_black   = s:pal[8]
let s:xterm_br_red     = s:pal[9]
let s:xterm_br_green   = s:pal[10]
let s:xterm_br_yellow  = s:pal[11]
let s:xterm_br_blue    = s:pal[12]
let s:xterm_br_magenta = s:pal[13]
let s:xterm_br_cyan    = s:pal[14]
let s:xterm_br_white   = s:pal[15]
" Darker than black
let s:xterm_hard_black = s:grays[0]
" Darker than br_black, lighter than black
let s:xterm_darkest    = s:grays[1]
let s:xterm_darker     = s:grays[2]
let s:xterm_dark       = s:grays[3]
" Lighter than br_black, darker than white
let s:xterm_light      = s:grays[4]
let s:xterm_lighter    = s:grays[5]
let s:xterm_lightest   = s:grays[6]

" Associate truecolor values with color names
if has('nvim') " neovim theme
    let s:black      = ['#1C1B19', s:xterm_black]
    let s:red        = ['#EF2F27', s:xterm_red]
    let s:green      = ['#519F50', s:xterm_green]
    let s:yellow     = ['#FBB829', s:xterm_yellow]
    let s:blue       = ['#2C78BF', s:xterm_blue]
    let s:magenta    = ['#E02C6D', s:xterm_magenta]
    let s:cyan       = ['#0AAEB3', s:xterm_cyan]
    let s:white      = ['#D0BFA1', s:xterm_white]
    let s:br_black   = ['#918175', s:xterm_br_black]
    let s:br_red     = ['#F75341', s:xterm_br_red]
    let s:br_green   = ['#98BC37', s:xterm_br_green]
    let s:br_yellow  = ['#FED06E', s:xterm_br_yellow]
    let s:br_blue    = ['#68A8E4', s:xterm_br_blue]
    let s:br_magenta = ['#FF5C8F', s:xterm_br_magenta]
    let s:br_cyan    = ['#53FDE9', s:xterm_br_cyan]
    let s:br_white   = ['#FCE8C3', s:xterm_br_white]
    let s:hard_black = ['#121212', s:xterm_hard_black]
    let s:darkest    = ['#262626', s:xterm_darkest]
    let s:darker     = ['#303030', s:xterm_darker]
    let s:dark       = ['#3A3A3A', s:xterm_dark]
    let s:light      = ['#444444', s:xterm_light]
    let s:lighter    = ['#4E4E4E', s:xterm_lighter]
    let s:lightest   = ['#585858', s:xterm_lightest]
else " vim theme
    let s:black      = ['#121212', s:xterm_black]
    let s:red        = ['#5F0000', s:xterm_red]
    let s:green      = ['#005F00', s:xterm_green]
    let s:yellow     = ['#FF8700', s:xterm_yellow]
    let s:blue       = ['#0087DF', s:xterm_blue]
    let s:magenta    = ['#FF00AF', s:xterm_magenta]
    let s:cyan       = ['#00FFAF', s:xterm_cyan]
    let s:white      = ['#D0D0D0', s:xterm_white]
    let s:br_black   = ['#5F5F5F', s:xterm_br_black]
    let s:br_red     = ['#FF0000', s:xterm_br_red]
    let s:br_green   = ['#00DF5F', s:xterm_br_green]
    let s:br_yellow  = ['#FFDF00', s:xterm_br_yellow]
    let s:br_blue    = ['#00DFFF', s:xterm_br_blue]
    let s:br_magenta = ['#DF5FDF', s:xterm_br_magenta]
    let s:br_cyan    = ['#AFFFFF', s:xterm_br_cyan]
    let s:br_white   = ['#FFFFFF', s:xterm_br_white]
    let s:hard_black = ['#080808', s:xterm_hard_black]
    let s:darkest    = ['#1C1C1C', s:xterm_darkest]
    let s:darker     = ['#262626', s:xterm_darker]
    let s:dark       = ['#3A3A3A', s:xterm_dark]
    let s:light      = ['#808080', s:xterm_light]
    let s:lighter    = ['#9E9E9E', s:xterm_lighter]
    let s:lightest   = ['#BCBCBC', s:xterm_lightest]
endif

let s:none = ['NONE', 'NONE']

" Highlights
call s:hi('Normal', s:br_white, s:black, 'NONE')

for group in ['Visual', 'VisualNOS', 'Search', 'IncSearch']
    call s:hi(group, s:none, s:none, 'inverse')
endfor

for group in ['NonText', 'SpecialKey']
    call s:hi(group, s:light, s:none, 'NONE')
endfor

for group in ['Constant', 'Character', 'Boolean', 'Number', 'Float']
    call s:hi(group, s:br_red, s:none, 'NONE')
endfor

for group in ['Statement', 'Conditional', 'Repeat', 'Label',
            \ 'Exception', 'Keyword']
    call s:hi(group, s:blue, s:none, 'bold')
endfor

call s:hi('Cursor', s:black, s:yellow, 'NONE')
hi! link vCursor Cursor
hi! link iCursor Cursor
hi! link lCursor Cursor

call s:hi('Operator',     s:white,      s:none,       'NONE')
call s:hi('MatchParen',   s:br_magenta, s:none,       'bold')
call s:hi('Conceal',      s:darker,     s:none,       'NONE')
call s:hi('StatusLine',   s:br_white,   s:darkest,    'NONE')
call s:hi('VertSplit',    s:br_white,   s:none,       'NONE')
call s:hi('WildMenu',     s:blue,       s:black,      'bold')
call s:hi('ErrorMsg',     s:br_white,   s:red,        'NONE')
call s:hi('Directory',    s:green,      s:none,       'bold')
call s:hi('Title',        s:green,      s:none,       'bold')
call s:hi('MoreMsg',      s:yellow,     s:none,       'bold')
call s:hi('Question',     s:br_yellow,  s:none,       'bold')
call s:hi('Warning',      s:red,        s:none,       'bold')
call s:hi('Special',      s:yellow,     s:none,       'NONE')
call s:hi('Comment',      s:br_green,   s:none,       'italic')
call s:hi('Todo',         s:br_yellow,  s:black,      'bold')
call s:hi('Error',        s:br_red,     s:none,       'italic')
call s:hi('String',       s:cyan,       s:hard_black, 'NONE')
call s:hi('SpecialChar',  s:br_yellow,  s:hard_black, 'italic')
call s:hi('Type',         s:br_blue,    s:none,       'NONE')
call s:hi('StorageClass', s:br_blue,    s:none,       'NONE')
call s:hi('Typedef',      s:br_blue,    s:none,       'NONE')
call s:hi('Structure',    s:br_blue,    s:none,       'NONE')
call s:hi('Delimiter',    s:br_black,   s:none,       'NONE')
call s:hi('Identifier',   s:br_white,   s:none,       'NONE')
call s:hi('PreProc',      s:yellow,     s:none,       'NONE')
call s:hi('Include',      s:yellow,     s:none,       'NONE')
call s:hi('Define',       s:yellow,     s:none,       'NONE')
call s:hi('PreCondit',    s:yellow,     s:none,       'NONE')
call s:hi('cIncluded',    s:br_cyan,    s:none,       'italic')
call s:hi('Function',     s:magenta,    s:none,       'NONE')
call s:hi('Macro',        s:br_red,     s:none,       'NONE')
call s:hi('Folded',       s:none,       s:none,       'italic')
call s:hi('LineNr',       s:white,      s:darkest,    'NONE')
call s:hi('CursorLineNr', s:darkest,    s:br_black,   'NONE')
call s:hi('StatusLineNC', s:dark,       s:darkest,    'NONE')
call s:hi('Pmenu',        s:br_white,   s:darker,     'NONE')
call s:hi('PmenuSel',     s:br_white,   s:magenta,    'bold')
call s:hi('DiffDelete',   s:none,       s:red,        'none')
call s:hi('DiffAdd',      s:none,       s:green,      'none')
call s:hi('DiffChange',   s:none,       s:cyan,       'none')
call s:hi('DiffText',     s:none,       s:br_yellow,  'none')

if has('spell')
    call s:hi('SpellCap',   s:none, s:magenta, 'underline')
    call s:hi('SpellBad',   s:none, s:red,     'underline')
    call s:hi('SpellLocal', s:none, s:yellow,  'underline')
    call s:hi('SpellRare',  s:none, s:cyan,    'underline')
endif

if has('terminal')
    call s:hi('Terminal', s:br_white, s:hard_black, 'NONE')
endif

" statuslime colors
call s:hi('LimeNormal',       s:hard_black, s:white,     'bold')
call s:hi('LimeVisual',       s:hard_black, s:blue,      'bold')
call s:hi('LimeInsert',       s:hard_black, s:br_yellow, 'bold')
call s:hi('LimeReplace',      s:hard_black, s:yellow,    'bold')
call s:hi('LimeTerminal',     s:hard_black, s:green,     'bold')
call s:hi('LimeCommand',      s:hard_black, s:magenta,   'bold')
call s:hi('LimeShell',        s:hard_black, s:cyan,      'bold')
call s:hi('LimeOther',        s:hard_black, s:red,       'bold')
call s:hi('LimeFile',         s:br_white,   s:dark,      'NONE')
call s:hi('LimeError',        s:br_red,     s:darkest,   'bold')
call s:hi('LimeRuler',        s:br_white,   s:darker,    'NONE')
call s:hi('LimeInactiveBar',  s:hard_black, s:darker,    'NONE')
call s:hi('LimeInactiveMode', s:hard_black, s:dark,      'NONE')
call s:hi('LimeLeft',         s:yellow,     s:darkest,   'NONE')
call s:hi('LimeRight',        s:br_yellow,  s:darkest,   'NONE')

" buftabline colors
call s:hi('BufTabLineCurrent', s:hard_black, s:white,    'bold')
call s:hi('BufTabLineActive',  s:red,        s:white,    'NONE')
call s:hi('BufTabLineHidden',  s:lighter,    s:white,    'NONE')
call s:hi('BufTabLineFill',    s:black,      s:br_black, 'NONE')

" vim-lsp colors
call s:hi('LspErrorHighlight',       s:red,    s:none, 'underline')
call s:hi('LspWarningHighlight',     s:yellow, s:none, 'underline')
call s:hi('LspInformationHighlight', s:blue,   s:none, 'underline')
call s:hi('LspHintHighlight',        s:green,  s:none, 'underline')

" conflict-marker.vim
call s:hi('ConflictMarkerBegin',     s:br_cyan, s:none,       'bold')
call s:hi('ConflictMarkerOurs',      s:none,    s:darkest,    'NONE')
call s:hi('ConflictMarkerSeparator', s:cyan,    s:none,       'bold')
call s:hi('ConflictMarkerTheirs',    s:none,    s:hard_black, 'NONE')
call s:hi('ConflictMarkerEnd',       s:br_cyan, s:none,       'bold')
