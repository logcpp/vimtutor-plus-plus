" Title: Vim Plugin - Ftdetect - autoload
" Author: logcpp
" Features: filetype detection and settings
" Created On: 2022/2/6
" Last Change: 2022/2/28

" called on BufEnter, select the subfunc corresponds to given filetype
function! ftdetect#BufEnter(ft, dir)
	let l:ft = a:ft
	let l:dir = a:dir
	if l:ft == "c"
		call sub#cft#C_set(l:dir)
	elseif l:ft == "make"
		call sub#makeft#Make_set(l:dir)
	elseif l:ft == "tex" || l:ft == "plaintex"
		call sub#texft#Tex_set(l:dir)
	elseif l:ft == "vim"
		call sub#vimft#Vim_set()
	elseif l:ft == "sh"
		call sub#shft#Sh_set()
	elseif l:ft == "html"
		call sub#htmlft#Html_set(l:dir)
	elseif l:ft == "git"
		call sub#gitft#Gitft_set()
	elseif l:ft == "python"
		call sub#pyft#Py_set()
	elseif l:ft == "lua"
		call sub#luaft#Lua_set(l:dir)
	elseif l:ft == "rust"
		call sub#rustft#Rust_set()
	endif
endfunction

" called on BufLeave, select the subfunc corresponds to given filetype
function! ftdetect#BufLeave(ft)
	let l:ft = a:ft
	if l:ft == "c"
		call sub#cft#C_reset()
	elseif l:ft == "make"
		call sub#makeft#Make_reset()
	elseif l:ft == "tex" || l:ft == "plaintex"
		call sub#texft#Tex_reset()
	elseif l:ft == "vim"
		call sub#vimft#Vim_reset()
	elseif l:ft == "sh"
		call sub#shft#Sh_reset()
	elseif l:ft == "html"
		call sub#htmlft#Html_reset()
	elseif l:ft == "git"
		call sub#gitft#Gitft_reset()
	elseif l:ft == "python"
		call sub#pyft#Py_reset()
	elseif l:ft == "lua"
		call sub#luaft#Lua_reset()
	elseif l:ft == "rust"
		call sub#rustft#Rust_reset()
	endif
endfunction
