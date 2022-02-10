" Title: Vim Plugin - HybridCompletion - autoload
" Author: logcpp
" Version: 1.0
" Features: enabling multiple completion methods with a single key binding
" Created On: 2022/1/28
" Last Change: 2022/2/1
" Licensse: this file is placed in the public domain

" -------------- s:functions --------------

function! s:NextItem(st, end, i, di)
	if a:i < a:st || a:i > a:end | return a:st | endif
	if a:di > 0
		let l:res = a:i == a:end ? 0 : a:i+1
	else
		let l:res = a:i == 0 ? a:end : a:i-1
	endif
	return l:res
endfunction

function! s:ExeKey(cmd)
	let s:detect = 1
	silent! execute("silent! normal! gi".a:cmd."\<Esc>")
	let s:detect = 0
endfunction

function! s:GetCurchar()
	let l:pos = getcurpos()
	let [l:linenr, l:colnr] = l:pos[1:2]
	let l:char = getline(l:linenr)[l:colnr-1]
	return l:char
endfunction

" ------------ hcomp#functions ------------

function! hcomp#Add2Dict()
	let l:dict = expand(&dictionary)
	if l:dict == "" | return | endif
	let cword = expand("<cword>")
	execute "redir >> " . l:dict
		echo l:cword
	redir END
	" organize words in dictionary
	execute "w|e " . l:dict
	silent g/^$/d | sort | w
	bd
	echomsg "added '".l:cword."' to dictionary: ".l:dict
endfunction

function! hcomp#InitCompInfo()
	" flag for ExeKey detection
	let s:detect = 0
	let s:pre_compinfo = {}
	let s:new_compinfo = {}
	let s:comp_info = [-1, 0, getcurpos(), s:GetCurchar()]
	" s:comp_info = [found, i, getcurpos(), 'x'] <= last completion information
	" found: 0=not_found, 1=found, -1=initial_value
endfunction

function! hcomp#UpdateCompInfo()
	" completion not by ExeKey() => no need for detection => do not change completion info
	if s:detect == 0 | return | endif
	" update completion info history
	let s:new_compinfo = complete_info()
endfunction

" s:comp_info = [i, getcurpos()] <= last completion information
" Insert mode completion list: (See |ins-completion|)
"	 keywords in 'dictionary'						|i_CTRL-X_CTRL-K|			Dictionary completion
"	 keywords in the current file					|i_CTRL-X_CTRL-N|			Keyword Local completion
"	 definitions or macros							|i_CTRL-X_CTRL-D|			Definition completion
"	 keywords in the current and included files		|i_CTRL-X_CTRL-I|			Path pattern completion
"	 Vim command-line								|i_CTRL-X_CTRL-V|			Command-line completion
"	 file names										|i_CTRL-X_CTRL-F|			File name completion
"	 tags											|i_CTRL-X_CTRL-]|			Tag completion
"	 Spelling suggestions							|i_CTRL-X_s|				Spelling suggestion
"	 keywords in 'complete'							|i_CTRL-N| |i_CTRL-P|		Keyword completion
" not used:
"	 Whole lines									|i_CTRL-X_CTRL-L|
"	 keywords in 'thesaurus', thesaurus-style		|i_CTRL-X_CTRL-T|
"	 User defined completion						|i_CTRL-X_CTRL-U|
"	 omni completion								|i_CTRL-X_CTRL-O|
function! hcomp#HComp(default_key)
	set completeopt=menuone,noinsert

	" list of completion methods in the priority order
	let l:cmd_list = ["\<C-x>\<C-k>", "\<C-x>\<C-n>", "\<C-x>\<C-d>", "\<C-x>\<C-i>", "\<C-x>\<C-v>",  "\<C-x>\<C-f>",  "\<C-x>\<C-]>",  "\<C-x>s", "\<C-n>"]
	let l:map_list = [  "<C-x><C-k>",   "<C-x><C-n>",   "<C-x><C-d>",   "<C-x><C-i>",   "<C-x><C-v>",    "<C-x><C-f>",    "<C-x><C-]>",   "<C-x>s",  "<C-n>"]
	let l:end_method = len(l:cmd_list) - 1

	let l:last_found  = s:comp_info[0]
	let l:last_method = s:comp_info[1]
	let l:last_pos    = s:comp_info[2]
	let l:last_char   = s:comp_info[3]

	let l:cur_pos = getcurpos()
	let l:cur_char = s:GetCurchar()

	" insert <Tab> when the current character is 'NULL' or non-word, or when the cursor at the first column
	if l:cur_char == "" || match(l:cur_char, '\v(\W&[^\/])') > -1 || l:cur_pos[2] == 1
		return a:default_key
	endif

	" initial completion
	if l:last_found == -1
		let l:i = 0
	" no found match
	elseif l:last_found == 0
		let s:comp_info = [1, l:last_method, l:cur_pos, l:cur_char]
		return a:default_key
	" word has changed from the last completion => inherit previous completion method
	elseif l:last_pos != l:cur_pos || l:last_char != l:cur_char
		let l:i = l:last_method
	" stay on the same word finding expected match => try from next item of l:cmd_list
	else 
		let l:i = s:NextItem(0, l:end_method, l:last_method, +1)
	endif

	" if it's a path pattern (ends with '/'), then use <C-x><C-f>
	"if l:cur_char == "/" | let l:i = index(l:cmd_list, "\<C-x>\<C-f>") | endif
	" find for matching completion method
	let l:end = s:NextItem(0, l:end_method, l:i, -1)
	while l:i != l:end
		let l:cmd = l:cmd_list[l:i]
		" if no dictionary file, skip <C-x><C-k>
		if l:cmd == "\<C-x>\<C-k>" && &dictionary == ""
			:
		" if set option is set 'nospell', skip <C-x>s
		elseif l:cmd == "\<C-x>s" && &spell == 0
			:
		else
			silent! call s:ExeKey(l:cmd)
			" find match during completion commands == completion state changed 
			if s:pre_compinfo != s:new_compinfo || l:last_found == 1 && l:last_method == l:i
				let s:pre_compinfo = s:new_compinfo
				let s:comp_info = [1, l:i, l:cur_pos, l:cur_char]
				return l:map_list[l:i]
			endif
		endif

		" update l:i to loop in listed methods
		"if l:i < l:end_method | let l:i += 1 | else | let l:i = 0 | endif
		let l:i = s:NextItem(0, l:end_method, l:i, +1)
	endwhile

	" no matching completion method
	let s:comp_info = [0, l:last_method, l:cur_pos, l:cur_char]
	return ""
endfunction
