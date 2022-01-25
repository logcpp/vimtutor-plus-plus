" "Settings for Vimtutor++ Slides"
" Created On: 2022/1/23
" Last Change: 2022/1/24
"
" Subscript: Functions

" Index:
"   SyncGroup() -> group_name
"   CurPage(height) -> page
"   NextPage(height) -> page
"   PrevPage(height) -> page
"   FixPage(page)
"   NextLine()
"   PrevLine()
"   PageInfo()
"   Annot()
"   Edit()
"   Show()


" check the highlight group under cursor, only for editing
function! SynGroup()
 let l:s = synID(line('.'), col('.'), 1)
 echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
endfunction

" return current page number
function! CurPage(height)
 return line(".") / a:height
endfunction

" return the next top line, if at the end of file, do nothing
function! NextPage(height)
 let l:next = CurPage(a:height) + 1
 let l:last = line('$') / a:height
 return min([l:next, l:last])
endfunction

" return the prev top line, if at the beginning of file, do nothing
function! PrevPage(height)
 let l:prev = CurPage(a:height) - 1
 return max([l:prev, 0])
endfunction

" fix screen to the page
function! FixPage(page)
  execute(a:page * 24 + 1)
  execute("normal zt")
endfunction

" go to next non-blank line
" if get across the page, shift screen
function! NextLine()
 let l:prepage = CurPage(24)
 let @/ = "\\v^\\W*\\zs\\w"
 execute("silent! normal n")
 let l:curpage = CurPage(24)
 if l:curpage > l:prepage
  execute("normal mz")
  call FixPage(CurPage(24))
  execute("normal `z")
 endif
endfunction

" go to previous non-blank line
" if get across the page, shift screen
function! PrevLine()
 let l:prepage = CurPage(24)
 let @/ = "\\v^\\W*\\zs\\w"
 execute("silent! normal N")
 let l:curpage = CurPage(24)
 if l:curpage < l:prepage
  execute("normal mz")
  call FixPage(CurPage(24))
  execute("normal `z")
 endif
endfunction

" output page info
function! PageInfo()
 let l:last = line("$") / 24
 "echo "Page: " . CurPage(24) . "/" . l:last
 echo CurPage(24)
endfunction


" get into annotation mode
function! Annot()
 let g:mode='annot'
 set nonumber
 set noreadonly modifiable
 set colorcolumn=0
 nnoremap h h
 nnoremap j j
 nnoremap k k
 nnoremap l l
endfunction

" get into editing mode
function! Edit()
 let g:mode='edit'
 set number
 set noreadonly modifiable
 set colorcolumn=7,19,40
 nnoremap h h
 nnoremap j j
 nnoremap k k
 nnoremap l l
endfunction

" get into presentation mode
function! Show()
 let g:mode='show'
 set nonumber
 set readonly nomodifiable
 set colorcolumn=0
 nnoremap <silent> h :BACK<CR>
 nnoremap <silent> j :call NextLine()<CR>
 nnoremap <silent> k :call PrevLine()<CR>
 nnoremap <silent> l :GO<CR>
endfunction
