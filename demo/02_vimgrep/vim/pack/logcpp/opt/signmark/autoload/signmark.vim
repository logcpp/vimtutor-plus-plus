" Title: Vim Plugin - SignMark - autoload
" Author: logcpp
" Version: 1.0
" Features: places signs to the lines which contain marks
" Created On: 2022/1/24
" Last Change: 2022/2/3
" Initial Version: 0.0 (created on: 2022/1/23)
" License: this file is placed in the public domain
"
" NOTE: the syntax of the sign command is like below
" 	":sign define {name} text={text} texthl={hl-group}"
" 	":sign place {id} group={group} line={line} name={name} file={file}"

" Index:
" 
"	s:FindMark() -> finds all marks of 'a'-'z' and 'A'-'Z' in the current buffer -> ['a', line, col, file]
"	s:GetUserInput(prompt) -> printout <prompt> to get mark name, if <Esc>, return 0, if not in [a-zA-Z], return -1, else return 'a'-'z' or 'A'-'Z'
"	s:PrintOutput(prompt) -> show the result by string <prompt>
"	s:PlaceMark(m_char) -> place a mark named <m_char> on the current cursor, unplace/defines the pre-existing sign and place a new one
"	s:UnplaceMark(m_char) -> find existing mark/sign and del/unplace, if found, return 0, if none exists, return -1
"
"	signmark#Turnon() -> define g:m_list to enable (un)placing signed-mark -> s:FindMark() -> s:PlaceMark() -x- no output
"	signmark#Turnoff() -> undefine g:m_list, disable (un)placing signed-mark and clear all signs -x- no output
"	signmark#Place() -> s:GetUserInput() -> return if Esc or invalid name -> s:PlaceMark() -> s:PrintOutput()
"	signmark#Unplace() -> s:GetUserInput() -> return if Esc or invalid name -> s:UnplaceMark() -> s:PrintOutput()
"	signmark#Clear(bang) -> s:FindMark() -> 'a'-'z'(and 'A'-'Z' when <bang>)=>s:UnplaceMark() -x- no output
"

" -------------- s:functions --------------

" check if <char> is in between <start> and <end>
function! s:inbetween(char, start, end)
	return char2nr(a:char) >= char2nr(a:start) && char2nr(a:char) <= char2nr(a:end) ? 1 : 0
endfunction

" find all marks in the current buffer and return a list: ["name", "linenr", "colnr"]
function! s:FindMark()
	let l:res = execute("marks")
	let l:res = trim(l:res)
	let l:mark_list = []
	let l:res_st = 0
	let l:pre_mark = ''
	while (1)
		let l:res = l:res[l:res_st:]
		let l:newline = matchstr(l:res, '\v\W\zs[a-z]\s+\d+\s+\d+\s+\S+\ze')
		let l:res_st = match(l:res, '\v\W[a-z]\s+\d+\zs')
		let l:mark = matchstr(l:newline, '\v\zs[a-z]\ze\s+\d+\s+\d+\s+\S+')
		let l:linenr = matchstr(l:newline, '\v[a-z]\s+\zs\d+\ze\s+\d+\s+\S+')
		let l:colnr = matchstr(l:newline, '\v[a-z]\s+\d+\s+\zs\d+\ze\s+\S+')
		let l:file = matchstr(l:newline, '\v[a-z]\s+\d+\s+\d+\s+\zs\S+\ze\n')
		if len(l:mark) != 1 && l:linenr <= line('$') | break | endif
		if !s:inbetween(l:mark, 'a', 'z') && !s:inbetween(l:mark, 'A', 'Z')
			break 
		endif
		if l:pre_mark == l:mark | break | endif
		call add(l:mark_list, [l:mark, l:linenr, l:colnr, l:file])
		let l:pre_mark = l:mark
	endwhile
	return l:mark_list
endfunction

" return 1 character from keyboard input
function! s:GetUserInput(prompt)
	" get character to define mark (only 'a'-'z' and 'A'-'Z' are allowed)
	echon a:prompt
	let l:m_nr = getchar()
	" if is 'Esc' => exit normally, do nothing
	if l:m_nr == 27 
		normal : 
		return ""
	endif
	let l:m_char = nr2char(l:m_nr)
	" check if is 'a'-'z' or 'A'-'Z'=> if not, EXIT
	if !s:inbetween(l:m_char, 'a', 'z') && !s:inbetween(l:m_char, 'A', 'Z')
		echoerr "Self Err: signed-mark name must be between 'a' and 'z' or between 'A' and 'Z' "
		return ""
	endif
	return l:m_char
endfunction

" print out prompt
function! s:PrintOutput(prompt)
	normal :
	echon a:prompt
endfunction

