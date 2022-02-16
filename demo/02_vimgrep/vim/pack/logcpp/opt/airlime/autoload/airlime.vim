" Title: Vim Plugin - AirLime - autoload
" Author: logcpp
" Version: 1.0
" Features: customized statusline inspired by vim-airline
" Created On: 2022/2/10
" Last Change: 2022/2/13
" License: this file is placed in the public domain

" -------------------- status line --------------------

" set default colors for the mode message if the current colorshcme does not define airlimeMode_.
function! airlime#default_color()
	if !hlexists("airlimeMode_n") || match(execute("hi airlimeMode_n"), "cleared") > -1
		hi airlimeMode_n cterm=bold ctermfg=black ctermbg=green gui=bold guifg=black guibg=#66ff88
	endif
	if !hlexists("airlimeMode_v") ||  match(execute("hi airlimeMode_v"), "cleared") > -1
		hi airlimeMode_v cterm=bold ctermfg=black ctermbg=magenta gui=bold guifg=black guibg=#ffa0c0
	endif
	if !hlexists("airlimeMode_s") ||  match(execute("hi airlimeMode_s"), "cleared") > -1
		hi airlimeMode_s cterm=bold ctermfg=black ctermbg=red gui=bold guifg=black guibg=#ff6060
	endif
	if !hlexists("airlimeMode_i") ||  match(execute("hi airlimeMode_i"), "cleared") > -1
		hi airlimeMode_i cterm=bold ctermfg=black ctermbg=cyan gui=bold guifg=black guibg=#30dddd
	endif
	if !hlexists("airlimeMode_r") ||  match(execute("hi airlimeMode_r"), "cleared") > -1
		hi airlimeMode_r cterm=bold ctermfg=black ctermbg=3 gui=bold guifg=black guibg=#ffaa33
	endif
	if !hlexists("airlimeMode_c") ||  match(execute("hi airlimeMode_c"), "cleared") > -1
		hi airlimeMode_c cterm=bold ctermfg=black ctermbg=yellow gui=bold guifg=black guibg=#ffff60
	endif
	if !hlexists("airlimeMode_t") ||  match(execute("hi airlimeMode_t"), "cleared") > -1
		hi airlimeMode_t cterm=bold ctermfg=black ctermbg=blue gui=bold guifg=black guibg=#8090e0
	endif
	if !hlexists("airlimeMode_e") ||  match(execute("hi airlimeMode_e"), "cleared") > -1
		hi airlimeMode_e cterm=bold ctermfg=white ctermbg=black gui=bold guifg=black guibg=#000000
	endif
endfunction

" update mode message and color when called by status line
function! airlime#Mode()
	let l:m_n = { "n":"NORMAL",
				\ "no":"NORMAL", "nov":"NORMAL", "noV":"NORMAL", "no\<C-V>":"NORMAL",
				\ "niI":"(insert)", "niR":"(replace)", "niV":"(vreplace)"
				\ }
	let l:m_v = { "v":"VISUAL", "V":"VISUAL LINE", "\<C-V>":"VISUAL BLOCK"}
	let l:m_s = { "s":"SELECT", "S":"SELECT LINE", "\<C-S>":"SELECT BLOCK"}
	let l:m_i = { "i":"INSERT", "ic":"COMPLETE", "ix":"COMPLETE"}
	let l:m_r = { "R":"REPLACE", "Rc":"COMPLETE", "Rv":"COMPLETE", "Rx":"COMPLETE"}
	let l:m_c = { "c":"COMMAND", "r":"PROMPT", "rm": "MORE", "r?":"CONFIRM"}
	let l:m_t = { "t":"TERMINAL", "!":"SHELL"}
	let l:m_e = { "cv":"Ex", "ce":"Ex"}

	let l:m = mode()
	if has_key(l:m_n, l:m) 
		let l:ret = l:m_n[l:m] | hi link airlimeMode airlimeMode_n
		" bind ':' to update statusline when getting into command-line
		nmap : :<C-u>
	elseif has_key(l:m_v, l:m)
		let l:ret = l:m_v[l:m] | hi link airlimeMode airlimeMode_v
	elseif has_key(l:m_s, l:m)
		let l:ret = l:m_s[l:m] | hi link airlimeMode airlimeMode_s
	elseif has_key(l:m_i, l:m)
		let l:ret = l:m_i[l:m] | hi link airlimeMode airlimeMode_i
	elseif has_key(l:m_r, l:m)
		let l:ret = l:m_r[l:m] | hi link airlimeMode airlimeMode_r
	elseif has_key(l:m_c, l:m)
		let l:ret = l:m_c[l:m] | hi link airlimeMode airlimeMode_c
		" bind ':' not to redraw statusline, prevent previous output being cleared
		nnoremap : :
	elseif has_key(l:m_t, l:m)
		let l:ret = l:m_t[l:m] | hi link airlimeMode airlimeMode_t
	elseif has_key(l:m_e, l:m)
		let l:ret = l:m_e[l:m] | hi link airlimeMode airlimeMode_e
	else
		echoerr "Self Err: mode() returned invalid value"
		return ""
	endif
	return l:ret.' '
endfunction

function! airlime#StatusLine()
	let l:s = ''
	let l:s .= '%#airlimeMode# %{airlime#Mode()}'
	let l:s .= '%#StatusLine#'
	" filepath, modified, help, readonly, window preview, quickfix
	let l:s .= ' %t%( %m%h%r%w%q%)'
	let l:s .= '%='
	" cursor line, col, filetype
	let l:s .= '%l,%c  %10(%y%)'
	let l:s .= '  %{&fileencoding?&fileencoding:&encoding}'
	let l:s .= '%<'
	let l:s .= '  %P%( %)'
	return l:s
endfunction

" set statusline format
function! s:set_statusline()
	set noshowmode
	set laststatus=2
	set statusline=%!airlime#StatusLine()
endfunction

" -------------------- tab line --------------------

" basic tabline settings from help (see |tabline|), removed components for mouse
function! airlime#TabLine()
	let l:s = ''
	" tabpagenr: 1, 2, ...
	for l:i in range(tabpagenr('$'))
		" select the highlighting
		let l:s .= (l:i+1)==tabpagenr()? "%#TabLineSel#" : "%#TabLine#"
		" label for the tab page
		let l:s .= ' %{airlime#TabName('.(l:i+1).')} '
	endfor
	let l:s .= '%#TabLineFill#'
	return l:s
endfunction

" return each tab name (label)
function! airlime#TabName(n)
	let l:n = a:n
	let l:buflist = tabpagebuflist(l:n)
	let l:winnr = tabpagewinnr(l:n)
	let l:bufname = bufname(l:buflist[l:winnr-1])
	return l:bufname == "" ? "[No Name]" : l:bufname
endfunction

function! s:set_tabline()
	set tabline=%!airlime#TabLine()
endfunction

" -------------------- main function --------------------

" initialize statusline
function! airlime#Init()
	call airlime#default_color()
	hi link airlimeMode airlimeMode_n
	call s:set_statusline()
	call s:set_tabline()
endfunction
