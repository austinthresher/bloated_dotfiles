" Lyra Colorscheme
" Maintainer: Austin Thresher
" License: MIT

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
            let s:pal = [
                \ 234, 197, 112, 221,  75, 127,  84, 252,
                \ 241, 203, 118, 227, 147, 165, 122, 255]
        else
            let s:pal = [
                \ 233,  52,  22, 208,  32, 199,  49, 252,
                \  59, 196,  41, 220,  45, 170, 159, 231]
        endif
        let s:grays = [ 232, 235, 237, 239, 243, 245, 247 ] 
    endif
else
    finish
endif

" Map palette to names

" 16 ANSI colors
let s:xterm_black          = s:pal[0]
let s:xterm_red            = s:pal[1]
let s:xterm_green          = s:pal[2]
let s:xterm_yellow         = s:pal[3]
let s:xterm_blue           = s:pal[4]
let s:xterm_magenta        = s:pal[5]
let s:xterm_cyan           = s:pal[6]
let s:xterm_white          = s:pal[7]
let s:xterm_bright_black   = s:pal[8]
let s:xterm_bright_red     = s:pal[9]
let s:xterm_bright_green   = s:pal[10]
let s:xterm_bright_yellow  = s:pal[11]
let s:xterm_bright_blue    = s:pal[12]
let s:xterm_bright_magenta = s:pal[13]
let s:xterm_bright_cyan    = s:pal[14]
let s:xterm_bright_white   = s:pal[15]
" Darker than black
let s:xterm_dark_black     = s:grays[0]
" Darker than bright_black, lighter than black
let s:xterm_darkest_gray   = s:grays[1]
let s:xterm_darker_gray    = s:grays[2]
let s:xterm_dark_gray      = s:grays[3]
" Lighter than bright_black, darker than white
let s:xterm_light_gray     = s:grays[4]
let s:xterm_lighter_gray   = s:grays[5]
let s:xterm_lightest_gray  = s:grays[6]

" Associate truecolor values with color names
if has('nvim') " neovim theme
    let s:black          = ['#1C1B19', s:xterm_black]
    let s:red            = ['#EF2F27', s:xterm_red]
    let s:green          = ['#519F50', s:xterm_green]
    let s:yellow         = ['#FBB829', s:xterm_yellow]
    let s:blue           = ['#2C78BF', s:xterm_blue]
    let s:magenta        = ['#E02C6D', s:xterm_magenta]
    let s:cyan           = ['#0AAEB3', s:xterm_cyan]
    let s:white          = ['#D0BFA1', s:xterm_white]
    let s:bright_black   = ['#918175', s:xterm_bright_black]
    let s:bright_red     = ['#F75341', s:xterm_bright_red]
    let s:bright_green   = ['#98BC37', s:xterm_bright_green]
    let s:bright_yellow  = ['#FED06E', s:xterm_bright_yellow]
    let s:bright_blue    = ['#68A8E4', s:xterm_bright_blue]
    let s:bright_magenta = ['#FF5C8F', s:xterm_bright_magenta]
    let s:bright_cyan    = ['#53FDE9', s:xterm_bright_cyan]
    let s:bright_white   = ['#FCE8C3', s:xterm_bright_white]
    let s:dark_black     = ['#121212', s:xterm_dark_black]
    let s:darkest_gray   = ['#262626', s:xterm_darkest_gray]
    let s:darker_gray    = ['#303030', s:xterm_darker_gray]
    let s:dark_gray      = ['#3A3A3A', s:xterm_dark_gray]
    let s:light_gray     = ['#444444', s:xterm_light_gray]
    let s:lighter_gray   = ['#4E4E4E', s:xterm_lighter_gray]
    let s:lightest_gray  = ['#585858', s:xterm_lightest_gray]
