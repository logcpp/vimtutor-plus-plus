# Vim package by logcpp

## Description

This is a personal Vim package created by logcpp.

Plugins are placed here and  most of them are optional (i.e. located in 
`$HOME/.vim/logcpp/opt/`).

## Plugins included in this package

The overview of the plugins is written [here](./overview.md)

## Loading plugins included in this package

For loading one of the plugins, start Vim and run

`:packadd <plugin-name>`

This will load the vimscripts (`<plugin-name>/plugin/.vim`) files and the
help files (`<plugin-name>/doc/\*.txt`) as well.

After loading, Vim will add the path to the plugin directory to the `runtime`
variable inside Vim to track the functions.

Therefore, after running `:packadd` command, you can run `:h <plugin-name>`
for the documentation of the loaded plugin.

## How to use the package

All plugin directories must be placed in the `$HOME/.vim/pack/*/opt/`
directory. '\*' is the package name.

When loading, Vim will look for the `.../opt/<plugin-name>/plugin/*.vim`, and
when functions are called, Vim will look for the definitions in files like
`.../opt/<plugin-name>/autoload/*.vim`.

Instead of `.../opt/`, you may use `.../start/` for the directory path, but
notice that this will make Vim load all the plugins under the `.../start/`
directory.  This is not expected by the author.

## How to write a plugin

This is described in the documentation of the `test` "plugin" located in 
`.../opt/test/doc/test.txt`. Open the file directory to check it out. If you
have Vim running, you can also run the commands below to see the description
in the help.

```
:packadd test
:help test.txt
```

## Information

Author: logcpp

Created on: 2022/1/26

Last Change: 2022/1/26
