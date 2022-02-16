" Title: Vim Plugin - Log - plugin
" Author: logcpp
" Version: 1.0
" Features: handle files start with "log entry:"
" Created On: 2022/2/8
" Last Change: 2022/2/8
" License: this file is placed in the public domain

if exists("g:loaded_log")
	finish
endif
let g:loaded_log = 1

setlocal syntax=log
command! LogFold setlocal foldmethod=expr foldexpr=log#LogFold()