function! s:PlaceMark(m_char)
	let l:m_char = a:m_char
	" define variables
	let l:s_name = "selfmarker_" . l:m_char
	let l:s_text = l:m_char
	let l:s_hlgroup = "ModeMsg"
	" place variables
	let l:s_id = char2nr(a:m_char)
	let l:s_group = "g_selfmarker"
	let l:s_line = getcurpos()[1]
	let l:s_file = expand("%:p")
	" make a mark on the current line
	execute "normal m" . l:m_char
	" if mark/sign already set => unplace existing sign
	if index(g:m_list, l:m_char) >= 0
		let l:cmd = "sign unplace " . l:s_id . " group=" . l:s_group
		if s:inbetween(l:m_char, 'a', 'z')
			let l:cmd = l:cmd . " file=" . l:s_file
		endif
		execute l:cmd
	else
		" define new sign, update sign text
		execute "sign define " . l:s_name . " text=" . l:s_text . " texthl=" . l:s_hlgroup
	endif
	" place the sign
	let l:cmd = "sign place " . l:s_id . " group=" . l:s_group . " line=" . l:s_line . " name=" . l:s_name
	if s:inbetween(l:m_char, 'a', 'z')
		let l:cmd = l:cmd . " file=" . l:s_file
	endif
	execute l:cmd
	" if mark/sign is new => add mark/sign to the list
	if index(g:m_list, l:m_char) == -1
		call add(g:m_list, l:m_char)
	endif
endfunction

function! s:UnplaceMark(m_char)
	let l:m_char = a:m_char
	" unplace variables
	let l:s_id = char2nr(a:m_char)
	let l:s_group = "g_selfmarker"
	let l:s_file = expand("%:p")
	" if mark/sign already set => unplace existing sign
	execute "delmarks " . l:m_char
	if index(g:m_list, l:m_char) >= 0
		let l:cmd = "sign unplace " . l:s_id . " group=" . l:s_group
		if s:inbetween(l:m_char, 'a', 'z')
			let l:cmd = l:cmd . " file=" . l:s_file
		endif
		execute l:cmd
		return 0
	" no sign exist => do nothing
	else
		return -1
	endif
endfunction

" ----------- signmark#functions ----------

function! signmark#Turnon()
	" set g:m_list as placed mark list
	if !exists("g:m_list")
		let g:m_list = []
	endif
	" if there are existing marks already, put sign to them
	let l:mark_list = s:FindMark()
	" remember the original cursor position
	let l:o_linenr = getcurpos()[1]
	let l:o_colnr = getcurpos()[2]
	for l:i in range(len(l:mark_list))
		let [l:m_char, l:linenr, l:colnr, l:file] = l:mark_list[l:i]
		" if is 'A'-'Z' file marks and not in buffer, skip placing sign
		if s:inbetween(l:m_char, 'A', 'Z') && match(l:file, '\v([^/]*\/)+|([^\.]&\S)+\.\w\w\w+') > -1
			continue
		endif
		" move cursor to the mark
		execute "normal `" . l:m_char
		call s:PlaceMark(l:m_char)
	endfor
	" restore the original cursor position
	execute string(l:o_linenr)
	normal 0
	if l:o_colnr > 1
		execute "normal ".string(l:o_colnr-1)."l"
	endif
endfunction

function! signmark#Turnoff()
	let l:s_group = "g_selfmarker"
	let l:s_file = expand("%:p")
	" clear all signs
	execute "sign unplace * group=" . l:s_group
	" if signed-mark exists => undefine all sign_names
	for l:i in range(len(g:m_list))
		let l:s_name = "selfmarker_" . g:m_list[l:i]
		execute "sign undefine " . l:s_name
		"execute "delmarks " . g:m_list[i]
	endfor
	" remove mark list
	unlet! g:m_list
endfunction

function! signmark#Place()
	let l:m_char = s:GetUserInput("Set mark name:")
	" <Esc> or not in [a-zA-Z] => l:m_char = "" => exit
	if l:m_char == ""
		return
	endif
	call s:PlaceMark(l:m_char)
	call s:PrintOutput("signed-mark set")
endfunction

function! signmark#Unplace()
	let l:m_char = s:GetUserInput("Delete mark name:")
	" <Esc> or not in [a-zA-Z] => l:m_char = "" => exit
	if l:m_char == ""
		return
	endif
	let l:res = s:UnplaceMark(l:m_char)
	" deleted:0, none exists:-1
	if l:res == 0 
		let l:prompt = "signed-mark deleted"
	else
		let l:prompt = "no signed-mark '" . l:m_char . "' defined"
	endif
	call s:PrintOutput(l:prompt)
endfunction

function! signmark#Clear(bang)
	" find existing signed-mark to delete
	let l:mark_list = s:FindMark()
	" remember the original cursor position
	let [l:o_linenr, l:o_colnr] = getcurpos()[1:2]
	" check all marks in mark_list and unplace
	for l:i in range(len(l:mark_list))
		let [l:m_char, l:linenr, l:colnr, l:file] = l:mark_list[l:i]
		" if is 'A'-'Z' file marks
		if s:inbetween(l:m_char, 'A', 'Z')
			"  filepath matched => file mark not contained in current buffer => always skip
			if match(l:file, '\v([^/]*\/)+|([^\.]&\S)+\.\w\w\w+') > -1
				continue
			" file mark is in current buffer => skip it when <bang> is not set
			elseif a:bang != '!'
				continue
			endif
		endif
		" move cursor to the mark
		execute "normal `" . l:m_char
		let l:res = s:UnplaceMark(l:m_char)
		if l:res != 0
			echoerr "Self Err: deleting undefined mark during Mclear"
		endif
	endfor
	" restore the original cursor position
	execute string(l:o_linenr)
	normal 0
	if l:o_colnr > 1
		execute "normal ".string(l:o_colnr-1)."l"
	endif
endfunction
