" Title: Vim color file
" Author: logcpp
" Features: pastel color theme
" Created On: 2022/2/9
" Last Change: 2022/2/9

" use 256 cterm colors:
"   background:60
"   yellow:228, red:157, magenta:213, green:82, blue:blue, cyan:cyan:123, pink:219:224
" use true gui colors:
"   background:#181824
"   blue: #181824, #242432, #303043, #8899ee, #a0b0e0, #3060d0
"	purple: #c0b0ff, #c060ff
"	yellow: #ffff60
"	green: #80ff80
"	red: #ff3030, #ffa0c0, #bb1111

if &t_Co < 256
	finish
endif

hi clear
set background=dark
if has("termguicolors")
	set termguicolors
endif

" Load the syntax highlighting defaults, if it's enabled.
if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "pastel"

hi Normal			cterm=NONE		ctermfg=white		ctermbg=61				gui=NONE		guifg=NONE			guibg=#181824

hi ColorColumn		cterm=NONE		ctermfg=NONE		ctermbg=7				gui=NONE		guifg=NONE			guibg=#303043
hi Comment			cterm=NONE		ctermfg=lightblue	ctermbg=NONE			gui=NONE		guifg=#8899ee		guibg=NONE
hi Conceal			cterm=NONE		ctermfg=NONE		ctermbg=NONE			gui=NONE		guifg=NONE			guibg=NONE
hi Constant			cterm=NONE		ctermfg=213			ctermbg=NONE			gui=NONE		guifg=#c0b0ff		guibg=NONE
hi Cursor			cterm=NONE		ctermfg=NONE		ctermbg=NONE			gui=NONE		guifg=NONE			guibg=NONE
hi CursorColumn		cterm=NONE		ctermfg=NONE		ctermbg=NONE			gui=NONE		guifg=NONE			guibg=NONE
hi CursorLine		cterm=NONE		ctermfg=NONE		ctermbg=NONE			gui=NONE		guifg=NONE			guibg=#303043
hi CursorLineNr		cterm=NONE		ctermfg=228			ctermbg=NONE			gui=NONE		guifg=#ffff60		guibg=NONE
hi DiffAdd			cterm=NONE		ctermfg=NONE		ctermbg=35				gui=NONE		guifg=NONE			guibg=#309060
hi DiffChange		cterm=NONE		ctermfg=NONE		ctermbg=61				gui=NONE		guifg=NONE			guibg=#606090
hi DiffDelete		cterm=NONE		ctermfg=NONE		ctermbg=167				gui=NONE		guifg=NONE			guibg=#d05070
hi DiffText			cterm=NONE		ctermfg=white		ctermbg=198				gui=NONE		guifg=NONE			guibg=#ff00ff
hi Directory		cterm=NONE		ctermfg=blue		ctermbg=NONE			gui=NONE		guifg=#c0b0ff		guibg=NONE
hi EndOfBuffer		cterm=NONE		ctermfg=blue		ctermbg=NONE			gui=NONE		guifg=#8899ee		guibg=NONE
hi Error			cterm=standout	ctermfg=167			ctermbg=white			gui=standout	guifg=#bb1111		guibg=#ffffff
hi ErrorMsg			cterm=standout	ctermfg=167			ctermbg=white			gui=standout	guifg=#bb1111		guibg=#ffffff
hi FoldColumn		cterm=NONE		ctermfg=NONE		ctermbg=NONE			gui=NONE		guifg=cyan			guibg=NONE
hi Folded			cterm=NONE		ctermfg=61			ctermbg=147				gui=NONE		guifg=#8899ee		guibg=#242432
hi Identifier		cterm=bold		ctermfg=228			ctermbg=NONE			gui=NONE		guifg=cyan			guibg=NONE
hi Ignore			cterm=NONE		ctermfg=61			ctermbg=NONE			gui=NONE		guifg=#181824		guibg=NONE
hi IncSearch		cterm=reverse	ctermfg=blue		ctermbg=238				gui=reverse		guifg=#ffff60		guibg=black
hi LineNr			cterm=NONE		ctermfg=123			ctermbg=NONE			gui=NONE		guifg=#8899ee		guibg=NONE
hi MatchParen		cterm=NONE		ctermfg=blue		ctermbg=NONE			gui=bold		guifg=cyan			guibg=NONE
hi ModeMsg			cterm=bold		ctermfg=cyan		ctermbg=NONE			gui=bold		guifg=cyan			guibg=NONE
hi MoreMsg			cterm=NONE		ctermfg=120			ctermbg=NONE			gui=NONE		guifg=#80ff80		guibg=NONE
hi NonText			cterm=NONE		ctermfg=blue		ctermbg=NONE			gui=NONE		guifg=#8899ee		guibg=NONE
hi Pmenu			cterm=NONE		ctermfg=238			ctermbg=219				gui=NONE		guifg=#aabbff		guibg=#050507
hi PmenuSbar		cterm=NONE		ctermfg=NONE		ctermbg=175				gui=NONE		guifg=NONE			guibg=#242432
hi PmenuSel			cterm=NONE		ctermfg=238			ctermbg=225				gui=NONE		guifg=black			guibg=#8899ee
hi PmenuThumb		cterm=NONE		ctermfg=NONE		ctermbg=225				gui=NONE		guifg=NONE			guibg=#606580
hi PreProc			cterm=NONE		ctermfg=123			ctermbg=NONE			gui=NONE		guifg=#80e0ff		guibg=NONE
hi Question			cterm=NONE		ctermfg=120			ctermbg=NONE			gui=NONE		guifg=#80ff80		guibg=NONE
hi QuickFixLine		cterm=reverse	ctermfg=228			ctermbg=238				gui=NONE		guifg=#ffff60		guibg=NONE
hi Search			cterm=reverse	ctermfg=119			ctermbg=238				gui=reverse		guifg=#40dd80		guibg=black
hi SignColumn		cterm=NONE		ctermfg=NONE		ctermbg=NONE			gui=NONE		guifg=NONE			guibg=#181824
hi Special			cterm=NONE		ctermfg=224			ctermbg=NONE			gui=NONE		guifg=#ffa0e0		guibg=NONE
hi SpecialKey		cterm=NONE		ctermfg=cyan		ctermbg=NONE			gui=NONE		guifg=#ffa0e0		guibg=NONE
hi SpellBad			cterm=NONE		ctermfg=157			ctermbg=NONE			gui=NONE		guifg=white			guibg=#ff3030
hi SpellCap			cterm=NONE		ctermfg=blue		ctermbg=NONE			gui=NONE		guifg=white			guibg=#3060d0
hi SpellLocal		cterm=NONE		ctermfg=lightblue	ctermbg=NONE			gui=NONE		guifg=white			guibg=#3060d0
hi SpellRare		cterm=NONE		ctermfg=cyan		ctermbg=NONE			gui=NONE		guifg=white			guibg=#30d060
hi Statement		cterm=NONE		ctermfg=228			ctermbg=NONE			gui=NONE		guifg=#ffff60		guibg=NONE
hi StatusLine		cterm=NONE		ctermfg=123			ctermbg=NONE			gui=NONE		guifg=#ddeeff		guibg=#404060
hi StatusLineNC		cterm=NONE		ctermfg=gray		ctermbg=NONE			gui=NONE		guifg=#ddeeff		guibg=#404060
hi StatusLineTerm	cterm=bold		ctermfg=120			ctermbg=NONE			gui=NONE		guifg=#90a0f0		guibg=#181824
hi StatusLineTermNC	cterm=reverse	ctermfg=120			ctermbg=NONE			gui=NONE		guifg=#181824		guibg=#909090
hi TabLine			cterm=NONE		ctermfg=white		ctermbg=NONE			gui=NONE		guifg=#ddeeff		guibg=#404060
hi TabLineFill		cterm=NONE		ctermfg=238			ctermbg=NONE			gui=NONE		guifg=NONE			guibg=#404060
hi TabLineSel		cterm=NONE		ctermfg=238			ctermbg=219				gui=NONE		guifg=black			guibg=#8899ee
hi Title			cterm=bold		ctermfg=135			ctermbg=NONE			gui=NONE		guifg=#8899ee		guibg=NONE
hi Todo				cterm=NONE		ctermfg=238			ctermbg=228				gui=NONE		guifg=black			guibg=#ffff60
hi ToolbarButton	cterm=NONE		ctermfg=NONE		ctermbg=NONE			gui=NONE		guifg=NONE			guibg=NONE
hi ToolbarLine		cterm=NONE		ctermfg=NONE		ctermbg=NONE			gui=NONE		guifg=NONE			guibg=NONE
hi Type				cterm=NONE		ctermfg=120			ctermbg=NONE			gui=NONE		guifg=#70ff90		guibg=NONE
hi Underlined		cterm=underline	ctermfg=cyan		ctermbg=NONE			gui=underline	guifg=cyan			guibg=NONE
hi VertSplit		cterm=NONE		ctermfg=cyan		ctermbg=NONE			gui=NONE		guifg=#90a0f0		guibg=NONE
hi Visual			cterm=reverse	ctermfg=229			ctermbg=238				gui=NONE		guifg=#ffff60		guibg=black
hi VisualNOS		cterm=NONE		ctermfg=NONE		ctermbg=NONE			gui=NONE		guifg=NONE			guibg=NONE
hi WarningMsg		cterm=NONE		ctermfg=213			ctermbg=NONE			gui=NONE		guifg=#ffa0c0		guibg=NONE
hi WildMenu			cterm=reverse	ctermfg=228			ctermbg=238				gui=reverse		guifg=#ffff60		guibg=black


hi airlimeMode_n	cterm=bold		ctermfg=238			ctermbg=120				gui=bold		guifg=black			guibg=#66ff88
hi airlimeMode_v	cterm=bold		ctermfg=238			ctermbg=lightmagenta	gui=bold		guifg=black			guibg=#ffa0c0
hi airlimeMode_s	cterm=bold		ctermfg=238			ctermbg=219				gui=bold		guifg=black			guibg=#ff6060
hi airlimeMode_i	cterm=bold		ctermfg=238			ctermbg=lightblue		gui=bold		guifg=black			guibg=#30dddd
hi airlimeMode_r	cterm=bold		ctermfg=238			ctermbg=215				gui=bold		guifg=black			guibg=#ffaa33
hi airlimeMode_c	cterm=bold		ctermfg=238			ctermbg=229				gui=bold		guifg=black			guibg=#ffff60
hi airlimeMode_t	cterm=bold		ctermfg=238			ctermbg=blue			gui=bold		guifg=black			guibg=#8090e0
hi airlimeMode_e	cterm=bold		ctermfg=238			ctermbg=238				gui=bold		guifg=white			guibg=#000000
