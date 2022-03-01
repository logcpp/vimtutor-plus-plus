# Vim Tutorial

## Introduction
- Why I use Vim: speed, light-weight, keyboard interface, customizability
- Editor: Vim 8.1. (not Neovim)
- Lines of settings: about 2000
- Recent activity: plugins/settings

## Goals of This Talk
- Introducing the built-in features of Vim
- Offering some basic settings and commansd for beginners

## _NOT_ Goals of This Talk
- Teaching all the commands of Vim in detail 
- Modern plugins and Neovim (covered by [Haruki Matsui](https://github.com/matsui54))

## Index
1. Movements
2. Editing
3. Ex Commands
4. Search & Substitute
5. Repetition
6. Scrolling
7. Options
8. Other Commands

## 1. Movements
### Short-range movements
- h, l, w, b, e/ge
- j, k
### Long-range movements
- W, B, E/gE, f/F, t/T
- {, }
### Absolute movements
- 0, ^/\_, $
- [N]gg, [N]G
- H, M, L
### Text objects
- a: around, i: inside
- aw/iw, aW/iW, as/is, ap/ip
- others: (a|i)(<|>|{|}|"|'|`)

## 2. Editing
### Insert
- i, a, o, I, A, O
- s/cl, C/c$, S/cc
- c{motion}
### Replace
- r, R
### Delete
- x/dl, X/dh, D/d$, dd
- d{motion}
### Copy & Paste (Yank & Put)
- yy, Y, y$
- y{motion}
- p

## 3. Ex Commands
### Save
- :w\[rite] [filename]
### Exit
- :q[uit]
### Delete
- :d[elete]
### Move
- :m[ove] {address}
### Copy & Paste
- :co[py] {address}
- :t {address}
### Options
- :se[t] {option}

## 4. Search & Substitute
### Search
- /{pattern}
### substitution
- :s[ubstitute]/{pattern}/{string}/[flags]

## 5. Repetition
### Repeat normal commands
- .
### Repeat Ex commands
- @:
- :\<C-p>
- q:
### Repeat searching
- /\<CR>
- /\<C-p>
- q/
### Repeat substitution
- &    (same as :s  )
- g&   (same as :%s )
- :&   (same as :s  )
- :&&  (same as :s& )
- :&g  (same as :sg )
- :%&g (same as :%sg)

## 6. Scrolling
### Short-range scrolling
- zh, zl
- \<C-e>, \<C-y>
### Long-range scrolling
- zH, zL
- \<C-d>, \<C-u>, \<C-f>, \<C-b>
### Fitting screen
- zz, zt, zb

## 7. Options
```vim
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
hi ModeMsg cterm=bold ctermfg=lightblue ctermbg=NONE
```

## 8. Other commands
### Tab Management
- :tabnew {filename}
- :tabe[dit] {filename}
- :tabn[ext]
- :tabp[revious]
- :tabo[nly]
### Window Splitting
- :sp[lit] {filename}
- :vsp[lit] {filename}
### Window Resizing
- :res[ize] -N
- :res[ize] +N
- :vertical res[ize] -N
- :vertical res[ize] +N

## Further Information
- Learn more about Vim: [Practical Vim](https://www.amazon.co.jp/-/en/Drew-Neil/dp/1680501275)
- Learn more about plugins: [Next talk](https://drive.google.com/file/d/1R2_KZ0vl1LU7PCRCU8Go8Yllkkb7wHUW/view?usp=sharing)
- Learn fully about commands and options: Run `:h[elp] {subject}` for the documentation

---
Last change: 2022/03/01
vim:nonu:fdc=2
