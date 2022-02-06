" Title: Vim Plugin - Text Object - plugin
" Author: logcpp
" Version: 1.0
" Features: definition of user text objects
" Created On: 2022/2/5
" Last Change: 2022/2/5
" License: this file is placed in the public domain

if exists("g:loaded_textobj")
	finish
endif
let g:loaded_textobj = 1

function! s:IndentBlock(ins)
	call textobj#IndentBlock(a:ins)
endfunction

function! s:FunctionBlock(ins)
	if exists("g:comment_str") && g:comment_str != -1
		call textobj#FunctionBlock(a:ins)
	endif
endfunction

" ----------- textobj mappings ------------

onoremap <silent> <plug>(textobj-o-ae)  :<C-u>normal! ggVG<CR>
vnoremap <silent> <plug>(textobj-v-ae)  :<C-u>normal! ggVG<CR>

onoremap <silent> <plug>(textobj-o-ii)  :<C-u>call <sid>IndentBlock('i')<CR>
vnoremap <silent> <plug>(textobj-v-ii)  :<C-u>call <sid>IndentBlock('i')<CR>
onoremap <silent> <plug>(textobj-o-ai)  :<C-u>call <sid>IndentBlock('a')<CR>
vnoremap <silent> <plug>(textobj-v-ai)  :<C-u>call <sid>IndentBlock('a')<CR>

onoremap <silent> <plug>(textobj-o-if)  :<C-u>call <sid>FunctionBlock('i')<CR>
vnoremap <silent> <plug>(textobj-v-if)  :<C-u>call <sid>FunctionBlock('i')<CR>
onoremap <silent> <plug>(textobj-o-af)  :<C-u>call <sid>FunctionBlock('a')<CR>
vnoremap <silent> <plug>(textobj-v-af)  :<C-u>call <sid>FunctionBlock('a')<CR>
