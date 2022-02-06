" "Vim Surrounding key mappings"
" Functions: create/edit/delete surroundings,
" 			based on "vim-surround" plugin by Tim Pope
" Mapped By: :Son<CR> (global)
" Created On: 2022/1/16
" Last Change: 2022/1/22

nnoremap ysiw" mzciw""<Esc>P`zl
nnoremap ysiw' mzciw''<Esc>P`zl
nnoremap cs'" mz"zdi'r"hr""zp`z
nnoremap cs"' mz"zdi"r'hr'"zp`z
nnoremap ds' mzF'xf'x`zh
nnoremap ds" mzF"xf"x`zh
