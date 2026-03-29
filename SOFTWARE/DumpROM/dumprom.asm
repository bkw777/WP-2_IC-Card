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

CHARSENSE	equ		0100h
CHARGET		equ		0103h

SETLOC		equ		0109h
GETLOC		equ		010Ch
CURSORON	equ		010Fh
CURSORTYPE	equ		0112h

CHAROUT		equ		0118h
PUTCHAR         equ		01A3h
STROUT		equ		011Bh
CLS		equ		011Eh
BEEP		equ		0121h

RSINIT		equ		0140h
GETDATALEN	equ		0143h
SENDDATA	equ		0146h
GETDATA		equ		0149h
RSCLOSE		equ		014Ch

CHGSLOT		equ		0166h

LINEIN		equ		01A6h

BKSP		equ		08h
LF		equ		0Ah
CR		equ		0Dh
ESC		equ		1Bh

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
		ld	(CURSLOT),a
		CALL	CHGSLOT		; change to slot zero to start
		ld	hl,0h		; start at zero to read the first bank
		ld	(CURRENT),hl
		call	DUMPLOOP
MAINLOOP:
		call	BEEP		; We dumped another block
		ld	hl,4000h	; remaining banks start at 4000h
		ld	(CURRENT),hl
		ld	a,(CURSLOT)
		inc	a
		ld	(CURSLOT),a	; bump to next slot
		cp	0Fh		; if slot 15 (IC Card)
		jr	z,DONE		; then we are done
		call	CHGSLOT
		call	DUMPLOOP	; otherwise dump it
		jr	MAINLOOP
DONE:		xor	a
		CALL	CHGSLOT		; change back to slot zero
		xor	a
		ret

DUMPLOOP:	
		ld	hl,084Dh	; 9600 bps, 8n1, no xon, timer enabled
		call	RSINIT
BYTELOOP:
		ld	hl,(CURRENT)
		ld	a,(hl)
		inc	hl
		ld	(CURRENT),hl
		call	SENDDATA
		ld	a,h
		cp	080h
		jr	nz,BYTELOOP
		call	SENDDATA	; for some reason we have to send
					; another dummy byte before the close
		call	RSCLOSE
		ret

CURRENT:
		DW	00000H
CURSLOT:
		DB	0h
PRGEND:

END:
