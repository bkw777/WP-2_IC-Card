# Makefile for WP-2 MemUtil
# Requires https://github.com/z88dk/z88dk

NAME := MemUtil
PR = $(NAME).PR
PI = $(NAME).PI

Z80ASM = z88dk-z80asm
ZFLAGS := # -v

# PI output crashes on WP-2
all: PR # PI

.PHONY: PR
PR: $(PR)

.PHONY: PI
PI: $(PI)

%.PR: %.asm
	$(Z80ASM) $(ZFLAGS) -b -o=$@ $<
	@rm *.o
	@ls -l $@

%.PI: %.asm
	$(Z80ASM) $(ZFLAGS) -DROM -b -o=$@ $<
	@rm *.o
	@ls -l $@

.PHONY: clean
clean:
	rm -f *.o *.bin *.lis *.lst *.map *.def *.PR *.PI
