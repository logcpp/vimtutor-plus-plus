" Title: Vim Plugin - Ftdetect - autoload - HTML
" Author: logcpp
" Features: function definitions for HTML filetype
" Created On: 2022/2/6
" Last Change: 2022/2/8
" Initial Version: 2021/9/?
" -------------------- functions --------------------

function! s:Base()
	let l:base = s:dir."src/html/base.html"
	execute "0r ".l:base
	$d
	normal 6Gcit
endfunction

function! sub#htmlft#Html_set(dir)
	" format
	setlocal shiftwidth=2 tabstop=2

	" keymappings
	"nnoremap <leader>\ cit

	" highlightings
	hi Comment cterm=NONE ctermfg=252 ctermbg=NONE

	" package for tags in HTML
	filetype plugin on
	packadd matchit
	filetype detect

	" HTML Format Skeleton
	let s:dir = a:dir
	command! Base call <sid>Base()
endfunction

function! sub#htmlft#Html_reset()
	silent! delcommand Base
endfunction
