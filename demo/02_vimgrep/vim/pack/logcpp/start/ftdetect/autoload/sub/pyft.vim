" Title: Vim Plugin - Ftdetect - autoload - Python
" Author: logcpp
" Features: function definitions for Python filetype
" Created On: 2022/2/10
" Last Change: 2022/2/10
" -------------------- functions --------------------

function! sub#pyft#Pyft_set()
	nnoremap <leader><CR> :w \| !python3 %<CR>
endfunction

function! sub#pyft#Pyft_reset()
	silent! nunmap <leader><CR>
endfunction
