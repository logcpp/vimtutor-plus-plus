" Title: Vim syntax file
" Author: logcpp
" Langauge: C
" Created On: 2022/2/9
" Last Change: 2022/2/9

syntax match cUserVar /\v[a-z,_]+/
syntax match cUserFunc /\v[a-zA-Z,_]+\ze\(/
syntax match cUserType /\v([a-z]+_t|[A-Z][a-z,_]+)/

"hi cUserVar cterm=NONE ctermfg=230 ctermbg=NONE

hi link cUserType Type
hi link cUserFunc Preproc
