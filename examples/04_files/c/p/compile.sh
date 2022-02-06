#!/bin/bash

c=$(find . -name '*.c')
for i in $c; do
	gcc -o ${i%\.c} $i
	echo gcc -o ${i%\.c} $i
done
