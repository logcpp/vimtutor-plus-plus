" Title: Vim Plugin - Test - plugin
" Author: logcpp
" Features: an example of Vim plugin, only for testing
" Created On: 2022/1/25
" Last Change: 2022/1/25

" prevent loaded twice, and for user not to load this plugin
if exists("g:loaded_test")
	finish
endif
let g:loaded_test = 1

" Function in script-scope
" for calling main implement from 'autoload/test.vim' file
function! s:Echo()
	call test#Echo("Hello")
endfunction

function! s:AdvEcho()
	call test#AdvEcho("Hello")
endfunction

" define a user command for calling <SID>Echo()
command! TestEchoCmd	call <SID>AdvEcho()

" map the '<Script-ID>Echo' key
" for calling '<Script-ID>Echo()' function defined above
nnoremap <SID>Echo :call <SID>Echo()<CR>

" map the '<Plug>TestEcho' key
" to enable user to map keys they use to the '<Plug>TestEcho' key for usage
" NOTE: ONLY nmap works
nmap <Plug>TestEcho	<SID>Echo

" users are required to write script as below in their .vimrc
" ex) nmap <leader>a	<Plug>TestEcho
