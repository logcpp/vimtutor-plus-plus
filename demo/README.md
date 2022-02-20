# EEIC Vim Meetup - Built-in Features - Demonstration

## Introduction

- Why I use Vim: speed, light-weight, keyboard interface, customizability
- Editor: Vim 8.1. (not Neovim)
- Lines of settings: about 1500
- Recent activity: plugins/settings

## Goals of This Talk

- Introducing the built-in features of Vim
- Increasing understanding of what *default* Vim can do
- Offering some basic settings for the beginners

## _NOT_ Goals of This Talk

- Teaching basic commands of Vim in detail (you have to *learn* one by one)
- Listing all the commands available in Vim (there are hundreds of them!!)
- Modern plugins and Neovim (covered by [Haruki Matsui](https://github.com/matsui54))

## Agenda

0. Write Your First .vimrc
	- local settings & ssh
1. Dot, Macro & Text Objects
	- dot command ------------  . 
	- text objects -----------  cit  di<   yi" 
	- using macro ------------  qa   @a 
	- search & substitute ----  :s/{pat}/{str}/{flag} 
	- global command ---------  :g/{pat}/{cmd} 
2. Editing patterns in Multiple Files
	- vimgrep ----------------  :vimgrep /{pat}/ {files}
	- quickfix list ----------  :copen	:cn  :cp
	- editing files ----------  :cdo    :bufdo
3. Combining Vim with Shell
	- read & write -----------  :r !{cmd}   :w !{cmd}
	- filter commands --------  !{filter}
	- git log with Vim -------  $ git log | vim -
4. Animation
	- macro, global, substitution, vimscript
	- cf.) [Youtube](https://www.youtube.com/watch?v=LCkF19gDfEA&list=PLSS5_ylOj4NoBhVMcyjJFNe-8v0AGYiSp&index=11)
5. Running scripts in Vim
	- fizzbuzz
	- practice (check it out if you are interested)
6. Useful Commands
	- see [here](./06_util/util.md)

## Messages

- Vim is powerful, especially in repetitive tasks
- Vim gets even more powerful when combined with the shell
- There's (almost) nothing Vim cannot do
- Vim may be difficult to **setup** -> Write your first .vimrc
- To get to use Vim fluently, it takes time

## For Those Who Want to Learn Vim

1. Read vimtutor
2. Practice!
3. Read [Practical Vim](https://www.amazon.co.jp/-/en/Drew-Neil/dp/1680501275)
4. More practice!!
5. Install or write plugins and enjoy your Vim life!

## Links

Get this repository from [github](https://github.com/logcpp/vimtutor-plus-plus).

---
last change: 2022.2.20
vim:nonu:fdc=2:
