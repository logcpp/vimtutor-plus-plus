" Title: Vim Plugin - Comment - autoload
" Author: logcpp
" Version: 1.0
" Features: comment or comment out code based on Filetype
" Created On: 2022/2/3
" Last Change: 2022/2/3
" License: this file is placed in the public domain

" -------------- s:functions --------------

function! s:SID()
	return matchstr(expand('<sfile>'), '\zs<SNR>\d\+_\zeSID$')
endfunction

function! s:Getchar()
	return nr2char(getchar())
endfunction

" comment from line1 to line2,
" ins==1:comment, ins==-1:uncomment
function! s:CommentLine(line1, line2, ins)
	let l:line1 = a:line1
	let l:line2 = a:line2
	for l:i in range(l:line1, l:line2)
		let l:line = getline(l:i)
		" if is empty line => do nothing
		if match(l:line, '^\s*$') > -1 | continue | endif
		let l:cmstr = g:comment_str
		" comment
		if a:ins == 1
			execute l:i.'s/\v^\s*\zs\ze/'.l:cmstr.' '
		" uncomment
		elseif a:ins == -1 && match(l:line, '\v^\s*'.l:cmstr) > -1
			execute l:i.'s/\v^\s*\zs'.l:cmstr.'[ ]?//'
		endif
	endfor
endfunction

" ---------- comment#functions ------------

" update g:comment_str (comment_str)
" NOTE: add to l:dict if you want to set comment_string to a new filetype
function! comment#Update()
	let l:dict = {
	\ 'c'		: '\/\/'	,
	\ 'python'	: '\#'		,
	\ 'sh'		: '\#'		,
	\ 'tex'	    : '\%'		,
	\ 'vim'	    : '"'
	\ }
	let l:ft = &filetype
	let g:comment_str = has_key(l:dict, l:ft)? l:dict[l:ft] : -1
endfunction

" commenting by Ex command
function! comment#Comment_c(line1, line2, ins)
	" comment_str undefined => do nothing
	if g:comment_str == -1 | return | endif
	call s:CommentLine(a:line1, a:line2, a:ins)
endfunction

" commenting by g@
function! s:Comment_n(arg)
	let l:line1 = line("'[")
	let l:line2 = line("']")
	call s:CommentLine(l:line1, l:line2, s:ins)
	let s:ins = ''
	let &operatorfunc = s:opf
endfunction

" set 'operatorfunc' for g@
function! comment#SetOpf(ins)
	" comment_str undefined => do nothing
	if g:comment_str == -1 | return '' | endif
	let s:opf = &operatorfunc
	let s:ins = a:ins
	let l:sid = s:SID()
	let &operatorfunc = l:sid."Comment_n"
	return "g@"
endfunction
