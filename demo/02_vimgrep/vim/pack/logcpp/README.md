# Vim package by logcpp

## About this package

### Description

This is a personal Vim package created by logcpp.

Plugins are placed here and most of them are optional (i.e. located in 
`$HOME/.vim/logcpp/opt/`).

### Loading plugins included in this package

To load one of the plugins, start Vim and run

`:packadd <plugin-name>`

This will load the vimscripts (`<plugin-name>/plugin/.vim`) files and the
help files (`<plugin-name>/doc/\*.txt`) as well.

After loading, Vim will add the path to the plugin directory to the `runtime`
variable inside Vim to track the functions.

Therefore, after running `:packadd` command, you can run `:h <plugin-name>`
for the documentation of the loaded plugin.

### How to use the package

All plugin directories must be placed in the `$HOME/.vim/pack/*/opt/`
directory. '\*' is the package name.

When loading, Vim will look for the `.../opt/<plugin-name>/plugin/*.vim`, and
when functions are called, Vim will look for the definitions in files like
`.../opt/<plugin-name>/autoload/*.vim`.

Instead of `.../opt/`, you may use `.../start/` for the directory path, but
notice that this will make Vim load all the plugins under the `.../start/`
directory.  This is not expected by the author.

### How to write a plugin

This is described in the documentation of the `test` "plugin" located in 
`.../opt/test/doc/test.txt`. Open the file directory to check it out. If you
have Vim running, you can also run the commands below to see the description
in the help.

```
:packadd test
:help test.txt
```

### Information

Author: logcpp
Created on: 2022/1/26
Last Change: 2022/2/7

---
---

## Overview of the included plugins

Brief descriptions about the plugins in this package.

### Index

#### Startup plugins
- ftdetect		(2022/01/31)
- textobj		(2022/02/05)

#### Optional plugins
- test			(2022/01/25)
- signmark		(2022/01/26)
- myvimrc		(2022/01/27)
- foldmode		(2022/01/28)
- hcomp			(2022/01/28)
- slide			(2022/01/30)
- imap			(2022/02/01)
- comment		(2022/02/03)
- dragmode		(2022/02/04)
- log			(2022/02/08)
- surround		(2022/02/20)

---
### "Ftdetect" plugin (2022/01/31)
#### Features
All filetype configuration, including C, Vimscript, LaTeX, Python, Shell
script.
#### Implementations
- autoload
	- ftdetect.vim
	- sub/
		- cft.vim
		- gitft.vim
		- htmlft.vim
		- luaft.vim
		- makeft.vim
		- pyft.vim
		- rustft.vim
		- shft.vim
		- texft.vim
		- vimft.vim
- plugin
	- ftdetect.vim
- dict
	- c
	- tex
---
#### "Textobj" plugin (2022/02/05)
#### Features
User-defined textobjects. if,af,ic,ac are depending on "Comment" plugin.
#### Implementations
- autoload
	- textobj#IndentBlock(ins)
	- textobj#FunctionBlock(ins)
	- textobj#PairBlock(ins, char)
	- textobj#CommentBlock(ins)
- plugin
	onoremap, vnoremap
	- ae (2022/02/05)
	- ii (2022/02/05)
	- ai (2022/02/05)
	- if (2022/02/05), need "comment"
	- af (2022/02/05), need "comment"
	- i| (2022/02/07)
	- a| (2022/02/07)
	- i\* (2022/02/07)
	- a\* (2022/02/07)
	- ic (2022/02/08), need "comment"
	- ac (2022/02/08), need "comment"
- doc
	- mappings
---
### "Test" plugin (optional)
#### Features 
An example of plugin, only made for testing. It contains a brief document
about how to write a plugin.
#### Implementations
- autoload
	- test#Echo(msg): echo "msg"
- plugin
	- s:Echo() -> call test#Echo(msg)
	- nmap \<Plug\>Testecho -> \<SID\>Echo -> :call \<SID\>Echo()\<CR\>
- doc
	- how to write a plugin
---
### "SignMark" plugin (optional)
#### Features
A plugin to put signs on mark lines.
#### Implementations
- autoload
	- signmark#Turnon()
	- signmark#Turnoff()
	- signmark#Unplace()
	- signmark#Clear(bang)
