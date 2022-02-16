" Title: Vim Plugin - AirLime - plugin
" Author: logcpp
" Version: 1.0
" Features: customized statusline inspired by vim-airline
" Created On: 2022/2/10
" Last Change: 2022/2/12
" License: this file is placed in the public domain

if exists("g:loaded_airlime")
	finish
endif
let g:loaded_airlime = 1

call airlime#Init()

au ColorScheme  * call airlime#default_color()

cnoremap <expr> <C-u> execute("redraws") ? "\<C-u>" : "\<C-u>"
