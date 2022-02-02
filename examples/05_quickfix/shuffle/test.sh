# Created On: 2022/1/21

bin=bin/shuffle
txt=test/test_namelist.txt

for i in {1..10}; do
	$bin 16 < $txt > test/$i.out
	echo $i" done"
	sleep 1
done
