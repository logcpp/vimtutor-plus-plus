" Title: Vim Plugin - Ftdetect - plugin
" Author: logcpp
" Features: filetype detection and settings
" Created On: 2022/1/31
" Last Change: 2022/2/6

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

" $HOME/.vim/pack/logcpp/start/ftdetect/
let s:dir = s:Get_sfile()[0:-20]

function! s:BufEnter()
	let s:ft = &filetype
	call ftdetect#BufEnter(s:ft, s:dir)
endfunction

function! s:BufLeave()
	call ftdetect#BufLeave(s:ft)
endfunction

" ----------- end of functions ------------

au BufEnter * call <sid>BufEnter()
au BufLeave * call <sid>BufLeave()
