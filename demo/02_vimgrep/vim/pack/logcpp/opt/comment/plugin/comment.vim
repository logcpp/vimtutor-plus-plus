" Title: Vim Plugin - Comment - plugin
" Author: logcpp
" Version: 1.0
" Features: comment or comment out code based on Filetype
" Created On: 2022/2/3
" Last Change: 2022/2/3
" License: this file is placed in the public domain

if exists("g:loaded_comment")
	finish
endif
let g:loaded_comment = 1

function! s:Update()
	call comment#Update()
endfunction

function! s:Comment_c(line1, line2, ins)
	call comment#Comment_c(a:line1, a:line2, a:ins)
endfunction

function! s:SetOpf(ins)
	return comment#SetOpf(a:ins)
endfunction

" ----------- end of functions ------------

call s:Update()

autocmd BufEnter * call <sid>Update()
command! -range Comment		call <sid>Comment_c(<line1>, <line2>, 1)
command! -range Uncomment	call <sid>Comment_c(<line1>, <line2>, -1)
nnoremap <expr> <plug>(comment-cmt-n) <sid>SetOpf(1)
nnoremap <expr> <plug>(comment-unc-n) <sid>SetOpf(-1)
vnoremap <silent> <plug>(comment-cmt-v) :Comment<CR>
vnoremap <silent> <plug>(comment-unc-v) :Uncomment<CR>

" add script below to your .vimrc
" nmap gc  <plug>(comment-cmt-n)
" nmap gC  <plug>(comment-unc-n)
" vmap gc  <plug>(comment-cmt-v)
" vmap gC  <plug>(comment-unc-v)
