syntax enable
set nu ai
set showcmd
set background=dark
set notimeout ttimeout ttimeoutlen=0
set nobackup noswapfile
set shiftwidth=4 tabstop=4
set splitright splitbelow
set encoding=utf-8 fileencoding=utf-8
set ignorecase smartcase incsearch hlsearch
set noerrorbells visualbell t_vb=
set nowrap
set wildmenu
set backspace=indent,eol,start

nnoremap <C-h> :wincmd h<CR>
nnoremap <C-j> :wincmd j<CR>
nnoremap <C-k> :wincmd k<CR>
nnoremap <C-l> :wincmd l<CR>
nnoremap <Space>l :noh<CR>

hi LineNr cterm=NONE ctermfg=gray ctermbg=NONE
hi CursorLine cterm=NONE ctermfg=NONE ctermbg=NONE
hi CursorLineNr cterm=bold ctermfg=lightgreen ctermbg=NONE
