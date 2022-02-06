" Title: Vim Plugin - Ftdetect - plugin
" Author: logcpp
" Features: filetype detection and settings
" Created On: 2022/1/31
" Last Change: 2022/2/2

if exists("g:loaded_ftdetect")
	finish
endif
let g:loaded_ftdetect = 1

function! s:SID()
	" get the <sid> number of this plugin
	return matchstr(expand('<sfile>'), '<SNR>\zs\d\+\ze_SID$')
endfunction

function! s:Get_sfile()
	" get the path to this plugin
	let l:script_num = s:SID()
	let l:script_list = execute("scriptnames")
	return matchstr(l:script_list, l:script_num . ':\s\zs.*')
endfunction

let s:dir = s:Get_sfile()[0:-20]

" ----------- end of functions ------------

" C
au BufEnter *.c		call cft_func#C_set(s:dir)
au BufLeave *.c		call cft_func#C_reset()

" Makefile
au BufEnter Makefile,makefile call makeft_func#Make_set()
au BufLeave Makefile,makefile call makeft_func#Make_reset()

" TeX
au BufEnter *.tex	call texft_func#Tex_set(s:dir)
au BufLeave *.tex	call texft_func#Tex_reset()

" Vimscript
au BufEnter *.vim	call vimft_func#Vim_set()
au BufLeave *.vim	call vimft_func#Vim_reset()

