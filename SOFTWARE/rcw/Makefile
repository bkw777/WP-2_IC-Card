# Makefile for rcw

NAME := rcw

CC ?= gcc
CFLAGS += -O2 -Wall

.PHONY: all
all: $(NAME)

$(NAME): Makefile $(NAME).c
	$(CC) $(CFLAGS) $(NAME).c -o $(@)
	chmod 755 $(@)

clean:
	rm -f $(NAME) *.o
