" "Settings for Vimtutor++ Slides"
" Created On: 2022/1/23
" Last Change: 2022/1/24

" get abs-path to vimtutor++/
let s:path = expand("%:p")
let s:end = match(s:path, "\\vvimtutor\\+\\zs\\+")
let g:vdir = s:path[0:s:end]

" handling mode
let g:mode = ''

" options
syntax enable
set nonumber
set syntax=vim
set background=dark
set notimeout ttimeout ttimeoutlen=0
set nobackup noswapfile
set tabstop=1 shiftwidth=1 expandtab
set ignorecase smartcase incsearch nohlsearch
set noerrorbells visualbell t_vb=
set nowrap nowrapscan
resize 24

" highlightings
hi CursorLine cterm=NONE ctermfg=NONE ctermbg=NONE
hi Visual cterm=NONE ctermfg=black ctermbg=191
hi Comment cterm=NONE ctermfg=253 ctermbg=NONE
hi VimCommentTitle cterm=bold,underline ctermfg=81 ctermbg=NONE
hi ColorColumn cterm=NONE ctermfg=NONE ctermbg=235

" load functions
execute("source " . g:vdir . "/.config//func.vim")

" wrapped commands
command! GO    call FixPage(NextPage(24))
command! BACK  call FixPage(PrevPage(24))
command! NEXT  call NextLine()
command! PREV  call PrevLine()
command! PAGE  call PageInfo()

command! START call Show()
command! END   call Edit()
command! ANNOT call Annot()

" key mappings
nnoremap <Left>   :BACK<CR>:PAGE<CR>
nnoremap <Down>   :NEXT<CR>:PAGE<CR>
nnoremap <Up>     :PREV<CR>:PAGE<CR>
nnoremap <Right>  :GO<CR>:PAGE<CR>

function! ToggleAnnot()
 if g:mode=='show' | call Annot() | elseif g:mode=='annot' | call Show() | endif
endfunction
nnoremap <silent> <C-a> :call ToggleAnnot()<CR>
nnoremap <C-g> :PAGE<CR>

"START
END
