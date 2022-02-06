" Title: Vim Plugin - Vim Slides - plugin
" Author: logcpp
" Version: 1.0
" Features: enables presentation mode in the current buffer
" Created On: 2022/1/30
" Last Change: 2022/2/2
" Initial Version: 0.0 (created on: 2022/1/23)
" License: this file is placed in the public domain

" global variables used in autoload
let g:slide_mode = ''
let g:slide_height = 22

" --------------- functions ---------------

function! s:InitSlide()
	call slide#InitSlide()
endfunction
call s:InitSlide()

function! s:SynGroup()
	call slide#SynGroup()
endfunction

function! s:NextPage()
	call slide#NextPage()
endfunction

function! s:PrevPage()
	call slide#PrevPage()
endfunction

function! s:NextLine()
	call slide#NextLine()
endfunction

function! s:PrevLine()
	call slide#PrevLine()
endfunction

function! s:PageInfo()
	call slide#PageInfo()
endfunction

function! s:JumpPage(page)
	call slide#JumpPage(a:page)
	call slide#PageInfo()
endfunction

function! s:JumpBack()
	let l:res = slide#JumpBack()
	if l:res != -1
		call slide#PageInfo()
	endif
endfunction

" get into annotation mode
function! s:Annot()
	let g:slide_mode='annot'
	setlocal nonumber
	setlocal noreadonly modifiable
	setlocal colorcolumn=0
	nnoremap <plug>(slide-prevpage_key) h
	nnoremap <plug>(slide-nextline_key) j
	nnoremap <plug>(slide-prevline_key) k
	nnoremap <plug>(slide-nextpage_key) l
endfunction

" get into editing mode
function! s:Edit()
	let g:slide_mode='edit'
	setlocal number
	setlocal noreadonly modifiable
	setlocal colorcolumn=7,19,40
	nnoremap <plug>(slide-prevpage_key) h
	nnoremap <plug>(slide-nextline_key) j
	nnoremap <plug>(slide-prevline_key) k
	nnoremap <plug>(slide-nextpage_key) l
endfunction

" get into presentation mode
function! s:Show()
	let g:slide_mode='show'
	setlocal nonumber
	setlocal readonly nomodifiable
	setlocal colorcolumn=0
	nnoremap <silent> <plug>(slide-prevpage_key) :BACK<CR>
	nnoremap <silent> <plug>(slide-nextline_key) :NEXT<CR>
	nnoremap <silent> <plug>(slide-prevline_key) :PREV<CR>
	nnoremap <silent> <plug>(slide-nextpage_key) :GO<CR>
endfunction

" toggle annotation/presentation mode
function! s:ToggleAnnot()
	if g:slide_mode == 'show' 
		call s:Annot() 
	elseif g:slide_mode == 'annot' 
		call s:Show() 
	endif
endfunction

" ------------ end of functions -----------

" general options
syntax enable
setlocal nonumber
setlocal syntax=vim
setlocal background=dark
setlocal notimeout ttimeout ttimeoutlen=0
setlocal nobackup noswapfile
setlocal tabstop=4 shiftwidth=4 expandtab
setlocal ignorecase smartcase incsearch nohlsearch
setlocal noerrorbells visualbell t_vb=
setlocal nowrap nowrapscan
execute "resize " . g:slide_height

" highlightings
hi CursorLine cterm=NONE ctermfg=NONE ctermbg=NONE
hi Visual cterm=NONE ctermfg=black ctermbg=191
hi Comment cterm=NONE ctermfg=253 ctermbg=NONE
hi VimCommentTitle cterm=bold,underline ctermfg=81 ctermbg=NONE
hi ColorColumn cterm=NONE ctermfg=NONE ctermbg=235

" wrapped commands
command! GO    call <sid>NextPage()
command! BACK  call <sid>PrevPage()
command! NEXT  call <sid>NextLine()
command! PREV  call <sid>PrevLine()
command! PAGE  call <sid>PageInfo()
command! -nargs=1 JUMP call <sid>JumpPage(<f-args>)
command! LAST  call <sid>JumpBack()

command! START call <sid>Show()
command! END   call <sid>Edit()
command! ANNOT call <sid>ToggleAnnot()

" <plug> key mappings
function! s:Map(plug_key, sid_key, map_str)
	execute "nnoremap ".a:sid_key." ".a:map_str
	execute "nmap ".a:plug_key." ".a:sid_key
endfunction

call s:Map("<plug>(slide-start)", "<sid>StartSlide", ":START<CR>")
call s:Map("<plug>(slide-nextpage)", "<sid>NextPage", ":GO<CR>:PAGE<CR>")
call s:Map("<plug>(slide-prevpage)", "<sid>PrevPage", ":BACK<CR>:PAGE<CR>")
call s:Map("<plug>(slide-nextline)", "<sid>NextLine", ":NEXT<CR>:PAGE<CR>")
call s:Map("<plug>(slide-prevline)", "<sid>PrevLine", ":PREV<CR>:PAGE<CR>")
call s:Map("<plug>(slide-pageinfo)", "<sid>PageInfo", ":PAGE<CR>")
call s:Map("<plug>(slide-toggleannot)", "<sid>ToggleAnnot", ":ANNOT<CR>")

" user key mappings (Feel free to modify them as you like!)
nmap <buffer> <Left>			<plug>(slide-prevpage)
nmap <buffer> <Down>			<plug>(slide-nextline)
nmap <buffer> <Up>				<plug>(slide-prevline)
nmap <buffer> <Right>			<plug>(slide-nextpage)

nmap <buffer> <C-j>				<plug>(slide-nextpage)
nmap <buffer> <C-k>				<plug>(slide-prevpage)

nmap <buffer> <C-g>				<plug>(slide-pageinfo)
nmap <buffer> <silent> <C-a>	<plug>(slide-toggleannot)

nmap <buffer> h					<plug>(slide-prevpage_key)
nmap <buffer> j					<plug>(slide-nextline_key)
nmap <buffer> k					<plug>(slide-prevline_key)
nmap <buffer> l					<plug>(slide-nextpage_key)

nmap <buffer> <F5> 				<plug>(slide-start)

"START
END
