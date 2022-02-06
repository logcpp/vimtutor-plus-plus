" Title: Vim Plugin - Vim Slides - autoload
" Author: logcpp
" Version: 1.0
" Features: enables presentation mode in the current buffer 
" Created On: 2022/1/30
" Last Change: 2022/1/30
" Initial Version: 0.0 (created on: 2022/1/23)
" License: this file is placed in the public domain

" Index:
"	slide#InitSlide() -> Initialize s:mode and s:history variables
"   slide#SyncGroup() -> return group_name
"
"	s:Hist_Push(item) -> push <item> as the last item to s:history
"	s:Hist_Pop() -> remove the last item from s:history, if len>=1, return the last item, if len==0 return -1
"   s:CurPageNr() -> return the current page number, g:slide_height will be used as the height of slides
"   s:NextPageNr() -> return the next page number, if at the last page, return the last page number
"   s:PrevPageNr() -> return the previous page number, if at the first page (0), return 0
"   s:FixPage(page) -> fix screen to the page <page>
"
"	slide#NextPage() -> go to the next page, fixing page
"	slide#PrevPage() -> go to the previous page, fixing page
"   slide#NextLine() -> go to the next non-blank line, fixing page
"   slide#PrevLine() -> go to the previous non-blank line, fixing page
"   slide#PageInfo() -> echo information about the current page
"	slide#JumpPage(page) -> push the current page number to s:history, then jump to the page <page>
"	silde#JumpBack() -> pop the last jumped page from s:history, jump to the page, if it's the last page, show "already at the oldest page"

" initialization
function! slide#InitSlide()
	let s:history = []
endfunction

" check the highlight group under cursor, only for editing
function! slide#SynGroup()
	let l:s = synID(line('.'), col('.'), 1)
	echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
endfunction

" push to history stack
function! s:Hist_Push(item)
	call add(s:history, a:item)
endfunction

" pop from history stack, return the popped item
function! s:Hist_Pop()
	if len(s:history) == 0
		return -1
	elseif len(s:history) == 1
		let l:item = s:history[0]
		let s:history = []
	else
		let l:item = s:history[len(s:history)-1]
		let s:history = s:history[:len(s:history)-2]
	endif
	return l:item
endfunction

" return the current page number
function! s:CurPageNr()
	return line(".") / g:slide_height
endfunction

" return the next top line, if at the end of file, do nothing
function! s:NextPageNr()
	let l:next = s:CurPageNr() + 1
	let l:last = line('$') / g:slide_height
	return min([l:next, l:last])
endfunction

" return the previous top line, if at the beginning of file, do nothing
function! s:PrevPageNr()
	let l:prev = s:CurPageNr() - 1
	return max([l:prev, 0])
endfunction

" fix screen to the page
function! s:FixPage(page)
	 execute(a:page * g:slide_height + 1)
	 execute("normal zt")
endfunction

" go to the next page
function! slide#NextPage()
	call s:FixPage(s:NextPageNr())
endfunction

" go to the previous page
function! slide#PrevPage()
	call s:FixPage(s:PrevPageNr())
endfunction

" go to the next non-blank line
" if get across the page, shift screen
function! slide#NextLine()
	let l:prepage = s:CurPageNr()
	let @/ = "\\v^\\W*\\zs\\w"
	execute("silent! normal n")
	let l:curpage = s:CurPageNr()
	if l:curpage > l:prepage
		execute("normal mz")
		call s:FixPage(s:CurPageNr())
		execute("normal `z")
	endif
endfunction

" go to the previous non-blank line
" if get across the page, shift screen
function! slide#PrevLine()
	let l:prepage = s:CurPageNr()
	let @/ = "\\v^\\W*\\zs\\w"
	execute("silent! normal N")
	let l:curpage = s:CurPageNr()
	if l:curpage < l:prepage
		execute("normal mz")
		call s:FixPage(s:CurPageNr())
		execute("normal `z")
	endif
endfunction

" output page info
function! slide#PageInfo()
	"let l:last = line("$") / g:slide_height
	"echo "Page: " . s:CurPageNr() . "/" . l:last
	echo s:CurPageNr()
endfunction

" jump to the given page and add to history
function! slide#JumpPage(page)
	call s:Hist_Push(s:CurPageNr())
	call s:FixPage(a:page)
endfunction

" jump back to the last page in history
function! slide#JumpBack()
	let l:last_page = s:Hist_Pop()
	if l:last_page > -1
		call s:FixPage(l:last_page)
	else
		echomsg "already at the oldest page"
		return -1
	endif
endfunction