else " vim theme
    let s:black          = ['#121212', s:xterm_black]
    let s:red            = ['#5F0000', s:xterm_red]
    let s:green          = ['#005F00', s:xterm_green]
    let s:yellow         = ['#FF8700', s:xterm_yellow]
    let s:blue           = ['#0087DF', s:xterm_blue]
    let s:magenta        = ['#FF00AF', s:xterm_magenta]
    let s:cyan           = ['#00FFAF', s:xterm_cyan]
    let s:white          = ['#D0D0D0', s:xterm_white]
    let s:bright_black   = ['#5F5F5F', s:xterm_bright_black]
    let s:bright_red     = ['#FF0000', s:xterm_bright_red]
    let s:bright_green   = ['#00DF5F', s:xterm_bright_green]
    let s:bright_yellow  = ['#FFDF00', s:xterm_bright_yellow]
    let s:bright_blue    = ['#00DFFF', s:xterm_bright_blue]
    let s:bright_magenta = ['#DF5FDF', s:xterm_bright_magenta]
    let s:bright_cyan    = ['#AFFFFF', s:xterm_bright_cyan]
    let s:bright_white   = ['#FFFFFF', s:xterm_bright_white]
    let s:dark_black     = ['#080808', s:xterm_dark_black]
    let s:darkest_gray   = ['#1C1C1C', s:xterm_darkest_gray]
    let s:darker_gray    = ['#262626', s:xterm_darker_gray]
    let s:dark_gray      = ['#3A3A3A', s:xterm_dark_gray]
    let s:light_gray     = ['#808080', s:xterm_light_gray]
    let s:lighter_gray   = ['#9E9E9E', s:xterm_lighter_gray]
    let s:lightest_gray  = ['#BCBCBC', s:xterm_lightest_gray]
endif

let s:none = ['NONE', 'NONE']

" Highlights
call s:hi('Normal', s:bright_white, s:black, 'NONE')

for group in ['Visual', 'VisualNOS', 'Search', 'IncSearch']
    call s:hi(group, s:none, s:none, 'inverse')
endfor

for group in ['NonText', 'SpecialKey']
    call s:hi(group, s:light_gray, s:none, 'NONE')
endfor

call s:hi('Operator', s:white, s:none, 'NONE')
call s:hi('MatchParen', s:bright_magenta, s:none, 'bold')
call s:hi('Conceal', s:darker_gray, s:none, 'NONE')
call s:hi('StatusLine', s:bright_white, s:darkest_gray, 'NONE')
call s:hi('VertSplit', s:bright_white, s:none, 'NONE')
call s:hi('WildMenu', s:blue, s:black, 'bold')
call s:hi('ErrorMsg', s:bright_white, s:red, 'NONE')
call s:hi('Directory', s:green, s:none, 'bold')
call s:hi('Title', s:green, s:none, 'bold')
call s:hi('MoreMsg', s:yellow, s:none, 'bold')
call s:hi('Question', s:bright_yellow, s:none, 'bold')
call s:hi('Warning', s:red, s:none, 'bold')

call s:hi('Cursor', s:black, s:yellow, 'NONE')
hi! link vCursor Cursor
hi! link iCursor Cursor
hi! link lCursor Cursor

call s:hi('Special', s:yellow, s:none, 'NONE')
call s:hi('Comment', s:bright_green, s:none, 'italic')
call s:hi('Todo', s:bright_yellow, s:black, 'bold')
call s:hi('Error', s:bright_red, s:none, 'italic')
call s:hi('String', s:cyan, s:dark_black, 'NONE')
call s:hi('SpecialChar', s:bright_yellow, s:dark_black, 'italic')

for group in ['Constant', 'Character', 'Boolean', 'Number', 'Float']
    call s:hi(group, s:bright_red, s:none, 'NONE')
endfor

call s:hi('Type', s:bright_blue, s:none, 'NONE')
call s:hi('StorageClass', s:bright_blue, s:none, 'NONE')
call s:hi('Typedef', s:bright_blue, s:none, 'NONE')
call s:hi('Structure', s:bright_blue, s:none, 'NONE')
call s:hi('Delimiter', s:bright_black, s:none, 'NONE')
for group in ['Statement', 'Conditional', 'Repeat', 'Label',
            \ 'Exception', 'Keyword']
    call s:hi(group, s:blue, s:none, 'bold')
endfor
call s:hi('Identifier', s:bright_white, s:none, 'NONE')
call s:hi('PreProc',   s:yellow, s:none, 'NONE')
call s:hi('Include',   s:yellow, s:none, 'NONE')
call s:hi('Define',    s:yellow, s:none, 'NONE')
call s:hi('PreCondit', s:yellow, s:none, 'NONE')

