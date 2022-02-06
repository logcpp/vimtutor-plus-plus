" Title: Vim Plugin - Dragmode - plugin
" Author: logcpp
" Version: 1.0
" Features: drag part of code around
" Created On: 2022/2/4
" Last Change: 2022/2/4
" License: this file is placed in the public domain

if exists("g:loaded_dragmode")
	finish
endif
let g:loaded_dragmode = 1

function! s:DragStart(line1, line2)
	call dragmode#DragStart(a:line1, a:line2)
endfunction

command! -range		DragStart	call <sid>DragStart(<line1>, <line2>)

nnoremap <silent>	<plug>(dragmode-n)	:DragStart<CR>
vnoremap <silent>	<plug>(dragmode-v)	:DragStart<CR>

" add the script below to your .vimrc
" nmap	<leader>j	<plug>(dragmode-n)
" vmap	<leader>j	<plug>(dragmode-v)
