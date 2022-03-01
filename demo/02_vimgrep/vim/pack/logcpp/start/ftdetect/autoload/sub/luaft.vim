" Title: Vim Plugin - Ftdetect - autoload - Lua
" Author: logcpp
" Features: function definitions for Lua filetype
" Created On: 2022/2/25
" Last Change: 2022/2/28
" -------------------- functions --------------------

function! sub#luaft#Lua_set(dir)
	" dictionary for completion
	let l:dict_path = a:dir."dict/lua.dict"
	" enable <C-x><C-k> to complete words like "math.sin()"
	set iskeyword+=.
	execute "setlocal dictionary=" . l:dict_path

	nnoremap <leader><CR> :w \| !lua %<CR>
	vnoremap <leader><CR> :w !lua<CR>
endfunction

function! sub#luaft#Lua_reset()
	silent! nunmap <leader><CR>
	silent! vunmap <leader><CR>
endfunction
