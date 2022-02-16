" Title: Vim Plugin - Ftdetect - autoload - Git
" Author: logcpp
" Features: function definitions for Git filetype
" Created On: 2022/1/31
" Last Change: 2022/2/6
" -------------------- functions --------------------

function! s:Gitdiff()
	let l:s = synID(line('.'), col('.'), 1)
	if synIDattr(l:s, 'name') == "gitHash"
		let l:githash = expand("<cword>")
		execute 'vnew +r\ !git\ diff\ '.l:githash.'\ '.s:p_githash
		execute "1d \| set filetype=git"
		let s:p_githash = l:githash
	endif
endfunction

function! sub#gitft#Gitft_set()
	" highlight of `git diff`
	hi diffAdded cterm=NONE ctermfg=lightgreen ctermbg=NONE
	hi diffRemoved cterm=NONE ctermfg=203 ctermbg=NONE
	hi diffLine cterm=NONE ctermfg=yellow ctermbg=NONE
	hi diffSubname cterm=NONE ctermfg=lightblue ctermbg=NONE
	hi gitDiff cterm=NONE ctermfg=lightgray ctermbg=NONE
	hi diffFile cterm=NONE ctermfg=white ctermbg=NONE
	hi diffNewFile cterm=NONE ctermfg=white ctermbg=NONE
	hi diffIndexLine cterm=underline,bold ctermfg=cyan ctermbg=NONE
	" highlight of `git log`
	hi gitKeyword cterm=NONE ctermfg=yellow ctermbg=NONE
	hi gitIdentityHeader cterm=NONE ctermfg=yellow ctermbg=NONE
	hi gitDateHeader cterm=NONE ctermfg=yellow ctermbg=NONE
	hi gitHash cterm=NONE ctermfg=lightgreen ctermbg=NONE
	hi gitIdentity cterm=NONE ctermfg=lightred ctermbg=NONE
	hi gitEmailDelimiter cterm=NONE ctermfg=207 ctermbg=NONE
	hi gitEmail cterm=NONE ctermfg=207 ctermbg=NONE
	hi gitDate cterm=NONE ctermfg=blue ctermbg=NONE

	" key mapping
	nnoremap <silent> <leader><CR>	:call <sid>Gitdiff()<CR>

	" previous git hash
	if !exists("s:p_githash")
		let s:p_githash = ""
	endif
endfunction

function! sub#gitft#Gitft_reset()
	silent! nunmap <leader><CR>
endfunction
