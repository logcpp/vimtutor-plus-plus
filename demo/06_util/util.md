# Useful Commands

## Efficient Editing

- use `w`, `b` rather than `h`, `l`
- use `{`, `}` rather than `j`, `k`
- use textobjects rather than `w`, `b`, `{`, `}`
- use Visual mode only when it's needed
- use the Ex commands

Note: keep thinking about how to make your coding faster and faster

## Quick Navigation in Files

- `:path+=`
- `:find`

Note: fzf (fuzzy finder) would be more useful

## Viewing Code

- `<C-D>`, `<C-U>`, `zz`
- `:vsp`, `:tabnew`
- `zf`, `za`, `zE`, `:set foldmethod=`
- `m{char}`, `'{char}`
- `/`

Note: don't rely too much on split windows and tabs, use buffers

## Color Settings

- `:hi {highlightgroup} cterm={attr} ctermfg={color} ctermbg={color}`
- `:set termguicolors`
- `:hi {highlightgroup} gui={attr} guifg={color} guibg={color}`

Note: find a nice colorscheme on the Internet

## Key Mappings

- `:nmap {key} {mapping}`
- `:nnoremap {key} {mapping}`

Note: define your own mappings to optimize your coding style

```vim
" examples:
	:nnoremap <C-l> :noh<CR>
	:inoremap jj <Esc>
	:vnoremap ! :w !bash<CR>
```

## Built-in Completion

- `<C-N>`, `<C-x><C-V>`, `<C-x><C-I>`

Note: use plugins for auto-completion

## The Document is Awesome

- `:h {keyword}`

Note: **always** look for the local document at first!

---
last change: 2022.2.16
vim:nonu:fdc=2:
