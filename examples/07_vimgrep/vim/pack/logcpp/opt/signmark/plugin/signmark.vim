" Title: Vim Plugin - SignMark - plugin
" Author: logcpp
" Version: 1.0
" Features: places signs to the lines which contain marks
" Created On: 2022/1/24
" Last Change: 2022/2/3
" Initial Version: 0.0 (created on: 2022/1/23)
" License: this file is placed in the public domain

if exists("g:loaded_signmark")
	finish
endif
let g:loaded_signmark = 1

function! s:Turnon()
	call signmark#Turnon()
endfunction

function! s:Turnoff()
	" do nothing if disabled
	if !exists("g:m_list") | echo "" | return | endif
	call signmark#Turnoff()
endfunction

function! s:Place()
	" do nothing if disabled
	if !exists("g:m_list") | echo "" | return | endif
	call signmark#Place()
endfunction

function! s:Unplace()
	" do nothing if disabled
	if !exists("g:m_list") | echo "" | return | endif
	call signmark#Unplace()
endfunction

function! s:Clear(bang)
	" do nothing if disabled
	if !exists("g:m_list") | echo "" | return | endif
	call signmark#Clear(a:bang)
endfunction

command! Mon	call <sid>Turnon()
command! Moff	call <sid>Turnoff()
command! -bang Mclear call <sid>Clear('<bang>')

nnoremap <sid>Place		:call <sid>Place()<CR>
nnoremap <sid>Unplace	:call <sid>Unplace()<CR>

nmap <unique>  <plug>(signmark-place)		<sid>Place
nmap <unique>  <plug>(signmark-unplace)	<sid>Unplace

" add the following script to your .vimrc:
" 	nmap <leader>m	<plug>(signmark-place)
"	nmap <leader>M	<plug>(signmark-unplace)
