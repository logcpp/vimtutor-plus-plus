" Title: Vim Plugin - Myvimrc - autoload - gen_mytags
" Author: logcpp
" Version: 1.0
" Features: lists all tags in files under $HOME/.vim/ and generates "mytags" file
"			for quick tag searching
" Created On: 2022/1/27
" Last Change: 2022/1/27
" Initial Version: 0.0 (created on: 2022/1/18)
" License: this file is placed in the public domain
"
" this is required to generate "mytags" file
" Tag Index Format: </abspath/to/file|tag-in-file|>

function! gen_mytags#Gen_Mytag(target_path)
	" target file of output = .../myvimrc/mytags
	let l:target_file = expand(a:target_path)
	execute("redir! > " . l:target_file)
	redir END

	" processing file list		*tag-filelist*
	"args $HOME/.vimrc $HOME/.vim/Help.txt $DOTVIMSDIR/**/*.vim $HOME/.vim/pack/****/*.vim
	let l:file_list = []
	call add(l:file_list, expand("$HOME/.vimrc"))
	call add(l:file_list, expand("$HOME/.vim/Help.txt"))
	let l:file_list = l:file_list + split(expand("$DOTVIMSDIR/**/*.vim"), '\n')
	"call add(l:file_list, expand("%:p"))
	let l:file_list = l:file_list + split(expand("$HOME/.vim/pack/logcpp/opt/**/**/*.vim"), '\n')

	let l:tag_pattern = "\\v(^\\*.+\\*$|^\\*.+\\*\\ze\\s|\\s\\zs\\*.+\\*$|\\s\\zs\\*.*\\*\\ze\\s)"
	let @/ = l:tag_pattern

	set nowrapscan

	let pre_filename = ""
	for l:filename in l:file_list
		" skip empty filenames
		if l:filename == "" || matchstr(l:filename, '[^ ,\t]') == -1
			continue
		endif

		execute 'e ' . l:filename
		let l:filepath = expand("%:p")
		normal gg0
		silent! let l:res = execute("normal n")
		" while next match exist
		while l:res == ""
			let l:tag_name = expand("<cWORD>")[1:-2]
			" skip empty tagnames
			if matchstr(l:tag_name , '[^ ,\t]') == -1
				continue
			endif
			" write formatted index
			execute("redir >> " . l:target_file)
			echo "<" . l:filepath . "|" . l:tag_name . "|>"
			redir END
			silent! let l:res = execute("normal n")
		endwhile

		" delete current file
		execute "bd " .  l:filename
	endfor

	set wrapscan
endfunction
