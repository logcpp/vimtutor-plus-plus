" Title: Vim Plugin - HybridCompletion - plugin
" Author: logcpp
" Version: 1.0
" Features: enabling multiple completion methods with a single key binding
" Created On: 2022/1/28
" Last Change: 2022/1/29
" License: this file is placed in the public domain

if exists("g:loaded_hcomp")
	finish
endif
let g:loaded_hcomp = 1

" default key definition, used if cursor on whitespace
if !exists("g:hcomp_defkey")
	let g:hcomp_defkey = "<Tab>"
endif

" --------------- functions ---------------

function! s:Add2Dict()
	call hcomp#Add2Dict()
endfunction

function! s:InitCompInfo()
	call hcomp#InitCompInfo()
	inoremap <sid>PreCmd x<BS>
endfunction

function! s:UpdateCompInfo()
	call hcomp#UpdateCompInfo()
endfunction

function! s:HCompMap()
	let l:map = hcomp#HComp(g:hcomp_defkey)
	" no match found
	if l:map == ""
		inoremap <sid>HCompCmd <Esc>gi
		inoremap <sid>PreCmd x<BS>
	" use default key binding
	elseif l:map == g:hcomp_defkey
		execute("inoremap <sid>HCompCmd ".g:hcomp_defkey)
		inoremap <sid>PreCmd x<BS>
	" match exists
	else
		execute("inoremap <sid>HCompCmd ".l:map)
		" clear menu before next completion when <plug>HComp is pressed again
		inoremap <sid>PreCmd <C-e>
	endif
	set completeopt=menu,preview
endfunction

function! s:HCompRst()
	inoremap <sid>PreCmd x<BS>
endfunction

" ------------ end of functions -----------

call <sid>InitCompInfo()
call <sid>HCompRst()
au! CompleteChanged	*	call <sid>UpdateCompInfo()
au! CompleteDone	*	call <sid>HCompRst()

" key mappings
imap <silent> <plug>HComp <sid>PreCmd<Esc>:call <sid>HCompMap()<CR>gi<sid>HCompCmd
nnoremap <silent> <plug>Dict :call <sid>Add2Dict()<CR>

imap <Tab> <plug>HComp
inoremap <S-Tab> <Tab>
nmap z<C-k> <plug>Dict 
