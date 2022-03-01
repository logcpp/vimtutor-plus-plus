" Title: Vim Plugin - Ftdetect - autoload - Shell
" Author: logcpp
" Features: function definitions for sh filetype
" Created On: 2022/2/6
" Last Change: 2022/2/6
" Initial Version: 2022/1/17
" -------------------- functions --------------------

" main function of settings @ BufEnter
function! sub#shft#Sh_set()
	nnoremap <silent> <leader><CR> :!<C-r><C-l><CR>
	vnoremap <silent> <leader><CR> :w !bash<CR>
endfunction

" main function of resettings @ BufLeave
function! sub#shft#Sh_reset()
	silent! nunmap <leader><CR>
	silent! vunmap <leader><CR>
endfunction
