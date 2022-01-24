# Vimtutor++

Some additional tips in presentation format after learning
`vimtutor`.

## How to Use

Run commands given below to start the slideshow in Vim.

Note that this will use `config.vim` instead of your `.vimrc`.

```
$ chmod u+x start.sh
$ ./start.sh
```

To go through the slides, use `<C-j>` for the next and `<C-k>` 
for the previous page. Similar mappings are also defined to
`<C-h>,` `<C-l>` and the arrow keys

If you want to edit the slides, run `:END` or `:call Edit()`
during the slideshow, or just open the file directly by
`$ vim slide/vimtutor++`.

## Information

Author: logcpp

Created on: 2022.1.24
