" Title: Vim Plugin - Ftdetect - autoload - TeX
" Author: logcpp
" Features: function definitions for Vim filetype
" Created On: 2022/1/31
" Last Change: 2022/2/28
" Initial Version: 2021/9
" -------------------- functions --------------------

function! s:Base()
	let l:base = s:dir."src/tex/base.tex"
	execute "0r ".l:base
	$d
	normal 6Gf}
endfunction

function! s:TexFold()
	let l:line = getline(v:lnum)
	if match(l:line, '\\begin{.*}') > -1
		return "a1"
	elseif match(l:line, '\\end{.*}') > -1
		return "s1"
	else
		return "="
	endif
endfunction

function! s:TexFigure()
	let @a = '\begin{figure}[ht]' | put a
	let @a = '\centering' | put a
	let @a = '\includegraphics[width=\linewidth]{}' | put a
	let @a = '\caption{}' | put a
	let @a = '\label{}' | put a
	let @a = '\end{figure}' | put a
	.-5,. normal ==
	.-4,.-1 >
	normal 2kf}:
endfunction

function! s:TexEnumerate()
	let l:n = str2nr(input("Input number of items: "))
	" no input => do nothing
	if l:n == 0 
		normal : 
		return 
	endif
	let @a = '\begin{enumerate}' | put a
	let @a = '\item[]' 
	for l:i in range(l:n)
		 put a
	endfor
	let @a = '\end{enumerate}' | put a
	execute ".-".(l:n+1).",. normal =="
	execute ".-".l:n.",.-1 >"
	execute "normal ".(l:n-1)."kf]:"
endfunction

function! sub#texft#Tex_set(dir)
	" format
	setlocal shiftwidth=4 tabstop=4

	" dictionary for completion
	let s:dir = a:dir
	let l:dict_path = s:dir."dict/tex.dict"
	execute "setlocal dictionary=" . l:dict_path

	" key mappings
	nnoremap <silent> <leader>; /\v\{[^\}]*\}<CR>:noh<CR>f}
	nnoremap <silent> <leader>p :!if [ -e *.pdf ]; then evince *.pdf; fi &<CR><CR>
	" snippets 
	inoremap \f \frac{}{}<Esc>F}i
	inoremap \i \int_{}^{}<Esc>F_la
	inoremap \S \sum_{}^{}<Esc>F_la
	" Greek letters
	inoremap \lm \lambda
	inoremap \vp \varphi
	inoremap \ve \varepsilon
	" block
	inoremap FIG <Esc>:TexFigure<CR>
	inoremap ENU <Esc>:TexEnumerate<CR>

	" enable matchit plugin (default)
	packadd matchit
	let b:match_words="begin:end"

	" self-defined commands
	command! Base			call <sid>Base()
	command! TexFold		setlocal foldmethod=expr foldexpr=<sid>TexFold()
	command! TexFigure		call <sid>TexFigure()
	command! TexEnumerate   call <sid>TexEnumerate()
endfunction

function! sub#texft#Tex_reset()
	silent! nunmap <leader>;
	silent! iunmap \f
	silent! iunmap \i
	silent! iunmap \S
	silent! iunmap \lm
	silent! iunmap \vp
	silent! iunmap \ve

	silent! delcommand Base
	silent! delcommand TexFold
	silent! delcommand TexFigure
	silent! delcommand TexEnumerate
endfunction
