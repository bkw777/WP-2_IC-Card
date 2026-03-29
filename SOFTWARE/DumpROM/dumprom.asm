; dumprom.asm
; Christopher@randomvariations.com
; https://randomvariations.com/category/tandy-wp-2/
; Converted to z88dk-z80asm - Brian K. White
;
; For TANDY WP-2
; Dumps all of the ROM banks to the serial port
; Sets the serial port to 9600n81
;
; z88dk_z80asm -b -o=DUMPROM.PR dumprom.asm

CHARSENSE	EQU		0100h
CHARGET		EQU		0103h

SETLOC		EQU		0109h
GETLOC		EQU		010Ch
CURSORON	EQU		010Fh
CURSORTYPE	EQU		0112h

CHAROUT		EQU		0118h
PUTCHAR		EQU		01A3h
STROUT		EQU		011Bh
CLS			EQU		011Eh
BEEP		EQU		0121h

RSINIT		EQU		0140h
GETDATALEN	EQU		0143h
SENDDATA	EQU		0146h
GETDATA		EQU		0149h
RSCLOSE		EQU		014Ch

CHGSLOT		EQU		0166h

LINEIN		EQU		01A6h

BKSP		EQU		08h
LF		EQU		0Ah
CR		EQU		0Dh
ESC		EQU		1Bh

ORG		0AC00H-8
DB		"PR"
DW		PRGEND-PRGSTART+1
DW		START
DW		0000h

PRGSTART:
START:
	CALL	CLS
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	XOR	A
	LD	(CURSLOT),A
	CALL	CHGSLOT		; change to slot zero to start
	LD	HL,0h		; start at zero to read the first bank
	LD	(CURRENT),HL
	CALL	DUMPLOOP
MAINLOOP:
	CALL	BEEP		; We dumped another block
	LD	HL,4000h	; remaining banks start at 4000h
	LD	(CURRENT),HL
	LD	A,(CURSLOT)
	INC	A
	LD	(CURSLOT),A	; bump to next slot
	CP	0Fh		; if slot 15 (IC Card)
	JR	Z,DONE		; then we are done
	CALL	CHGSLOT
	CALL	DUMPLOOP	; otherwise dump it
	JR	MAINLOOP
DONE:
	XOR	A
	CALL	CHGSLOT		; change back to slot zero
	XOR	A
	RET

DUMPLOOP:
	LD	HL,084Dh	; 9600 bps, 8n1, no xon, timer enabled
	CALL	RSINIT
BYTELOOP:
	LD	HL,(CURRENT)
	LD	A,(HL)
	INC	HL
	LD	(CURRENT),HL
	CALL	SENDDATA
	LD	A,H
	CP	080h
	JR	NZ,BYTELOOP
	CALL	SENDDATA	; for some reason we have to send
					; another dummy byte before the close
	CALL	RSCLOSE
	RET

CURRENT:
	DW	00000H
CURSLOT:
	DB	0h
PRGEND:

END:
