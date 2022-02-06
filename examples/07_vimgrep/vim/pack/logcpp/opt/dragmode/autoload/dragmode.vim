" Title: Vim Plugin - Dragmode - autoload
" Author: logcpp
" Version: 1.0
" Features: drag part of code around
" Created On: 2022/2/4
" Last Change: 2022/2/4
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

function! s:DragMsg()
	echohl ModeMsg
		echon "-- Drag --"
	echohl None
endfunction

function! s:DragDst(c)
	let [l:c, l:line1, l:line2, l:vcount] = [a:c, s:line1, s:line2, s:vcount]
	let l:vcount = l:vcount == 0 ? 1 : l:vcount
	let l:lnum = l:line2 - l:line1 + 1
	if l:c == 'j'
		let l:dl = l:vcount - 1
		let l:dst = s:Min(s:line1+l:dl, line('$')-l:lnum)
	elseif l:c == 'k'
		let l:dl = - l:vcount + 1
		let l:dst = s:Max(s:line1+l:dl-2, 0)
	endif
	return [l:dst, l:lnum]
endfunction

function! s:DragRun(c)
	let l:c = a:c
	if s:inbetween(l:c, 'a', 'z')
		let [l:dst, l:lnum] = s:DragDst(l:c)
		silent execute s:line1.",".s:line2."d"
		silent execute l:dst."put"
		let s:line1 = l:dst + 1
		let s:line2 = l:dst + l:lnum
		let s:vcount = 0
	elseif s:inbetween(l:c, '0', '9')
		let s:vcount = s:vcount*10+char2nr(l:c)-char2nr('0')
	endif
endfunction

" ---------- dragmode#functions -----------

function! dragmode#DragStart(line1, line2)
	let [s:line1, s:line2, s:vcount] = [a:line1, a:line2, 0]
	call s:DragMsg()
	let l:c = getchar()
	while l:c != 27 " Esc
		let l:c = nr2char(l:c)
		let l:res = s:DragRun(l:c)
		redraw
		let l:c = getchar()
	endwhile
	echo ""
endfunction
