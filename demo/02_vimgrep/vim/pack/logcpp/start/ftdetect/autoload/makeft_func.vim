" Title: Vim Plugin - Ftdetect - autoload - Makefile
" Author: logcpp
" Features: function definitions for Makefile filetype
" Created On: 2022/2/1
" Last Change: 2022/2/1
" -------------------- functions --------------------

function! makeft_func#Make_set()
	imap UP		<Esc>gUiwgi
endfunction

function! makeft_func#Make_reset()
	iunmap UP
endfunction
