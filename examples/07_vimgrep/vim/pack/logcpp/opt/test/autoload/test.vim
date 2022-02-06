" Title: Vim Plugin - Test - autoload
" Author: logcpp
" Features: an example of Vim plugin, only for testing
" Created On: 2022/1/25
" Last Change: 2022/1/25

function! test#Echo(msg)
	let l:msg = "\"" . a:msg . "\"" . " from " . getcwd()
	echo l:msg
endfunction

function! s:SID()
	" get the <sid> number of this plugin
	return matchstr(expand('<sfile>'), '<SNR>\zs\d\+\ze_SID$')
endfunction
function! test#AdvEcho(msg)
	let l:script_sid = s:SID()
	let l:script_list = execute("scriptnames")
	let l:script_path = expand(matchstr(l:script_list, l:script_sid . ':\s\zs.*'))
	let l:msg = "\"" . a:msg . "\"" . " from " . l:script_path
	echo l:msg
endfunction
