# Makefile for WP-2 MemUtil
# Requires https://github.com/z88dk/z88dk

NAME := MEM
SRC = $(NAME).asm
EXE = $(NAME).PR
Z80ASM = z88dk-z80asm

all: $(EXE)

$(EXE): $(SRC)

%.PR: $%
	$(Z80ASM) -v -b -o=$@ $^
	@ls -l $@

#%.PI: $%
#	$(Z80ASM) -v -DON_ROM -b -o=$@ $^
#	@ls -l $@

clean:
	rm -f *.o *.bin *.lis *.lst *.map *.def *.PR *.PI
