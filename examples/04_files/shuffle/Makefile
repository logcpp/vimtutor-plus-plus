# Created On: 2022/1/21

CC = gcc
TARGET = bin/shuffle
OBJS = src/shuffle.c
TEST = ./test.sh

$(TARGET): $(OBJS)
	$(CC) -o $@ $^
	ctags -R

.PHONY: clean test
clean:
	rm -f $(TARGET) tags

test:
	$(TEST)
