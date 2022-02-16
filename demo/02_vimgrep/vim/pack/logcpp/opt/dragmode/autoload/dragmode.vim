" Title: Vim Plugin - Dragmode - autoload
" Author: logcpp
" Version: 1.0
" Features: drag part of code around
" Created On: 2022/2/4
" Last Change: 2022/2/7
" License: this file is placed in the public domain

" -------------- s:functions --------------

function! s:Max(x, y)
	return a:x > a:y ? a:x : a:y
endfunction

function! s:Min(x, y)
	return a:x < a:y ? a:x : a:y
endfunction

function! s:inbetween(ci, cx, cy)
	return char2nr(a:ci) >= char2nr(a:cx) && char2nr(a:ci) <= char2nr(a:cy) ? 1 : 0
endfunction

function! s:eq(x, y)
	return char2nr(a:x) == char2nr(a:y)
endfunction

function! s:DragMsg()
	echohl ModeMsg
		echon "-- Drag --"
	echohl None
endfunction

function! s:DragHighlight(mode)
	let [l:mode, l:line1, l:lnum] = [a:mode, s:line1, s:lnum]
	let l:s_name = "dragmode"
	let l:s_group = "g_dragmode"
	let l:s_text = "+"
	if l:mode == "define"
		execute "sign define ".l:s_name." text=".l:s_text." texthl=ModeMsg linehl=ModeMsg"
	elseif l:mode == "place"
		for l:i in range(l:line1, l:line1+l:lnum-1)
			execute "sign place 1 line=".l:i." name=".l:s_name." group=".l:s_group
		endfor
	elseif l:mode == "unplace"
		execute "sign unplace * group=".l:s_group
	elseif l:mode == "undefine"
		execute "sign undefine ".l:s_name
	endif
endfunction

function! s:DragDst(c)
	let [l:c, l:line1, l:line2, l:lnum, l:vcount] = [a:c, s:line1, s:line2, s:lnum, s:vcount]
	let l:do_nothing = l:line1 - 1
	let l:last = line('$') - l:lnum
	if s:eq(l:c, 'j')
		let l:vcount = l:vcount == 0 ? 1 : l:vcount
		let l:dl = l:vcount - 1
		let l:dst = s:Min(s:line1+l:dl, l:last)
	elseif s:eq(l:c, 'k')
		let l:vcount = l:vcount == 0 ? 1 : l:vcount
		let l:dl = - l:vcount + 1
		let l:dst = s:Max(s:line1+l:dl-2, 0)
	elseif s:eq(l:c, 'G')
		let l:dst = l:vcount == 0 ? l:last : s:Min(s:vcount-1, l:last)
	elseif s:eq(l:c, 'g')
		let l:dst = l:vcount == 0 ? 0 : s:Min(s:vcount-1, l:last)
	elseif s:eq(l:c, 'd')
		let l:dst = s:Min(s:line1+s:scroll, l:last)
	elseif s:eq(l:c, 'u')
		let l:dst = s:Max(s:line1-s:scroll-2, 0)
	elseif s:eq(l:c, 'z')
		execute "normal! zz".(l:lnum/2)."\<C-e>"
		let l:dst = l:do_nothing
	else
		let l:dst = l:do_nothing
	endif
	return l:dst
endfunction

function! s:DragRun(c)
	let l:c = a:c
	if s:inbetween(l:c, 'a', 'z') || s:inbetween(l:c, 'A', 'Z')
		call s:DragHighlight("unplace")
		let l:dst = s:DragDst(l:c)
		silent execute s:line1.",".s:line2."d"
		silent execute l:dst."put"
		let s:line1 = l:dst + 1
		let s:line2 = l:dst + s:lnum
		let s:vcount = 0
		call s:DragHighlight("place")
	elseif s:inbetween(l:c, '0', '9')
		let s:vcount = s:vcount*10+char2nr(l:c)-char2nr('0')
	endif
endfunction

function! s:DragInit(line1, line2)
	let [s:line1, s:line2, s:vcount] = [a:line1, a:line2, 0]
	let s:lnum = s:line2 - s:line1 + 1
	let s:vcount = 0
	let s:scroll = &scroll
	let s:cursorline = &cursorline
	set nocursorline
	call s:DragHighlight("define")
	call s:DragHighlight("place")
endfunction

function! s:DragEnd()
	normal :
	call s:DragHighlight("unplace")
	call s:DragHighlight("undefine")
	let &cursorline = s:cursorline
endfunction

function! s:DragRedraw()
	execute s:line1
	redraw
	call s:DragMsg()
endfunction

" ---------- dragmode#functions -----------

function! dragmode#DragStart(line1, line2)
	call s:DragInit(a:line1, a:line2)
	let l:c = 0
	while l:c != 27 " Esc
		call s:DragRedraw()
		let l:c = getchar()
		let l:res = s:DragRun(nr2char(l:c))
	endwhile
	call s:DragEnd()
endfunction
