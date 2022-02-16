" Title: Vim Plugin - Ftdetect - autoload - Makefile
" Author: logcpp
" Features: function definitions for Makefile filetype
" Created On: 2022/2/1
" Last Change: 2022/2/6
" -------------------- functions --------------------

function! s:Base(...)
	if a:0 != 1 && a:0 != 2
		echoerr "Self Err: usage: Base <filetype> <filename>"
		return
	endif
	let l:ft = a:1
	if l:ft != "tex" && l:ft != "c"
		echoerr "Self Err: Makefile for filetype '".a:1."' is not supported"
		return
	elseif l:ft == "tex"
		let l:base = s:dir."src/make/tex_makefile"
	else
		let l:base = s:dir."src/make/c_makefile"
	endif
	execute "0r ".l:base
	$d
	if a:0 == 2
		silent execute "%s/myfile/".a:2."/g"
	endif
endfunction

function! sub#makeft#Make_set(dir)
	imap UP		<Esc>gUiwgi
	let s:dir = a:dir
	command! -nargs=+ Base call <sid>Base(<f-args>)
endfunction

function! sub#makeft#Make_reset()
	iunmap UP
	silent! delcommand Base
endfunction
