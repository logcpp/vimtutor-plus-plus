" Title: Vim Plugin - Ftdetect - autoload - TeX
" Author: logcpp
" Features: function definitions for Vim filetype
" Created On: 2022/1/31
" Last Change: 2022/2/2
" Initial Version: 2021/9
" -------------------- functions --------------------

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
	normal 2kf}
endfunction

function! s:TexEnumerate(n)
	let @a = '\begin{enumerate}' | put a
	let @a = '\item[]' 
	for l:i in range(a:n)
		 put a
	endfor
	let @a = '\end{enumerate}' | put a
	execute ".-".(a:n+1).",. normal =="
	execute ".-".a:n.",.-1 >"
	execute "normal ".(a:n-1)."kf]"
endfunction

function! texft_func#Tex_set(dir)
	" format
	set shiftwidth=4 tabstop=4

	" dictionary for completion
	let l:dict_path = a:dir."dict/tex"
	execute "setlocal dictionary=" . l:dict_path

	" key mappings
	nnoremap <silent> <leader>; /\v\{[^\}]*\}<CR>:noh<CR>f}
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
	inoremap ENU <Esc>:TexEnumerate 

	" enable matchit plugin (default)
	packadd matchit
	let b:match_words="begin:end"

	" self-defined commands
	command! TexFold	setlocal foldmethod=expr foldexpr=<sid>TexFold()
	command! TexFigure	call <sid>TexFigure()
	command! -nargs=1   TexEnumerate   call <sid>TexEnumerate(<f-args>)
endfunction

function! texft_func#Tex_reset()
	silent! nunmap <leader>;
	silent! iunmap \f
	silent! iunmap \i
	silent! iunmap \S
	silent! iunmap \lm
	silent! iunmap \vp
	silent! iunmap \ve

	silent! delcommand TexFold
	silent! delcommand TexFigure
endfunction
