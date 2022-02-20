" Title: Vim Plugin - Surround - autoload
" Author: logcpp
" Version: 1.0
" Features: imitate the surround.vim plugin by Tim Pope
" Created On: 2022/2/20
" Last Change: 2022/2/20
" License: this file is placed in the public domain

" -------------------- s:functions --------------------

" get current script id
function! s:SID()
	return matchstr(expand('<sfile>'), '\zs<SNR>\d\+_\zeSID$')
endfunction

" return the surrounding string
function! s:Pair(c)
	let l:c = a:c
	let l:dict = {
	\ "(": "()", ")": "()", "[": "[]", "]": "[]",
	\ "{": "{}", "}": "{}", "<": "<>", ">": "<>"
	\ }
	return has_key(l:dict, l:c) ? l:dict[l:c] : l:c.l:c
endfunction

" find characters (str[0] and str[1]) on both sides
function! s:FindChar(str)
	let l:str = a:str
	let [l:linenr, l:colnr] = getpos(".")[1:2]
	let l:line = getline(l:linenr)
	let l:lhs = l:colnr - 1
	let l:rhs = l:colnr - 1
	" search backward (left-hand-side)
	while 1
		if l:line[l:lhs] == l:str[0]  | break | endif
		if l:lhs == 0
			let l:lhs = -1
			break
		endif
		let l:lhs -= 1
	endwhile
	" search forward (right-hand-side)
	let l:rmax = len(l:line) - 1
	while 1
		if l:line[l:rhs] == l:str[1] && l:lhs != l:rhs | break | endif
		if l:rhs == l:rmax
			let l:rhs = -1
			break
		endif
		let l:rhs += 1
	endwhile
	" return value [l:lhs, l:rhs] ([-1, -1] if not found)
	return [l:lhs, l:rhs]
endfunction

" create surrounding
function! s:CreateSurround(arg)
	let l:arg = a:arg
	if l:arg == "block" | return | endif
	" get the necessary information
	let [l:icmd, l:acmd] = l:arg == "line" ? ["I", "A"] : ["i", "a"]
	let l:pre_pos = getpos("'[")
	let l:pos_pos = getpos("']")
	let l:pos_pos[2] += 1
	" get the pair of surrounding characters
	let l:str = s:Pair(nr2char(getchar()))
	" create the surrounding
	call setpos(".", l:pre_pos) | execute "normal ".l:icmd.l:str[0]
	call setpos(".", l:pos_pos) | execute "normal ".l:acmd.l:str[1]
endfunction

" -------------------- surround#functions --------------------

" change surrounding
function! surround#ChangeSurround()
	let l:old_str = s:Pair(nr2char(getchar()))
	" find surrounding characters on both sides
	let [l:lhs, l:rhs] = s:FindChar(l:old_str)
	" if both side exists searching characters, execute substitution
	if l:lhs != -1 && l:rhs != -1
		let l:new_str = s:Pair(nr2char(getchar()))
		let l:lrep = l:lhs == 0 ? "" : l:lhs."l"
		let l:rrep = l:rhs."l"
		execute("normal 0".l:lrep."r".l:new_str[0]."0".l:rrep."r".l:new_str[1])
	endif
endfunction

" delete surrounding
function! surround#DeleteSurround()
	let l:str = s:Pair(nr2char(getchar()))
	" find surrounding characters on both sides
	let [l:lhs, l:rhs] = s:FindChar(l:str)
	" if both side exists searching characters, execute deletion
	if l:lhs != -1 && l:rhs != -1
		let l:lrep = l:lhs == 0 ? "" : l:lhs."l"
		let l:rrep = (l:rhs-1)."l"
		execute("normal 0".l:lrep."x0".l:rrep."x")
	endif
endfunction

" map to call s:CreateSurround() as an operator
function! surround#CreateSurround()
	let &operatorfunc = s:SID()."CreateSurround"
	return "g@"
endfunction
