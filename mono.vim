" Based on template from
" https://github.com/ggalindezb/vim_colorscheme_template

set background=dark

highlight clear
if exists("syntax_on")
	syntax reset
endif
let g:colors_name="mono"

" --------------------------------
" Editor settings
" --------------------------------
hi Normal		ctermfg=NONE	ctermbg=NONE	cterm=none
hi Cursor		ctermfg=none	ctermbg=none	cterm=none
hi CursorLine		ctermfg=none	ctermbg=none	cterm=none
hi LineNr		ctermfg=236	ctermbg=16	cterm=none
hi CursorLineNR		ctermfg=none	ctermbg=none	cterm=none

" -----------------
" - Number column -
" -----------------
hi CursorColumn		ctermfg=none	ctermbg=none	cterm=none
hi FoldColumn		ctermfg=none	ctermbg=none	cterm=none
hi SignColumn		ctermfg=none	ctermbg=none	cterm=none
hi Folded		ctermfg=none	ctermbg=none	cterm=none

" -------------------------
" - Window/Tab delimiters - 
" -------------------------
hi VertSplit		ctermfg=239	ctermbg=none	cterm=none
hi ColorColumn		ctermfg=none	ctermbg=none	cterm=none
hi TabLine		ctermfg=245	ctermbg=235	cterm=none
hi TabLineFill		ctermfg=245	ctermbg=235	cterm=none
hi TabLineSel		ctermfg=255	ctermbg=none	cterm=bold

" -------------------------------
" - File Navigation / Searching -
" -------------------------------
hi Directory		ctermfg=none	ctermbg=none	cterm=bold
hi Search		ctermfg=151	ctermbg=16	cterm=none
hi IncSearch		ctermfg=16	ctermbg=180	cterm=none

" -----------------
" - Prompt/Status -
" -----------------
hi StatusLine		ctermfg=138	ctermbg=none	cterm=underline,italic
hi StatusLineNC		ctermfg=238	ctermbg=none	cterm=underline,italic
hi WildMenu		ctermfg=151	ctermbg=240	cterm=none
hi Question		ctermfg=151	ctermbg=none	cterm=none
hi Title		ctermfg=151	ctermbg=none	cterm=none
hi ModeMsg		ctermfg=151	ctermbg=none	cterm=none
hi MoreMsg		ctermfg=151	ctermbg=none	cterm=none

" --------------
" - Visual aid -
" --------------
hi MatchParen		ctermfg=151	ctermbg=0	cterm=bold
hi Visual		ctermfg=0	ctermbg=151	cterm=none
hi VisualNOS		ctermfg=none	ctermbg=none	cterm=none
hi NonText		ctermfg=66	ctermbg=none	cterm=none

hi Todo			ctermfg=180	ctermbg=none	cterm=bold
hi Underlined		ctermfg=none	ctermbg=none	cterm=none
hi Error		ctermfg=none	ctermbg=none	cterm=none
hi ErrorMsg		ctermfg=none	ctermbg=none	cterm=none
hi WarningMsg		ctermfg=none	ctermbg=none	cterm=none
hi Ignore		ctermfg=none	ctermbg=none	cterm=none
hi SpecialKey		ctermfg=66	ctermbg=none	cterm=none

" --------------------------------
" Variable types
" --------------------------------
hi Constant		ctermfg=NONE	ctermbg=none	cterm=none
hi String		ctermfg=NONE	ctermbg=234	cterm=italic
hi StringDelimiter	ctermfg=NONE	ctermbg=none	cterm=none
hi Character		ctermfg=NONE	ctermbg=none	cterm=none
hi Number		ctermfg=NONE	ctermbg=none	cterm=none
hi Boolean		ctermfg=NONE	ctermbg=none	cterm=none
hi Float		ctermfg=NONE	ctermbg=none	cterm=none

hi Identifier		ctermfg=NONE	ctermbg=none	cterm=none
hi Function		ctermfg=NONE	ctermbg=none	cterm=none

" --------------------------------
" Language constructs
" --------------------------------
hi Statement		ctermfg=NONE	ctermbg=none	cterm=bold
hi Conditional		ctermfg=NONE	ctermbg=none	cterm=bold
hi Repeat		ctermfg=NONE	ctermbg=none	cterm=bold
hi Label		ctermfg=NONE	ctermbg=none	cterm=none
hi Operator		ctermfg=NONE	ctermbg=none	cterm=none
hi Keyword		ctermfg=NONE	ctermbg=none	cterm=bold
hi Exception		ctermfg=NONE	ctermbg=none	cterm=bold
hi Comment		ctermfg=66	ctermbg=none	cterm=italic

hi Special		ctermfg=NONE	ctermbg=none	cterm=none
hi SpecialChar		ctermfg=NONE	ctermbg=none	cterm=none
hi Tag			ctermfg=NONE	ctermbg=none	cterm=none
hi Delimiter		ctermfg=NONE	ctermbg=none	cterm=none
hi SpecialComment	ctermfg=NONE	ctermbg=none	cterm=none
hi Debug		ctermfg=NONE	ctermbg=none	cterm=none

" ----------
" - C like -
" ----------
hi PreProc		ctermfg=NONE	ctermbg=none	cterm=italic
hi Include		ctermfg=NONE	ctermbg=none	cterm=italic
hi Define		ctermfg=NONE	ctermbg=none	cterm=italic
hi Macro		ctermfg=NONE	ctermbg=none	cterm=italic
hi PreCondit		ctermfg=NONE	ctermbg=none	cterm=italic

hi Type			ctermfg=NONE	ctermbg=none	cterm=none
hi StorageClass		ctermfg=NONE	ctermbg=none	cterm=none
hi Structure		ctermfg=NONE	ctermbg=none	cterm=none
hi Typedef		ctermfg=NONE	ctermbg=none	cterm=none

" --------------------------------
" Diff
" --------------------------------
hi DiffAdd		ctermfg=189	ctermbg=none	cterm=none
hi DiffChange		ctermfg=180	ctermbg=none	cterm=none
hi DiffDelete		ctermfg=94	ctermbg=none	cterm=none
hi DiffText		ctermfg=none	ctermbg=none	cterm=none

" --------------------------------
" Completion menu
" --------------------------------
hi Pmenu		ctermfg=138	ctermbg=16	cterm=none
hi PmenuSel		ctermfg=16	ctermbg=151	cterm=none
hi PmenuSbar		ctermfg=138	ctermbg=none	cterm=none
hi PmenuThumb		ctermfg=16	ctermbg=138	cterm=none
