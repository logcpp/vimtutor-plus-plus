" Title: Vim Plugin - Ftdetect - autoload - Rust
" Author: logcpp
" Features: function definitions for Rust filetype
" Created On: 2022/2/28
" Last Change: 2022/2/28
" -------------------- functions --------------------

" fold block like: fn main() \n { \n ... \n }
" originally created in sub/cft.vim
function! s:CFold()
	let line = getline(v:lnum)
	if match(line, '^{$') > -1
		return ">1"
	elseif match(line, '^}') > -1
		return "<1"
	else
		return "-1"
	endif
endfunction

" fold block like: fn main(){ \n ... \n }
" originally created in sub/cft.vim
function! s:CFoldAlter()
	let line = getline(v:lnum)
	if match(line, '^}') > -1
		return "<1"
	else
		let preline = getline(v:lnum-1)
		if match(preline, '^\S\+.*{$') > -1
			return ">1"
		else
			return "-1"
		endif
	endif
endfunction

" run compiled binary file by `make`
" originally created in sub/cft.vim
function! s:CRun()
	let l:b_list = split(system("find . -executable -type f"), '\n')
	if len(l:b_list) > 0
		for l:binfile in l:b_list
			echo "found binary files: " . string(l:b_list)
			if l:binfile == ""
				echoerr "Self Err: no binary file is found, abort running"
				return
			endif
			let l:choice = confirm("Run binary file '".l:binfile."' ?", "Yes\nNo\nCancel")
			if l:choice == 1
				execute "!" . l:binfile 
			endif
			redraw
		endfor
	else
		echo "no executable files found, abort"
	endif
endfunction

" main function of settings @ BufEnter
function! sub#rustft#Rust_set()
	" format
	setlocal shiftwidth=4 tabstop=4

	" error format
	setlocal errorformat=%*[\ ]-->\ %f:%l:%c

	" key mappings
	nnoremap <silent> <leader><CR>	:<C-u>call <sid>CRun()<CR>
	nnoremap <buffer> <silent> <leader>\ :w<CR>:make<CR><Esc>:botright copen 10<CR><C-w>p

	" filetype commands
	command! CFold 			setlocal foldmethod=expr foldexpr=<sid>CFold()
	command! CFoldAlter		setlocal foldmethod=expr foldexpr=<sid>CFoldAlter()
endfunction

" main function of resettings @ BufLeave
function! sub#rustft#Rust_reset()
	silent! nunmap <leader><CR>
	silent! delcommand CFold
	silent! delcommand CFoldAlter
endfunction
