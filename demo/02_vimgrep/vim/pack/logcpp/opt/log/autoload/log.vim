" Title: Vim Plugin - Log - autoload
" Author: logcpp
" Version: 1.0
" Features: functions to handle files start with "log entry:"
" Created On: 2022/2/8
" Last Change: 2022/2/8
" License: this file is placed in the public domain

function! log#LogFold()
	let l:line = getline(v:lnum)
	let l:nextline = getline(v:lnum+1)
	let l:matchpat = '\v^\s*log entry: '
	if match(l:line, l:matchpat) > -1
		return ">1"
	elseif match(l:nextline, l:matchpat) > -1
		return "<1"
	else
		return "-1"
	endif
endfunction
