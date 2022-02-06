#!/bin/bash

#for i in ./**/*; do
#	if [ -x $i ]; then
#		rm $i
#		echo "removed $i"
#	fi
#done

find . -executable -type f \! -name '*.sh' -exec rm {} \; -exec echo "rm {}" \;
