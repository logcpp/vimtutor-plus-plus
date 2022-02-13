" This is a comment

" ---------- variable definition --------------------
" number
let a = 3
echo a

" string
let str = "hello" . " world"
echo str

" list
let mylist = [1, 2, '3']
echo mylist[1:2]

" dictionary
let dict = {'apple':1, 'banana':2, 'orange':['none']}
echo dict["apple"]


" ---------- control structures ----------
" if statement
if a == 3
	echo "if: hello"
else
	echo "if: bye"
endif

" for statement
for i in range(3)
	echo "for: ".i
endfor

" while statement
let i = 0
while i < 3
	echo "while: ".i
	let i += 1
endwhile


" ---------- function ----------
function! Test() " user function names must start with Uppercase
	echo "Test(): do something"
endfunction
call Test()
