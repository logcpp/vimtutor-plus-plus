" Title: Vim Plugin - Foldmode - autoload
" Author: logcpp
" Version: 1.0
" Features: toggle 'z' for easy navigation of foldings
" Created On: 2022/1/28
" Last Change: 2022/1/28
" Initial Version: 0.0 (created on: 2022/1/15)
" License: this file is placed in the public domain

function! s:Foldmsg()
	echohl ModeMsg
		echo "-- Fold --"
	echohl None
endfunction

function! s:Foldoff()
	" reset non-z mappings
	nnoremap <buffer> f f
	nnoremap <buffer> d d
	nnoremap <buffer> o o
	nnoremap <buffer> c c
	nnoremap <buffer> a a
	nnoremap <buffer> v v
	nnoremap <buffer> x x
	nnoremap <buffer> m m
	nnoremap <buffer> r r
	nnoremap <buffer> n n
	nnoremap <buffer> i i

	nnoremap <buffer> F F
	nnoremap <buffer> D D
	nnoremap <buffer> E E
	nnoremap <buffer> O O
	nnoremap <buffer> C C
	nnoremap <buffer> A A
	nnoremap <buffer> X X
	nnoremap <buffer> M M
	nnoremap <buffer> R R
	nnoremap <buffer> N N

	nnoremap <buffer> j j
	nnoremap <buffer> k k

	nnoremap <buffer> <esc> <esc>

	" reset z mappings
	nnoremap <buffer> zf zf
	nnoremap <buffer> zd zd
	nnoremap <buffer> zo zo
	nnoremap <buffer> zc zc
	nnoremap <buffer> za za
	nnoremap <buffer> zv zv
	nnoremap <buffer> zx zx
	nnoremap <buffer> zm zm
	nnoremap <buffer> zr zr
	nnoremap <buffer> zn zn
	nnoremap <buffer> zi zi

	nnoremap <buffer> zF zF
	nnoremap <buffer> zD zD
	nnoremap <buffer> zE zE
	nnoremap <buffer> zO zO
	nnoremap <buffer> zC zC
	nnoremap <buffer> zA zA
	nnoremap <buffer> zX zX
	nnoremap <buffer> zM zM
	nnoremap <buffer> zR zR
	nnoremap <buffer> zN zN

	nnoremap <buffer> zj zj
	nnoremap <buffer> zk zk
endfunction

function! foldmode#Foldon()
	" Fold mode mappings
	nnoremap <buffer> f zf
	nnoremap <buffer> d zd:call <sid>Foldmsg()<CR>
	nnoremap <buffer> o zo:call <sid>Foldmsg()<CR>
	nnoremap <buffer> c zc:call <sid>Foldmsg()<CR>
	nnoremap <buffer> a za:call <sid>Foldmsg()<CR>
	nnoremap <buffer> v zv:call <sid>Foldmsg()<CR>
	nnoremap <buffer> x zx:call <sid>Foldmsg()<CR>
	nnoremap <buffer> m zm:call <sid>Foldmsg()<CR>
	nnoremap <buffer> r zr:call <sid>Foldmsg()<CR>
	nnoremap <buffer> n zn:call <sid>Foldmsg()<CR>
	nnoremap <buffer> i zi:call <sid>Foldmsg()<CR>

	nnoremap <buffer> F zF
	nnoremap <buffer> D zD:call <sid>Foldmsg()<CR>
	nnoremap <buffer> E zE:call <sid>Foldmsg()<CR>
	nnoremap <buffer> O zO:call <sid>Foldmsg()<CR>
	nnoremap <buffer> C zC:call <sid>Foldmsg()<CR>
	nnoremap <buffer> A zA:call <sid>Foldmsg()<CR>
	nnoremap <buffer> X zX:call <sid>Foldmsg()<CR>
	nnoremap <buffer> M zM:call <sid>Foldmsg()<CR>
	nnoremap <buffer> R zR:call <sid>Foldmsg()<CR>
	nnoremap <buffer> N zN:call <sid>Foldmsg()<CR>

	nnoremap <buffer> j zjzz:call <sid>Foldmsg()<CR>
	nnoremap <buffer> k zkzz:call <sid>Foldmsg()<CR>

	nnoremap <buffer> <Esc> :call <sid>Foldoff()<CR>:echo ""<CR>

	" non-Fol<buffer> d mode mappings
	nnoremap <buffer> zf f
	nnoremap <buffer> zd d
	nnoremap <buffer> zo o
	nnoremap <buffer> zc c
	nnoremap <buffer> za a
	nnoremap <buffer> zv v
	nnoremap <buffer> zx x
	nnoremap <buffer> zm m
	nnoremap <buffer> zr r
	nnoremap <buffer> zn n
	nnoremap <buffer> zi i

	nnoremap <buffer> zF F
	nnoremap <buffer> zD D
	nnoremap <buffer> zE E
	nnoremap <buffer> zO O
	nnoremap <buffer> zC C
	nnoremap <buffer> zA A
	nnoremap <buffer> zX X
	nnoremap <buffer> zM M
	nnoremap <buffer> zR R
	nnoremap <buffer> zN N

	nnoremap <buffer> zj j
	nnoremap <buffer> zk k

	" printout mode name
	call s:Foldmsg()
endfunction
