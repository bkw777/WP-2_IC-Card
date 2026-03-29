# Makefile for HexViewer
# Requires https://github.com/z88dk/z88dk

SRC = hexviewer_2.2.asm
EXE = HXVIEW22.PR
Z80ASM = z88dk-z80asm

all: ${EXE}

${EXE}:
	${Z80ASM} -v -b -o=${EXE} ${SRC}
	@ls -l ${EXE}

clean:
	rm -f *.o *.bin *.lis *.map *.def *.PR *.PI