call s:hi('cIncluded', s:bright_cyan, s:none, 'italic')

call s:hi('Function', s:magenta, s:none, 'NONE')
call s:hi('Macro', s:bright_red, s:none, 'NONE')

call s:hi('Folded', s:none, s:none, 'italic')
call s:hi('LineNr', s:white, s:darkest_gray, 'NONE')
call s:hi('CursorLineNr', s:darkest_gray, s:bright_black, 'NONE')
call s:hi('StatusLineNC', s:dark_gray, s:darkest_gray, 'NONE')

call s:hi('Pmenu', s:bright_white, s:darker_gray, 'NONE')
call s:hi('PmenuSel', s:bright_white, s:magenta, 'bold')

call s:hi('DiffDelete', s:none, s:red, 'none')
call s:hi('DiffAdd', s:none, s:green, 'none')
call s:hi('DiffChange', s:none, s:cyan, 'none')
call s:hi('DiffText', s:none, s:bright_yellow, 'none')

if has('spell')
    call s:hi('SpellCap', s:none, s:magenta, 'underline')
    call s:hi('SpellBad', s:none, s:red, 'underline')
    call s:hi('SpellLocal', s:none, s:yellow, 'underline')
    call s:hi('SpellRare', s:none, s:cyan, 'underline')
endif
if has('terminal')
    call s:hi('Terminal', s:bright_white, s:dark_black, 'NONE')
endif

" statuslime colors
call s:hi('LimeNormal',       s:dark_black,    s:white,   'bold')
call s:hi('LimeVisual',       s:dark_black,    s:blue,    'bold')
call s:hi('LimeInsert',       s:dark_black,    s:bright_yellow, 'bold')
call s:hi('LimeReplace',      s:dark_black,    s:yellow,  'bold')
call s:hi('LimeTerminal',     s:dark_black,    s:green,   'bold')
call s:hi('LimeCommand',      s:dark_black,    s:magenta, 'bold')
call s:hi('LimeShell',        s:dark_black,    s:cyan,    'bold')
call s:hi('LimeOther',        s:dark_black,    s:red,     'bold')
call s:hi('LimeFile',         s:bright_white,  s:dark_gray,  'NONE')
call s:hi('LimeError',        s:bright_red,    s:darkest_gray, 'bold')
call s:hi('LimeRuler',        s:bright_white,  s:darker_gray,  'NONE')
call s:hi('LimeInactiveBar',  s:dark_black,    s:darker_gray,  'NONE')
call s:hi('LimeInactiveMode', s:dark_black,    s:dark_gray,  'NONE')
call s:hi('LimeLeft',         s:yellow, s:darkest_gray,   'NONE')
call s:hi('LimeRight',        s:bright_yellow, s:darkest_gray, 'NONE')

" buftabline colors
call s:hi('BufTabLineCurrent', s:dark_black,   s:white,        'bold')
call s:hi('BufTabLineActive',  s:red,          s:white,        'NONE')
call s:hi('BufTabLineHidden',  s:lighter_gray, s:white,        'NONE')
call s:hi('BufTabLineFill',    s:black,        s:bright_black, 'NONE')

" vim-lsp colors
call s:hi('LspErrorHighlight',       s:red,    s:none, 'underline')
call s:hi('LspWarningHighlight',     s:yellow, s:none, 'underline')
call s:hi('LspInformationHighlight', s:blue,   s:none, 'underline')
call s:hi('LspHintHighlight',        s:green,  s:none, 'underline')

" conflict-marker.vim
call s:hi('ConflictMarkerBegin',     s:bright_cyan, s:none, 'bold')
call s:hi('ConflictMarkerOurs',      s:none, s:darkest_gray, 'NONE')
call s:hi('ConflictMarkerSeparator', s:cyan, s:none, 'bold')
call s:hi('ConflictMarkerTheirs',    s:none, s:dark_black, 'NONE')
call s:hi('ConflictMarkerEnd',       s:bright_cyan, s:none, 'bold')
