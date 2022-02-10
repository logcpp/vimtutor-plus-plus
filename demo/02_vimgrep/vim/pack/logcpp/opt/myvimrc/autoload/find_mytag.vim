" Title: Vim Plugin - Myvimrc - autoload - find_mytag		*vim_tag.vim*
" Author: logcpp
" Version: 1.0
" Features: jumping to tags from hyperlinks in .vim files, like in help files
" Requirement: $HOME/.vim/**/myvimrc/mytags
"
" Created On: 2022/1/27
" Last Change: 2022/1/27
" Initial Version: 0.0 (2022/1/15)
" License: this file is placed in the public domain
" 
" Definitions:												*tag-def*
" 	destination tag format = *<tag>* 		ex) *self-defined-tag*
" 	hyperlink under cursor = |<tag>| 		ex) |self-defined-tag|
" Format:
"	Both of them must be separated by whitespace with other characters.

function! find_mytag#Find_Mytag(mytags_file)

	" set mark for jumping back to hyperlink
	normal mT
	" copy WORD under cursor
	let word = expand("<cWORD>")
	" tag searching must be case-sensitive
	se noignorecase

	" first, search for tag in the current file
	if word[0] == "\|" && word[-1:] == "\|"
		let tag = word[1:-2]
		" search for tag in TAG_INDEX_FILE
		let @/ = "\\v\\*" . tag . "\\*"
		silent! let res = execute("normal n")
		" if tag exists => jump to the tag and finish
		if res == ""
			return
		endif
	else
		normal `T
		echoerr "Self Err: " . word . ": not a valid tag keyword for vimscript"
		return
	endif

	" no matching in current file => get into TAG_INDEX_FILE
	" if buffer is modified => cannot jump, error
	if getbufinfo(bufnr('%'))[0]["changed"]
		echoerr "Self Err: no write since last change, cannot change buffer"
		return
	endif
	" move to TAG_INDEX_FILE
	let tagidx_file = expand(a:mytags_file)
	execute 'e ' . tagidx_file
	" search for <file|tag|> in TAG_INDEX_FILE
	if word[0] == "\|" && word[-1:] == "\|"
		let tag = word[1:-2]
		" search for tag in TAG_INDEX_FILE
		let @/ = "\\v\\|" . tag . "\\|"
		silent! let res = execute("g//p")
		let no_found = match(res, "Pattern not found")
		" if tag exists
		if no_found == -1
			let word = expand("<cWORD>")
			" if WORD in TAG_INDEX_FILE is a valid format of <filename|tagname|>
			if word[0] == "<" && word[-1:] == ">"
				" search for the position of the first '|'
				let fnend = stridx(word, "|") - 1
				" if contains '|'
				if fnend > 1
					" extract filename
					let filename = word[1:fnend]
					" extract tagname
					let tag = word[fnend+2:-3]
					" search for tag in given filename
					execute 'e ' . filename
					let @/ = "\\v\\*" . word[fnend+2:-3] . "\\*"
					silent! let res = execute("g//p")
					let no_found = match(res, "Pattern not found")
					" if tag exists
					if no_found == "-1"
						normal 0
						noh
					" no matching for tag
					else
						normal `T
						echoerr "Self Err: no match for tag *" . tag . "* in given file \"" . filename . "\""
					endif
				" WORD in TAG_INDEX_FILE has no '|' => not in valid format
				else
					normal `T
					echoerr "Self Err: index described in '" . tagidx_file . "' is not in valid format ('|' not found)"
				endif
			" WORD in TAG_INDEX_FILE has no '<','>' => not in valid format
			else
				normal `T
				echoerr "Self Err: index described in '" . tagidx_file . "' is not in valid format ('<','>' not found)"
			endif
		" if no matching for tag
		else
			normal `T
			echoerr "Self Err: no match for tag *" . tag . "* in index file: " . tagidx_file
		endif
	" not a valid tag keyword
	else
		normal `T
		echoerr "Self Err: " . word . ": not a valid tag keyword for vimscript"
	endif

	" delete TAG_INDEX_FILE from buffer list
	execute 'bd ' . tagidx_file

	se ignorecase

endfunction
