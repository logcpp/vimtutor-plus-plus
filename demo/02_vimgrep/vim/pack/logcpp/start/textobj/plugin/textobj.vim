" Title: Vim Plugin - Text Object - plugin
" Author: logcpp
" Version: 1.0
" Features: definition of user text objects
" Created On: 2022/2/5
" Last Change: 2022/2/7
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

function! s:PairBlock(ins, char)
	call textobj#PairBlock(a:ins, a:char)
endfunction

function! s:CommentBlock(ins)
	if exists("g:comment_str") && g:comment_str != -1
		call textobj#CommentBlock(a:ins)
	endif
endfunction

" ----------- textobj mappings ------------

onoremap <silent> ae :<C-u>normal! ggVG<CR>
vnoremap <silent> ae :<C-u>normal! ggVG<CR>

onoremap <silent> ii :<C-u>call <sid>IndentBlock('i')<CR>
vnoremap <silent> ii :<C-u>call <sid>IndentBlock('i')<CR>
onoremap <silent> ai :<C-u>call <sid>IndentBlock('a')<CR>
vnoremap <silent> ai :<C-u>call <sid>IndentBlock('a')<CR>

onoremap <silent> if :<C-u>call <sid>FunctionBlock('i')<CR>
vnoremap <silent> if :<C-u>call <sid>FunctionBlock('i')<CR>
onoremap <silent> af :<C-u>call <sid>FunctionBlock('a')<CR>
vnoremap <silent> af :<C-u>call <sid>FunctionBlock('a')<CR>

onoremap <silent> i\| :<C-u>call <sid>PairBlock('i', "\|")<CR>
vnoremap <silent> i\| :<C-u>call <sid>PairBlock('i', "\|")<CR>
onoremap <silent> a\| :<C-u>call <sid>PairBlock('a', "\|")<CR>
vnoremap <silent> a\| :<C-u>call <sid>PairBlock('a', "\|")<CR>

onoremap <silent> i* :<C-u>call <sid>PairBlock('i', "*")<CR>
vnoremap <silent> i* :<C-u>call <sid>PairBlock('i', "*")<CR>
onoremap <silent> a* :<C-u>call <sid>PairBlock('a', "*")<CR>
vnoremap <silent> a* :<C-u>call <sid>PairBlock('a', "*")<CR>

onoremap <silent> ic :<C-u>call <sid>CommentBlock('i')<CR>
vnoremap <silent> ic :<C-u>call <sid>CommentBlock('i')<CR>
onoremap <silent> ac :<C-u>call <sid>CommentBlock('a')<CR>
vnoremap <silent> ac :<C-u>call <sid>CommentBlock('a')<CR>
