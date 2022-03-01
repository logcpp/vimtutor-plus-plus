" Title: Vim Plugin - Ftdetect - autoload - Makefile
" Author: logcpp
" Features: function definitions for Makefile filetype
" Created On: 2022/2/1
" Last Change: 2022/2/28
" -------------------- functions --------------------

function s:Base_Rust(fname)
	let l:fname = a:fname
	let l:f1 = "main.rs"
	let l:f2 = l:fname . ".rs"

	let l:choice = confirm("Generate ".l:f1." & ".l:f2." automatically?", "Yes\nNo\nCancel")
	if l:choice == 1
		let l:ai = &autoindent
		set noautoindent
		let l:comment = "// "
		let l:date = system('date "+%Y/%m/%d"')
		execute "edit " . l:f1
		let text = l:comment.l:f1."\n".l:comment.l:date."\nmod ".l:fname.";\n\nfn main()\n{\n\t".l:fname."::run();\n}"
		execute "normal " . "i\<C-r>=text\n" | write
		execute "edit " . l:f2
		let text = l:comment.l:f2."\n".l:comment.l:date."\npub fn run()\n{\n\t\n}"
		execute "normal " . "i\<C-r>=text\n" | write
		unlet text
		let &autoindent = l:ai
	endif
endfunction

function! s:Base(...)
	if a:0 != 1 && a:0 != 2
		echoerr "Self Err: usage: Base <filetype> <filename>"
		return
	endif
	let l:ft = a:1
	if l:ft != "c" && l:ft != "tex" && l:ft != "rust"
		echoerr "Self Err: Makefile for filetype '".a:1."' is not supported"
		return
	elseif l:ft == "c"
		let l:base = s:dir."src/make/c_makefile"
	elseif l:ft == "tex"
		let l:base = s:dir."src/make/tex_makefile"
	else " rust
		let l:base = s:dir."src/make/rust_makefile"
	endif
	execute "0r ".l:base
	$d
	let l:fname = "myfile"
	if a:0 == 2
		let l:fname = a:2
		silent execute "%s/myfile/".l:fname."/g"
	endif
	write
	" rust filetype settings
	if l:ft == "rust" | call s:Base_Rust(l:fname) | endif
endfunction

function! sub#makeft#Make_set(dir)
	imap UP		<Esc>gUiwgi
	let s:dir = a:dir
	command! -nargs=+ Base call <sid>Base(<f-args>)
endfunction

function! sub#makeft#Make_reset()
	iunmap UP
	silent! delcommand Base
endfunction
