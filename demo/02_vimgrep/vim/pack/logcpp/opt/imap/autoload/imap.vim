" Title: Vim Plugin - Imap - autoload
" Author: logcpp
" Version: 1.0
" Features: mapping some useful commands to UPPERCASE characters in Insert mode
" Created On: 2022/2/1
" Last Change: 2022/2/1
" License: this file is placed in the public domain

function! imap#UpperInitial()
	let l:str = @"
	let l:ini = char2nr(l:str[0])
	let l:offset = char2nr("a") - char2nr("A")
	let l:suffix = len(l:ini) > 1 ? l:str[1:] : ""
	if l:ini >= char2nr("a") && l:ini <= char2nr("z")
		let l:str = nr2char(l:ini-l:offset) . l:suffix
	endif
	echomsg l:str
	return l:str
endfunction
