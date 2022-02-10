" Title: Vim Plugin - Myvimrc - plugin
" Author:logcpp
" Version: 1.0
" Features: jumping between tags located in .vim/**/*.vim files
" Created On: 2022/1/27
" Last Change: 2022/2/3
" Initial Version: 0.0 (created on: 2022/1/18)
" License: this file is placed in the public domain

if exists("g:loaded_myvimrc")
	finish
endif
let g:loaded_myvimrc = 1

function! s:SID()
	" get the <sid> number of this plugin
	return matchstr(expand('<sfile>'), '<SNR>\zs\d\+\ze_SID$')
endfunction

function! s:Get_sfile()
	" get the path to this plugin
	let l:script_num = s:SID()
	let l:script_list = execute("scriptnames")
	" <sid>: ~/.vim/pack/logcpp/opt/myvimrc/plugin/myvimrc.vim
	return matchstr(l:script_list, l:script_num . ':\s\zs.*')
endfunction

" file path to the "mytags" file = $HOME/.vim/.../myvimrc/mytags
let s:path_to_mytags = s:Get_sfile()[0:-19] . "mytags"

function! s:Gen_Mytag()
	call gen_mytags#Gen_Mytag(s:path_to_mytags)
endfunction

function! s:Find_Mytag()
	call find_mytag#Find_Mytag(s:path_to_mytags)
endfunction


" definition of commands
command! GenMytag	call <sid>Gen_Mytag()

" definition of keymappings
nnoremap	<sid>FindMytag			:call <sid>Find_Mytag()<CR>
nmap		<plug>(myvimrc-findmytag)	<sid>FindMytag

nnoremap	<plug>(myvimrc-jumpback)	`T

" add the following script to you .vimrc:
" 	nmap <leader><C-]>	<plug>(myvimrc-findmytag)
"	nmap <leader><C-t>	<plug>(myvimrc-jumpback)
