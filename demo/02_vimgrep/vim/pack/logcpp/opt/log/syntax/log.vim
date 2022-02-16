" Title: Vim syntax file
" Filetype: log
" Author: logcpp
" Created On: 2022/2/8
" Last Change: 2022/2/8

if version < 600
	syntax clear
elseif exists("b:current_syntax")
	finish
endif

syntax case match

syntax match logHeader		/log entry:/
syntax match logDate		/\d\{4\}\/\d\{1,2\}\/\d\{1,2\}/
syntax match logComment		/#.*/

hi def link logHeader 		PreProc
hi def link logDate			Statement
hi def link logComment 		Comment