- plugin
	- Mon -> Turnon()
	- Moff -> Turnoff()
	- Mclear -> Clear(\<bang\>)
	- nmap \<leader\>m \<plug\>(signmark-place) \<sid\>Place -\> Place()
	- nmap \<leader\>M \<plug\>(signmark-unplace) \<sid\>Unplace -\> Unplace()
- doc
---
### "Myvimrc" plugin (optional)
#### Features
A plugin to manage vim scripts in .vim/
#### Implementations
- autoload
- plugin
- doc
---
## "Foldmode" plugin (startup)
#### Features
A plugin that enables a pseudo "Fold" mode, which toggles 'z' for easy
navigation. 
#### Implementations
- autoload
	- foldmode#Foldon(): turn on "Fold" mode
- plugin
	- s:Foldon() -> call foldmode#Foldon()
	- nmap \<Plug\>FoldmodeOn -> \<sid\>Foldon -> :call \<sid\>Foldon()
- doc
	- explain the implementation of remapping, contains a list of remapped
	  commands
---
### "Hcomp" plugin (2022/01/28)
#### Features
A plugin to use different completion method by one single key binding.
#### Implementations
- autoload
	- hcomp#Add2Dict()
	- hcomp#InitCompInfo()
	- hcomp#UpdateCompInfo()
	- hcomp#HComp(default\_key)
- plugin
	- au CompleteChanged -> UpdateCompInfo()
	- au CompleteDone -> HCompRst()
	- imap \<Tab\> \<plug\>HComp -\>
	  \<sid\>PreCmd\<Esc\>-\>\<sid\>HCompMap()\<CR\>gi\<sid\>HCompCmd
	- imap \<S-Tab\> -> \<Tab\>
	- nmap z\<C-k\> \<plug\>Dict -> Add2Dict()
- doc
	- About the name
	- How to use HybridCompletion
	- Priority order of completion methods
	- Adding words to the dictionary
---
### "Slide" plugin (2022/01/30)
#### Features
A plugin to present slide shows in Vim.
#### Implementations
- autoload
	- slide#NextPage()
	- slide#PrevPage()
	- slide#NextLine()
	- slide#PrevLine()
	- slide#PageInfo()
	- slide#JumpPage(page)
	- silde#JumpBack()
- plugin
	- :GO
	- :BACK
	- :NEXT
	- :PREV
	- :PAGE
	- :JUMP
	- :LAST
	- :START
	- :END
- doc
	- Key mappings and commands
	- Slide Modes
	- Making Slides
---
### "Imap" plugin (2022/02/01)
#### Features
A plugin for snippet-like commands in Insert mode.
#### Implementations
- autoload
	- UpperInitial()
- plugin
	- UP: make the current word uppercase.
	- UW: make the current WORD uppercase.
	- UU: make the whole line uppercase.
	- UI: make the initial character of the current word uppercase.
	- US: make the initial character o the current sentence uppercase.
- doc
---
### "Comment" plugin (2022/02/03)
#### Features
A plugin to realize commenting operator 'gc'.
#### Implementations
- autoload
	- comment#Comment\_c(line1, line2, ins)
	- comment#SetOpf(ins)
- plugin
	- :Comment
	- :Uncomment
	- gc
	- gC
- doc
	- How to use Comment
	- Commands and key mappings
---
### "Dragmode" plugin (2022/02/04)
#### Features
"Drag" around multiple lines of codes in the text.
#### Implementations
- autoload
	- dragmode#DragStart(line1, line2)
- plugin
	- nmap,vmap \<leader\>j \<plug\>(dragmode-n/v) -> :DragStart\<CR\>
- doc
	- How to use Drag mode
	- Commands and key mappings
---
### "Log" plugin (2022/02/08)
#### Features
A plugin to enable syntax highlighting for log files.
#### Implementations
- autoload
	LogFold()
- plugin
	- syntax=log, LogFold command
- doc
---
### "Surround" plugin (2022/02/20)
#### Features
Imitating surround.vim by Tim Pope
#### Implementations
- autoload
	- surround#ChangeSurround()
	- surround#DeleteSurround()
	- surround#CreateSurround()
- plugin
	- cs -> \<plug\>(surround-cs) -> ChangeSurround()
	- ds -> \<plug\>(surround-ds) -> DeleteSurround()
	- ys -> \<plug\>(surround-ys) -> CreateSurround()
- doc
	- How to use Surround
	- Commands and key mappings
	- Recommended text object for "ys"
---
---
vim:tw=78:
