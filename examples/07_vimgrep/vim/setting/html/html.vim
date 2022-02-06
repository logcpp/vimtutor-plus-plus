" "HTML settings"
" Functions: settings for "html" filetype
" Run By: BufEnter *.html (autocmd)
" Created On: 2021/9/?
" Last Change: 2022/1/22

"" format
setlocal shiftwidth=2 tabstop=2

"" keymappings
nnoremap <leader>\ cit

"" highlightings
hi Comment cterm=NONE ctermfg=252 ctermbg=NONE

"" macro for tags in HTML
filetype plugin on
runtime macros/matchit.vim
"packadd matchit
"filetype detect

"" Basic HTML Format
command! HTML :0 read ~/.vim/setting/html/base.html | $d | 6 normal dit
