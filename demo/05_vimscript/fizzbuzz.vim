function! FizzBuzz(n)
	let ans = a:n . ": "
	if a:n % 15 == 0
		let ans .= "FizzBuzz"
	elseif a:n % 3 == 0
		let ans .= "Fizz"
	elseif a:n % 5 == 0
		let ans .= "Buzz"
	else
		let ans .= a:n
	endif
	echo ans
endfunction

call FizzBuzz(3)
call FizzBuzz(5)
call FizzBuzz(15)
call FizzBuzz(23)

set nonu
"%d
"%!../03_shell/shuffle/bin/shuffle
