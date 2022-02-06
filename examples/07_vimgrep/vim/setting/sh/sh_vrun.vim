" "Visual selected Shell Script execution"
" Functions: running multiple selected lines of bash script
"			in visual mode
" Mapped To: <leader><CR> (Visual mode, &filetype=="sh")
" Created On: 2022/1/17
" Last Change: 2022/1/22

redir! > $HOME/.vim/setting/sh/sh_vrun_tmp.sh
echo "printf \"\\e[33m\""
echo "printf \"(vim script)\\n\""
echo "printf \"created temporary shell script file: $HOME/.vim/setting/sh/sh_vrun_tmp.sh,\\n\""
echo "printf \"output is below:\\n{\\n\""
echo "printf \"\\e[0m\""
echo @z
echo "printf \"\\e[33m\""
echo "printf \"}\\n\""
echo "printf \"removed temporary script file\\n\""
echo "printf \"this message is created by $HOME/.vim/setting/sh/sh_vrun.vim\""
echo "printf \"\\e[0m\""
redir END
!source $HOME/.vim/setting/sh/sh_vrun_tmp.sh
!rm $HOME/.vim/setting/sh/sh_vrun_tmp.sh
