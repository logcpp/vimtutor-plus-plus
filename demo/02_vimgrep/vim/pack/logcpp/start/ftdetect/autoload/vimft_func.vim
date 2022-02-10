" Title: Vim Plugin - Ftdetect - autoload - Vim
" Author: logcpp
" Features: function definitions for Vim filetype
" Created On: 2022/1/31
" Last Change: 2022/1/31
" Initial Version: 2022/1/15
" -------------------- functions --------------------

function! s:VimFold()
	let line = getline(v:lnum)
	if match(line, '^endfunction') > -1
		return "<1"
	else
		let preline = getline(v:lnum-1)
		if match(preline, '^function') > -1
			return ">1"
		else
			return "-1"
		endif
	endif
endfunction

function! s:VimJoin()
	execute "normal! A |\<Esc>J"
endfunction

function! vimft_func#Vim_set()
	" format
	setlocal shiftwidth=4 tabstop=4

	" K for `:help`
	set keywordprg=:help

	" syntax highlighting
	hi Comment cterm=NONE ctermfg=252 ctermbg=NONE

	" key mappings for executing script
	nnoremap <leader><CR> :<C-r><C-l><CR><Esc>
	vnoremap <leader><CR> "zy:@z<CR>
	nnoremap <leader>J :call <sid>VimJoin()<CR>
	
	" filetype commands
	command! VimFold	setlocal foldmethod=expr foldexpr=<sid>VimFold()
endfunction

function! vimft_func#Vim_reset()
	set keywordprg=man
	silent! nunmap <leader><CR>
	silent! vunmap <leader><CR>
	silent! nunmap <leader>J
endfunction
