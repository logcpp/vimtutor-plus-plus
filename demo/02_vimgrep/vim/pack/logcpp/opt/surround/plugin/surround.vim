" Title: Vim Plugin - Surround - plugin
" Author: logcpp
" Version: 1.0
" Features: imitate the surround.vim plugin by Tim Pope
" Created On: 2022/2/20
" Last Change: 2022/2/20
" License: this file is placed in the public domain

if exists("g:loaded_surround")
	finish
endif
let g:loaded_surround = 1

function! s:ChangeSurround()
	call surround#ChangeSurround()
endfunction

function! s:DeleteSurround()
	call surround#DeleteSurround()
endfunction

function! s:CreateSurround()
	return surround#CreateSurround()
endfunction

" ---------- end of functions ----------

nnoremap <silent>	<plug>(surround-cs) :<C-u>call <sid>ChangeSurround()<CR>
nnoremap <silent>	<plug>(surround-ds) :<C-u>call <sid>DeleteSurround()<CR>
nnoremap <expr>		<plug>(surround-ys) <sid>CreateSurround()

" add script below to your .vimrc
" nmap cs <plug>(surround-cs)
" nmap ds <plug>(surround-ds)
" nmap ys <plug>(surround-ys)
