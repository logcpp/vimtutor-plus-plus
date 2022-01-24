" "Settings for file 'vimtutor++'"
" Created On: 2022/1/23
" Last Change: 2022/1/23

" options
syntax enable
set nonumber
set syntax=vim
set background=dark
set nobackup noswapfile
set tabstop=1 shiftwidth=1 expandtab
set ignorecase smartcase incsearch hlsearch
set noerrorbells visualbell t_vb=
set nowrap
resize 24
hi CursorLine cterm=NONE ctermfg=NONE ctermbg=NONE
hi Visual cterm=NONE ctermfg=black ctermbg=191
hi Comment cterm=NONE ctermfg=253 ctermbg=NONE
hi VimCommentTitle cterm=bold,underline ctermfg=81 ctermbg=NONE

" check the highlight group under cursor
function! SynGroup()
 let l:s = synID(line('.'), col('.'), 1)
 echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
endfunction

" go to the next page, if at the end of file, do nothing
function! NextPage(height)
 let l:now = (line(".") / a:height) * a:height + 1
 let l:next = (line(".") / a:height + 1) * a:height + 1
 return l:next <= line('$') ? string(l:next) : string(l:now)
endfunction
" go to the previous page, if at the beginning of file, do nothing
function! PrevPage(height)
 let l:now = (line(".") / a:height) * a:height + 1
 let l:prev = (line(".") / a:height - 1) * a:height + 1
 return l:prev > 0 ? string(l:prev) : string(l:now)
endfunction
" set editing mode
function! Edit()
 set number
 set noreadonly modifiable
 set colorcolumn=7
endfunction
" set presentation mode
function! Present()
 set nonumber
 set readonly nomodifiable
 set colorcolumn=0
endfunction

command! GO execute("silent" . NextPage(24) . " | normal zt")
command! BACK execute("silent" . PrevPage(24) . " | normal zt")
command! START call Present()
command! END call Edit()

" key mappings
nnoremap <Up> :BACK<CR>
nnoremap <Down> :GO<CR>
nnoremap <Left> :BACK<CR>
nnoremap <Right> :GO<CR>

nnoremap <C-h> :BACK<CR>
nnoremap <C-j> :GO<CR>
nnoremap <C-k> :BACK<CR>
nnoremap <C-l> :GO<CR>

"START
