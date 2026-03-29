# Makefile for DumpROM
# Requires https://github.com/z88dk/z88dk

SRC = dumprom.asm
EXE = DUMPROM.PR
Z80ASM = z88dk-z80asm

all: ${EXE}

${EXE}:
	${Z80ASM} -v -b -o=${EXE} ${SRC}
	@ls -l ${EXE}

clean:
	rm -f *.o *.bin *.lis *.map *.def *.PR *.PI
