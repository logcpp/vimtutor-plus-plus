" Title: Vim color file
" Author: logcpp
" Features: cterm colorscheme based on the default
" Created On: 2022/2/9
" Last Change: 2022/2/10

" using 256 cterm colors
" color codes:
" 121: lightgreen, 81: lightblue, 232-255: gray
if &t_Co < 256
	finish
endif

hi clear
set background=dark
set notermguicolors

" Load the syntax highlighting defaults, if it's enabled.
if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "cterm"

hi Normal			cterm=NONE	ctermfg=NONE		ctermbg=NONE

hi ColorColumn		cterm=NONE		ctermfg=NONE		ctermbg=darkgray
hi Comment			cterm=NONE		ctermfg=cyan		ctermbg=NONE
hi Conceal			cterm=NONE		ctermfg=NONE		ctermbg=NONE
hi Constant			cterm=NONE		ctermfg=magenta		ctermbg=NONE
hi Cursor			cterm=NONE		ctermfg=NONE		ctermbg=NONE
hi CursorColumn		cterm=NONE		ctermfg=NONE		ctermbg=235
hi CursorLine		cterm=NONE		ctermfg=NONE		ctermbg=235
hi CursorLineNr		cterm=NONE		ctermfg=123			ctermbg=233
hi DiffAdd			cterm=NONE		ctermfg=NONE		ctermbg=35
hi DiffChange		cterm=NONE		ctermfg=NONE		ctermbg=61
hi DiffDelete		cterm=NONE		ctermfg=NONE		ctermbg=167
hi DiffText			cterm=NONE		ctermfg=white		ctermbg=198
hi Directory		cterm=NONE		ctermfg=cyan		ctermbg=NONE
hi EndOfBuffer		cterm=NONE		ctermfg=darkblue	ctermbg=NONE
hi Error			cterm=standout	ctermfg=red			ctermbg=white
hi ErrorMsg			cterm=standout	ctermfg=darkred		ctermbg=white
hi FoldColumn		cterm=NONE		ctermfg=NONE		ctermbg=NONE
hi Folded			cterm=NONE		ctermfg=252			ctermbg=237
hi Identifier		cterm=bold		ctermfg=cyan			ctermbg=NONE
hi Ignore			cterm=NONE		ctermfg=black		ctermbg=NONE
hi IncSearch		cterm=reverse	ctermfg=cyan		ctermbg=black
hi LineNr			cterm=NONE		ctermfg=gray		ctermbg=NONE
hi MatchParen		cterm=NONE		ctermfg=darkcyan		ctermbg=NONE
hi ModeMsg			cterm=bold		ctermfg=lightblue	ctermbg=NONE
hi MoreMsg			cterm=NONE		ctermfg=lightgreen	ctermbg=NONE
hi NonText			cterm=NONE		ctermfg=darkblue	ctermbg=NONE
hi Pmenu			cterm=NONE		ctermfg=lightblue		ctermbg=232
hi PmenuSbar		cterm=NONE		ctermfg=NONE		ctermbg=238
hi PmenuSel			cterm=NONE		ctermfg=232		ctermbg=lightblue
hi PmenuThumb		cterm=NONE		ctermfg=NONE		ctermbg=250
hi PreProc			cterm=NONE		ctermfg=81			ctermbg=NONE
hi Question			cterm=NONE		ctermfg=lightgreen	ctermbg=NONE
hi QuickFixLine		cterm=reverse	ctermfg=yellow		ctermbg=black
hi Search			cterm=reverse	ctermfg=green		ctermbg=black
hi SignColumn		cterm=NONE		ctermfg=NONE		ctermbg=NONE
hi Special			cterm=NONE		ctermfg=219			ctermbg=NONE
hi SpecialKey		cterm=NONE		ctermfg=81			ctermbg=NONE
hi SpellBad			cterm=NONE		ctermbg=NONE		ctermbg=red
hi SpellCap			cterm=NONE		ctermbg=NONE		ctermbg=blue
hi SpellLocal		cterm=NONE		ctermbg=NONE		ctermbg=cyan
hi SpellRare		cterm=NONE		ctermbg=NONE		ctermbg=magenta
hi Statement		cterm=NONE		ctermfg=yellow		ctermbg=NONE
hi StatusLine		cterm=underline	ctermfg=lightblue	ctermbg=NONE
hi StatusLineNC		cterm=underline	ctermfg=gray		ctermbg=NONE
hi StatusLineTerm	cterm=bold		ctermfg=lightgreen	ctermbg=NONE
hi StatusLineTermNC	cterm=reverse	ctermfg=lightgreen	ctermbg=NONE
hi TabLine			cterm=NONE		ctermfg=white		ctermbg=240
hi TabLineFill		cterm=NONE		ctermfg=black		ctermbg=NONE
hi TabLineSel		cterm=NONE		ctermfg=black		ctermbg=lightblue
hi Title			cterm=bold		ctermfg=141			ctermbg=NONE
hi Todo				cterm=standout	ctermfg=black		ctermbg=yellow
hi Type				cterm=NONE		ctermfg=lightgreen	ctermbg=NONE
hi Underlined		cterm=underline	ctermfg=81			ctermbg=NONE
hi VertSplit		cterm=NONE		ctermfg=lightblue	ctermbg=NONE
hi Visual			cterm=reverse	ctermfg=242			ctermbg=white
hi VisualNOS		cterm=NONE		ctermfg=NONE		ctermbg=NONE
hi WarningMsg		cterm=NONE		ctermfg=magenta		ctermbg=NONE
hi WildMenu			cterm=reverse	ctermfg=yellow		ctermbg=black
