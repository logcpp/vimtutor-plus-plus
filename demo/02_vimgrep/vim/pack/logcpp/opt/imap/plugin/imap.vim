" Title: Vim Plugin - Imap - plugin
" Author: logcpp
" Version: 1.0
" Features: mapping some useful commands to CAPITALIZED characters in Insert mode
" Created On: 2022/2/1
" Last Change: 2022/2/1
" License: this file is placed in the public domain

function! s:UpperInitial()
	return imap#UpperInitial()
endfunction

function! s:Imap(user_key, map_cmd)
	execute "inoremap ".a:user_key." <Esc>".a:map_cmd."gi"
endfunction

" --------------- mappings ----------------

call <sid>Imap('UP', 'gUiw')
call <sid>Imap('UW', 'gUiW')
call <sid>Imap('UU', 'gUU')
call <sid>Imap('UI', 'ciw<C-r>=<sid>UpperInitial()<CR><Esc>')
call <sid>Imap('US', 'cis<C-r>=<sid>UpperInitial()<CR><Esc>')
