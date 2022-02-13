# add ':' to correct the program
#	use '.' command or
#	:g/def/normal A:
# use 'return' instead of print()
# 	:%s/\vprint\((.+)\)/\="return ".submatch(1)
# add 'print(' and ')' to all lines that call the functions
# run the code by :w | !python3 %<CR> and map it to <leader><CR>
# 	:nnoremap <leader><CR> :w \| !python3 %<CR>

def add(a, b)
	print(a+b)

def sub(a, b)
	print(a-b)

def mul(a, b)
	print(a*b)

def div(a, b)
	print(a/b)

a = 6
b = 3

add(a, b)
sub(a, b)
mul(a, b)
div(a, b)
