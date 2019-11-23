let colors_name = "luna"

if &background == "dark"
	highlight Normal           ctermfg=none  ctermbg=none  cterm=none
	highlight String           ctermfg=7     ctermbg=0     cterm=italic
	highlight Comment          ctermfg=2     ctermbg=none  cterm=italic
	highlight Todo             ctermfg=10    ctermbg=none  cterm=bold
	highlight VertSplit        ctermfg=0     ctermbg=none  cterm=none
	highlight TabLineFill      ctermfg=none  ctermbg=none  cterm=none
	highlight TabLineSel       ctermfg=none  ctermbg=none  cterm=bold
	highlight TabLine          ctermfg=8     ctermbg=none  cterm=none
	highlight StatusLine       ctermfg=0     ctermbg=7     cterm=none
	highlight StatusLineTerm   ctermfg=0     ctermbg=7     cterm=none
	highlight StatusLineNC     ctermfg=7     ctermbg=8     cterm=italic
	highlight StatusLineTermNC ctermfg=7     ctermbg=8     cterm=italic
	highlight MatchParen       ctermfg=4     ctermbg=none  cterm=underline
        highlight Folded           ctermfg=0     ctermbg=none  cterm=none
        highlight FoldColumn       ctermfg=0     ctermbg=none  cterm=none
	highlight CursorColumn     ctermfg=15    ctermbg=8     cterm=none
	highlight SignColumn       ctermfg=5     ctermbg=none  cterm=none
	highlight NonText          ctermfg=8     ctermbg=none  cterm=none
	highlight LineNr           ctermfg=12    ctermbg=none  cterm=italic
else
	highlight Normal           ctermfg=none  ctermbg=none  cterm=none
	highlight String           ctermfg=0     ctermbg=7     cterm=italic
	highlight Comment          ctermfg=2     ctermbg=none  cterm=italic
	highlight Todo             ctermfg=10    ctermbg=none  cterm=bold
	highlight VertSplit        ctermfg=15    ctermbg=15    cterm=none
	highlight TabLineFill      ctermfg=none  ctermbg=none  cterm=underline
	highlight TabLineSel       ctermfg=0     ctermbg=none  cterm=none
	highlight TabLine          ctermfg=8    ctermbg=none  cterm=none
	highlight StatusLine       ctermfg=15    ctermbg=8     cterm=none
	highlight StatusLineTerm   ctermfg=15    ctermbg=8     cterm=underline
	highlight StatusLineNC     ctermfg=8     ctermbg=7     cterm=italic
	highlight StatusLineTermNC ctermfg=8     ctermbg=7     cterm=italic
	highlight MatchParen       ctermfg=12    ctermbg=none  cterm=underline
        highlight Folded           ctermfg=7     ctermbg=none  cterm=none
        highlight FoldColumn       ctermfg=7     ctermbg=none  cterm=none
	highlight CursorColumn     ctermfg=0     ctermbg=7     cterm=none
	highlight SignColumn       ctermfg=13    ctermbg=none  cterm=none
	highlight NonText          ctermfg=7     ctermbg=none  cterm=none
	highlight LineNr           ctermfg=4     ctermbg=none  cterm=italic
endif

highlight Visual       ctermfg=none  ctermbg=none  cterm=reverse
highlight Search       ctermfg=0     ctermbg=5     cterm=none
highlight IncSearch    ctermfg=0     ctermbg=5     cterm=none
highlight DiffAdd      ctermfg=15    ctermbg=10    cterm=none
highlight DiffChange   ctermfg=0     ctermbg=3     cterm=none
highlight DiffDelete   ctermfg=15    ctermbg=9     cterm=none
highlight DiffText     ctermfg=0     ctermbg=13    cterm=none
highlight Pmenu        ctermfg=0     ctermbg=12    cterm=none
highlight PmenuSel     ctermfg=0     ctermbg=4     cterm=underline
highlight PmenuThumb   ctermfg=6     ctermbg=0     cterm=none
highlight PmenuSbar    ctermfg=0     ctermbg=3     cterm=none
highlight ColorColumn  ctermfg=9     ctermbg=none  cterm=none
highlight ToolbarLine  ctermfg=7     ctermbg=8     cterm=none
highlight ErrorMsg     ctermfg=15    ctermbg=9     cterm=none

highlight link cFormat String
highlight link SpecialChar String
