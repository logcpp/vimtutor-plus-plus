# Overview of included plugins

Additional descriptions about the plugins in this package.

Click [here](./README.md) to go back to the README.md.

## Index

### Startup plugins
Haven't been added so far.

### Optional plugins
- test			(2022/1/25)
- signmark		(2022/1/26)
- myvimrc		(2022/1/27)
- foldmode		(2022/1/28)

---
## "Test" plugin (optional)
### Features 
An example of plugin, only made for testing. It contains a brief document
about how to write a plugin.
### Implementations
- autoload
	- test#Echo(msg): echo "msg"
- plugin
	- s:Echo() -> call test#Echo(msg)
	- nmap \<Plug\>Testecho -> \<SID\>Echo -> :call \<SID\>Echo()\<CR\>
- doc
	- how to write a plugin

---
## "SignMark" plugin (optional)
### Features
### Implementations

---
## "Myvimrc" plugin (optional)
### Features
### Implementations

---
# "Foldmode" plugin (startup)
### Features
A plugin that enables a pseudo "Fold" mode, which toggles 'z' for easy
navigation. 
### Implementations
- autoload
	- foldmode#Foldon(): turn on "Fold" mode
- plugin
	- s:Foldon() -> call foldmode#Foldon()
	- nmap \<Plug\>FoldmodeOn -> \<sid\>Foldon -> :call \<sid\>Foldon()
- doc
	- explain the implementation of remapping, contains a list of remapped
	  commands

---
vim:tw=78:
