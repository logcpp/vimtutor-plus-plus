" Title: Vim Plugin - Text Object - autoload
" Author: logcpp
" Version: 1.0
" Features: definition of user text objects
" Created On: 2022/2/5
" Last Change: 2022/2/7
" License: this file is placed in the public domain

" ------------- indent block --------------

" visual selection of the same indent level block
function! textobj#IndentBlock(ins)
	if a:ins == 'i'
		let l:dhs = 1
	elseif a:ins == 'a'
		let l:dhs = 0
	else
		echoerr "Self Err: ".a:ins." is not a valid argument for textobj#IndentBlockIndLevel()"
		return
	endif
	let l:i0 = indent(line('.'))
	if l:i0 == 0 | return | endif
	let l:l0 = line('.')
	let l:l9 = line('$')
	let l:lhs = l:l0
	let l:rhs = l:l0
	" search backward
	while l:i0 <= indent(l:lhs)
		if l:lhs == 0 | break | endif
		let l:lhs -= 1
	endwhile
	let l:lhs = min([l:lhs+l:dhs, l:l0])
	" search forward
	while l:i0 <= indent(l:rhs)
		if l:rhs == l:l9 | break | endif
		let l:rhs += 1
	endwhile
	let l:rhs = max([l:rhs-l:dhs, l:l0])
	execute "normal! ".l:lhs."GV".l:rhs."G"
endfunction

" ------------ function block -------------

" check if the line is empty or is a comment
function! s:notfunc(str)
    return match(a:str, '\v^\s*$') > -1 || match(a:str, '\v^\s*'.g:comment_str) > -1
endfunction

" visual selection of the function block without comment, need package "comment" loaded
function! textobj#FunctionBlock(ins)
	if a:ins != 'a' && a:ins != 'i' 
		echoerr "Self Err: invalid argument '".a:ins."' for s:FunctionBlock()"
	endif
	let l:i0 = line('.')
	" if is not on function => do nothing
	if s:notfunc(getline(l:i0)) && indent(l:i0) <= 0 | return | endif
	" if current line is near boundary => try to get into function by moving one line
	let l:block = 0
	if indent(l:i0) == 0
		" check if prev/next line is not func && indent<=0 => previous/next is boundary
		let l:pb = s:notfunc(getline(l:i0-1)) && indent(l:i0-1) <= 0
		let l:nb = s:notfunc(getline(l:i0+1)) && indent(l:i0+1) <= 0
		if !l:pb " prev is not boundary => move to previous line
			let l:i0 -= 1
		elseif !l:nb " next is not boundary => move to next line
			let l:i0 += 1
		endif
		" if there seems no indent in current function => set as block
		if indent(l:i0-1) <= 0 && indent(l:i0+1) <= 0
			let l:block = 1
		endif
	endif
	let l:clb = indent(l:i0) == 0 ? 1 : 0
	let l:lhb = l:clb
	let l:rhb = l:clb
	let l:lhs = l:i0
	let l:rhs = l:i0
	" search backward
	while 1
		if l:lhs == 0 | break | endif
		let l:line = getline(l:lhs-1)
		" if is near boundary (indent==0) and is empty/coment => end
		if l:lhb
			if s:notfunc(l:line) | break | endif
		else " if is func && indent <= 0 => near boundary
			if !s:notfunc(l:line) && indent(l:lhs-1) <= 0 
				if a:ins == 'i' | break | endif
				let l:lhb = 1 
			endif
		endif
		let l:lhs -= 1
	endwhile
	" search forward
	let l:last = line('$')
	while 1
		if l:rhs == l:last | break | endif
		let l:line = getline(l:rhs+1)
		" if is near boundary (indent changed to 0) and is empty/comment => end
		if l:rhb
			if s:notfunc(l:line) | break | endif
		else " if is func && indent <= 0 => near boundary
			if !s:notfunc(l:line) && indent(l:rhs+1) <= 0
				if a:ins == 'i' | break | endif
				let l:rhb = 1
			endif
		endif
		let l:rhs += 1
	endwhile
	" if seems not indented => reduce scope if ins=='i'
	if a:ins == 'i' && l:block == 1
		let l:lhs = min([l:lhs+1, l:i0])
		let l:rhs = max([l:rhs-1, l:i0])
	endif
	execute "normal! ".l:lhs."GV".l:rhs."G"
endfunction

" --------------- pair block ---------------

function! textobj#PairBlock(ins, char)
	if a:ins != 'i' && a:ins != 'a'
		echoerr "Self Err: '".a:ins."' is not a valid argument for PairBlock()"
		return
	endif
	let l:offset = a:ins == 'i'? 1 : 0
	let l:char = a:char
	let [l:linenr, l:colnr] = getcurpos()[1:2]
	let l:line = getline(l:linenr)
	let l:curchar = l:line[l:colnr-1]
	let l:lhs = -1
	let l:rhs = -1
	let l:tmp = l:curchar == l:char ? l:colnr-1 : -1
	" search forward
	for l:i in range(l:colnr-2, 0, -1)
		if l:line[l:i] == l:char
			let l:lhs = l:i
			let l:rhs = l:tmp
			break
		endif
	endfor
	" no match in front of cursor
	let l:lhs = l:lhs == -1 ? l:tmp : l:lhs	
	" if still need to search backward
	if l:rhs == -1
		for l:i in range(l:colnr, len(l:line)-1)
			if l:line[l:i] == l:char
				let l:rhs = l:i
				break
			endif
		endfor
	endif
	" if found matching characters in both side
	if l:lhs > -1 && l:rhs > -1
		let l:lhs = min([l:colnr-1, l:lhs])+l:offset
		let l:rhs = max([l:colnr-1, l:rhs])-l:offset
		let l:lcmd = l:lhs == 0 ? "" : l:lhs."l"
		let l:rcmd = l:rhs == 0 ? "" : l:rhs."l"
		execute "normal! 0".l:lcmd."v0".l:rcmd
	endif
endfunction

" ------------- comment block -------------

" check if the line is a comment
function! s:iscomment(str)
	return match(a:str, '\v^\s*'.g:comment_str) > -1
endfunction

" visual selection of the comment block, 'i' & 'a' work the same, need package "comment" loaded
function! textobj#CommentBlock(ins)
	if a:ins != 'a' && a:ins != 'i'
		echoerr "Self Err: '".a:ins."' is not a valid argument for CommentBlock()"
		return
	endif
	let l:last = line('$')
	let l:cur = line('.')
	if !s:iscomment(getline(l:cur)) | return | endif
	let l:lhs = l:cur
	let l:rhs = l:cur
	" search backward
	while l:lhs > 1
		if s:iscomment(getline(l:lhs-1))
			let l:lhs -= 1  
		else
			break
		endif
	endwhile
	" search forward
	while l:rhs < l:last
		if s:iscomment(getline(l:rhs+1))
			let l:rhs += 1
		else
			break
		endif
	endwhile
	execute "normal! ".l:lhs."GV".l:rhs."G"
endfunction
