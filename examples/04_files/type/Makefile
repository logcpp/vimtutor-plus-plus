CC = gcc
OBJS = src/type.o
TARGET = bin/type

$(TARGET): $(OBJS)
	$(CC) -o $@ $^
	ctags -R

.Phony: clean
clean:
	rm -f bin/type src/*.o tags
