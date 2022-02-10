" "Shell Script settings"
" Functions: settings for "sh" filetype
" Run By: BufEnter *.sh (autocmd)
" Created On: 2022/1/17
" Last Change: 2022/1/22

"" key mappings
nnoremap <silent> <leader><CR> :!<C-r><C-l><CR>
vnoremap <silent> <leader><CR> "zy:so $HOME/.vim/setting/sh/sh_vrun.vim<CR> 
