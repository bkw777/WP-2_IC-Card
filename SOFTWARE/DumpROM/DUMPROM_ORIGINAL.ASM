; dumps all of the ROM banks to the serial port
; sets the serial port to 9600
; compile with (Udo Munk's) z80asm -fb -vl DUMPROM.CO
CHARSENSE	equ		100H
CHARGET		equ		103H

SETLOC		equ		109H
GETLOC		equ		10CH
CURSORON	equ		10FH
CURSORTYPE	equ		112H

CHAROUT		equ		118h
PUTCHAR         equ		1A3H
STROUT		equ		11BH
CLS		equ		11EH
BEEP		equ		121H

RSINIT		equ		140H
GETDATALEN	equ		143H
SENDDATA	equ		146H
GETDATA		equ		149H
RSCLOSE		equ		14CH

CHGSLOT		equ		166H

LINEIN		equ		1A6H

BKSP		equ		008H
LF		equ		00AH
CR		equ		00DH
ESC		equ		01BH

		ORG		0AC00H-8
		DEFB		'PR'
		DEFW		PRGEND-PRGTOP+1
		DEFW		START
		DEFW		0000H

PRGTOP
START		CALL	CLS
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
		ld	(current),hl
		call	DUMPLOOP
MAINLOOP:
		call	BEEP		; We dumped another block
		ld	hl,4000h	; remaining banks start at 4000h
		ld	(current),hl
		ld	a,(curslot)
		inc	a
		ld	(curslot),a	; bump to next slot
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
		ld	hl,(current)
		ld	a,(hl)
		inc	hl
		ld	(current),hl
		call	SENDDATA
		ld	a,h
		cp	080h
		jr	nz,BYTELOOP
		call	SENDDATA	; for some reason we have to send
					; another dummy byte before the close
		call	RSCLOSE
		ret

CURRENT		DEFW	00000H
CURSLOT		DEFB	0h
PRGEND

		END
