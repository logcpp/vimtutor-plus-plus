" Title: Vim Plugin - Foldmode - plugin
" Author: logcpp
" Version: 1.0
" Features: toggle 'z' for easy navigation of foldings
" Created On: 2022/1/28
" Last Change: 2022/2/3
" Initial Verrsion: 0.0 (created on: 2022/1/15)
" License: this file is placed in the public domain

if exists("g:loaded_foldmode")
	finish
endif
let g:loaded_foldmode = 1

function! s:Foldon()
	call foldmode#Foldon()
endfunction

nnoremap <sid>Foldon	:call <sid>Foldon()<CR>
nmap <plug>(foldmode-on) <sid>Foldon

" add the following script to your .vimrc:
"	nmap <leader>z	<plug>(foldmode-on)
