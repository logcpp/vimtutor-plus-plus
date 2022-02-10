CC = gcc
CFLAGS = -Wall
OBJS = m04.o
TARGET = m04

$(TARGET): $(OBJS)
	$(CC) $(CFLAGS) $^ -o $@

.PHONY: clean
clean:
	rm $(TARGET) $(OBJS)
