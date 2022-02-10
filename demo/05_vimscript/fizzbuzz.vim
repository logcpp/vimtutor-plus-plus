function! FizzBuzz(n)
	if a:n % 15 == 0
		echo "FizzBuzz"
	elseif a:n % 3 == 0
		echo "Fizz"
	elseif a:n % 5 == 0
		echo "Buzz"
	else
		echo a:n
	endif
endfunction

call FizzBuzz(3)
call FizzBuzz(5)
call FizzBuzz(15)
call FizzBuzz(23)

%d
"%!../03_shell/shuffle/bin/shuffle
