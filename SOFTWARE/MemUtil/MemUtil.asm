; MemUtil 1.0 - Brian K. White
; Forked from HexViewer 2.2 - Ben Grimmett
; Compile to PR (RUN File):  z88dk-z80asm -v -b -o=foo.PR foo.asm
; Compile to PI (ROM Image): z88dk-z80asm -v -DROM -b -o=foo.PI foo.asm
;
; FIXME:  ROM image output is not correct?

; WP-2 System ROM Calls
;CMPHLDE			EQU		0x0020	; Compare HL to DE
CHARSENSE		EQU		0x0100	; Check keyboard buffer, nonblocking get status
CHARGET			EQU		0x0103	; Get one character, wait for input
KILLBUF			EQU		0x0106	; Kill key buffer
SETLOC			EQU		0x0109	; Set cursor location
;GETLOC			EQU		0x010C	; Get cursor location
SETCURSORONOFF	EQU		0x010F	; Set cursor on/off
SETCURSORTYPE	EQU		0x0112	; Set cursor type
;SETCOLOR		EQU		0x0115	; Set character color
CHAROUT			EQU		0x0118	; Output character to console, no esc seq
;PUTCHAR			EQU		0x01A3	; Output character to console, support esc seq
STROUT			EQU		0x011B	; Output string to console, no esc seq
CLS				EQU		0x011E	; Clear screen
;BEEP			EQU		0x0121	; Beep a buzzer
;CHECKCNCL		EQU		0x0124	; Check that CNCL key is pressed NOW
;PRNOUT			EQU		0x0130	; Output one byte of data to printer
;PRNSTATUS		EQU		0x0133	; Check printer status
;READSLOT		EQU		0x0160	; Read data in a slot
;CHGSLOT			EQU		0x0166	; Change slots
;CALLFAR						; Call a routine in another slot
;  RST 0x30
;  DB n   ; slot#
;  DW nn  ; addr
RSINIT			EQU		0x0140	; Initialize RS232C (Baud rate etc...)
GETDATALEN		EQU		0x0143	; Get the length of effective data in aux-buffer
SENDDATA		EQU		0x0146	; Output one byte of data to RS232C
GETDATA			EQU		0x0149	; Get data from the aux-buffer
RSCLOSE			EQU		0x014C	; Close RS232C
;TAPEIN			EQU		0x0150	; Read data from tape
;TAPEOUT			EQU		0x0153	; Write data to tape
;MOTORON			EQU		0x0156	; Motor on
;MOTOROFF		EQU		0x0159	; Motor off
;SYNCREAD		EQU		0x0169	; Read Sync
;SYNCWRITE		EQU		0x016C	; Write Sync
;LINEIN			EQU		0x01A6	; Cooked line input
;LINEIN2			EQU		0x01AC	; Cooked line input with default string
;UNGETFORLINP	EQU		0x01A9	; Unget Char for LINEIN and LINEIN2
;MALLOC			EQU		0x0170	; Memory allocation
;MCHGSIZE		EQU		0x0173	; Changes the size of mALLOCed BLOCK
;MFREE			EQU		0x0176	; Free mALLOCed BLOCK
;MCLOSE			EQU		0x017C	; Close (save) mALLOCed BLOCK
;MNAME			EQU		0x017F	; Names the mALLOCed BLOCK - must before MCLOSE
;LIST0			EQU		0x0182	; Initialize file listing - must before LIST
;LIST			EQU		0x0185	; Get the file list
;OPEN			EQU		0x0188	; Opena file
;READ			EQU		0x018B	; Read a file
;WRITE			EQU		0x018E	; Write a file
;CLOSE			EQU		0x0191	; Close a file
;DELETE			EQU		0x0194	; Delete a file
;RENAME			EQU		0x0197	; Rename a file
;FORMAT			EQU		0X019A	; Format a disk-device
;DEVROOM			EQU		0x01C1	; Get devices rest size (remaining 128-byte blocks)
;SEEK			EQU		0x01BE	; Seek file pointer - only ram disk & ic card ram disk
;WAIT			EQU		0x01A0	; Wait for fixed time in 0.1s
;RUNIC			EQU		0x01AF	; Run IC card program
;RUNFILE			EQU		0x01B2	; Run a program file
;POFFCOUNTPOINTER	EQU	0x01B5	; Get power off counter pointer
;SETBTYPE		EQU		0x01B8	; Set battery type
;GETWORK			EQU		0x01BB	; Get work area

; I/O Ports
pBANKCTL	EQU		0x51

; Memory Addresses
aROMWINDOW	EQU		0x4000

; Keyboard keys
kBACK	EQU		0x08
kESC	EQU		0x1B
kUP		EQU		0x1E
kDN		EQU		0x1F


; Flash types
ST EQU 0x01		; SST
MX EQU 0x02		; Macronix
MXs EQU 0x03	; Macronix on bad PCB versions with scrambled lines


; Build ROM image vs RAM file
IFDEF ROM	; Header for WP-2 executable ROM image

ORG aROMWINDOW	; rom bank window start
DB "PI"			; ID
DW 0			; reserved
DB 0x0F			; bank number (15-31), bank 15 is the first 16k of the rom ic 
DB PRGSTART		; entry addr
DW 0			; reserved

ELSE		; Header for WP-2 executable RUN-file

ORG 0xAC00-8	; application work area
DB "PR"			; ID
DW PRGEND - PRGSTART + 1	; length
DW PRGSTART		; entry addr
DW 0			; located addr (0=here)

ENDIF


PRGSTART:
	CALL DrawTitle
	CALL KILLBUF
	CALL TestForFlash
	JP DisplayHELP

START:
	CALL DisplayRAM

; Command line interpreter of sorts...
ReadKeyboard:
	CALL KILLBUF
	CALL CHARGET
	LD A,H

	CP kUP
	JP Z,PREVIOUS
	CP kDN
	JP Z,NEXT
	CP 'G'
	JP Z,GOTO
	CP 'g'
	JP Z,GOTO
	CP 'W'
	JP Z,WRITERAM
	CP 'w'
	JP Z,WRITERAM
	CP 'P'
	JP Z,WRITEPORT
	CP 'p'
	JP Z,WRITEPORT
	CP 'E'
	JP Z,ERASEFLASH
	CP 'e'
	JP Z,ERASEFLASH
	CP 'S'
	JP Z,SerialHandler
	CP 's'
	JP Z,SerialHandler
	CP '?'
	JP Z,DisplayHELP
	CP '1'		; F1+1 = HELP
	JP Z,RKHELP	; check F1
	CP kBACK	; F2+Bksp = EXIT
	JP Z,RKEXIT	; check F2

	JP ReadKeyboard

; got '1', is F1 pressed also?
RKHELP:
	BIT 1,L 	; F1
	JP NZ,DisplayHELP
	JP ReadKeyboard

; got kBACK, is F2 pressed also?
RKEXIT:
	BIT 0,L		; F2
	JP NZ,Exit
	JP ReadKeyboard

; Return to the OS
Exit:
	XOR A
	OUT (pBANKCTL),A
	RET

DrawTitle:
	CALL CLS
	LD HL,AppName
	CALL STROUT
	LD HL,0x4C00
	CALL SETLOC
	LD HL,AppVer
	CALL STROUT
	RET

GetAnyKey:
	LD HL,0x4007
	CALL SETLOC
	LD HL,AnyKeyMSG
	CALL STROUT
	CALL CHARGET
	CALL KILLBUF
	RET

ShowFlashMSG:
	LD HL,0x0001
	CALL SETLOC
	LD HL,FlashMSG
	CALL STROUT
	CALL GetAnyKey
	RET

; Go to the help screen
DisplayHELP:
	CALL DrawTitle

	LD HL,0x2600
	CALL SETLOC
	LD HL,HelpLabel
	CALL STROUT

	LD HL,0x0001
	CALL SETLOC
	LD HL,HelpMSG1
	CALL STROUT

	LD HL,0x0002
	CALL SETLOC
	LD HL,HelpMSG2
	CALL STROUT

	LD HL,0x0003
	CALL SETLOC
	LD HL,HelpMSG3
	CALL STROUT

	LD HL,0x0004
	CALL SETLOC
	LD HL,HelpMSG4
	CALL STROUT

	LD HL,0x0005
	CALL SETLOC
	LD HL,HelpMSG5
	CALL STROUT

	CALL FlashHelp

;	LD HL,0x0006
;	CALL SETLOC
;	LD HL,HelpMSG6
;	CALL STROUT

	LD HL,0x0007
	CALL SETLOC
	LD HL,ExitKey
	CALL STROUT
	LD HL,0x0907
	CALL SETLOC
	LD HL,ExitLabel
	CALL STROUT

	LD HL,0x2307
	CALL SETLOC
	LD HL,HelpKey
	CALL STROUT
	LD HL,0x2907
	CALL SETLOC
	LD HL,HelpLabel
	CALL STROUT

	CALL GetAnyKey
	JP START

FlashHelp:
	LD A,(FlashPresent)
	CP 0
	RET Z
	LD HL,0x0006
	CALL SETLOC
	LD HL,HelpMSG6
	CALL STROUT
	RET

; Add 0x80 to address pointer
NEXT:
	LD HL,(AddressPointer)
	LD DE,0x80
	ADD HL,DE
	LD (AddressPointer),HL
	JP START

; Subtract 0x80 from address pointer
PREVIOUS:
	LD HL,(AddressPointer)
	LD DE,0x80
	OR A
	SBC HL,DE
	LD (AddressPointer),HL
	JP START

; Go to a user requested memory location
GOTO:
	LD HL,0x4803
	CALL SETLOC
	LD HL,AddressMSG
	CALL STROUT
	LD HL,0x4804
	CALL SETLOC
	LD HL,DataEntryMSG
	CALL STROUT
	LD A,0
	CALL SETCURSORTYPE
	LD A,0
	CALL SETCURSORONOFF
	LD HL,0x4A04
	CALL SETLOC

	CALL Get16bitFromUser ; returns value in HL
	LD (AddressPointer),HL

	LD A,1
	CALL SETCURSORONOFF
	JP START

; Write a value to an IO port
WRITEPORT:
	LD HL,0x4802
	CALL SETLOC
	LD HL,PortMSG
	CALL STROUT
	LD HL,0x4803
	CALL SETLOC
	LD HL,DataEntryMSG
	CALL STROUT

	LD A,0
	CALL SETCURSORTYPE
	LD A,0
	CALL SETCURSORONOFF
	LD HL,0x4A03
	CALL SETLOC

	CALL Get8bitFromUser
	PUSH AF

	LD HL,0x4804
	CALL SETLOC
	LD HL,DataMSG
	CALL STROUT
	LD HL,0x4805
	CALL SETLOC
	LD HL,DataEntryMSG
	CALL STROUT
	LD HL,0x4A05
	CALL SETLOC

	POP AF
	LD C,A
	CALL Get8bitFromUser

	OUT (C),A

	LD A,1
	CALL SETCURSORONOFF
	JP START

; Write a value to a memory location
WRITERAM:
	LD HL,0x4802
	CALL SETLOC
	LD HL,AddressMSG
	CALL STROUT
	LD HL,0x4803
	CALL SETLOC
	LD HL,DataEntryMSG
	CALL STROUT

	LD A,0
	CALL SETCURSORTYPE
	LD A,0
	CALL SETCURSORONOFF
	LD HL,0x4A03
	CALL SETLOC

	CALL Get16bitFromUser
	PUSH HL

	LD HL,0x4804
	CALL SETLOC
	LD HL,DataMSG
	CALL STROUT
	LD HL,0x4805
	CALL SETLOC
	LD HL,DataEntryMSG
	CALL STROUT
	LD HL,0x4A05
	CALL SETLOC

	CALL Get8bitFromUser
	POP HL
	PUSH AF

	; Check if HL < 0x8000
	LD A,H
	CP 0x80
	JP C,Write2Flash  ; Jump if HL < 0x8000 (carry set means H < 0x80)

	POP AF
	LD (HL),A
	LD A,1
	CALL SETCURSORONOFF
	JP START

Write2Flash:
	POP AF
	; change this to write to the flash
	PUSH HL
	PUSH AF

	LD A,0xA0
	CALL FlashPreamble
	POP AF
	POP HL
	LD (HL),A

	LD A,1
	CALL SETCURSORONOFF
	JP START

; Ascii Hex input from keyboard, Returns in HL
Get16bitFromUser:
	PUSH AF
	PUSH BC
	PUSH DE
	CALL CHARGET
	LD A,H
	LD (Buffer),A
	CALL CHAROUT
	CALL CHARGET
	LD A,H
	LD (Buffer+1),A
	CALL CHAROUT
	CALL CHARGET
	LD A,H
	LD (Buffer+2),A
	CALL CHAROUT
	CALL CHARGET
	LD A,H
	LD (Buffer+3),A
	CALL CHAROUT
	CALL ConvertHex16
	LD HL,(Value16Bit)
	POP DE
	POP BC
	POP AF
	RET

; Ascii Hex input from keyboard, Returns in A
Get8bitFromUser:
	PUSH HL
	PUSH BC
	PUSH DE
	LD A,'0'
	LD (Buffer),A
	LD A,'0'
	LD (Buffer+1),A
	CALL CHARGET
	LD A,H
	LD (Buffer+2),A
	CALL CHAROUT
	CALL CHARGET
	LD A,H
	LD (Buffer+3),A
	CALL CHAROUT
	CALL ConvertHex16
	LD A,(Value16Bit)
	POP DE
	POP BC
	POP HL
	RET

; Convert 4 ASCII hex digits to 16-bit address
ConvertHex16:
	LD HL,0            ; Initialize result
	LD DE,Buffer       ; Point to ASCII buffer
	LD B,4             ; Process 4 digits
ConvertLoop:
	LD A,(DE)          ; Get ASCII digit
	CALL ToNibble      ; Convert to 4-bit value
	; Shift HL left by 4 bits
	ADD HL,HL
	ADD HL,HL
	ADD HL,HL
	ADD HL,HL
	OR L               ; Combine nibble with L
	LD L,A             ; Update L
	INC DE             ; Next digit
	DJNZ ConvertLoop
	; Store result in AddressPointer
	LD (Value16Bit),HL
	RET

; Convert ASCII hex digit in A to 4-bit value (0-15)
; Handles 0-9, A-F, a-f
ToNibble:
	; Check for 0-9
	CP '0'
	JP C,InvalidNibble    ; < '0' is invalid
	CP '9'+1
	JP NC,CheckLetters    ; >= '9'+1, try letters
	SUB '0'               ; Convert '0'-'9' to 0-9
	RET
CheckLetters:
	; Convert a-f to A-F by clearing bit 5
	AND 0xDF              ; Make uppercase (e.g., 'a' -> 'A')
	CP 'A'
	JP C,InvalidNibble    ; < 'A' is invalid
	CP 'F'+1
	JP NC,InvalidNibble   ; >= 'F'+1 is invalid
	SUB 'A'-10            ; Convert 'A'-'F' to 10-15
	RET
InvalidNibble:
	LD A,0                ; Return 0 for invalid input
	RET

; Draw 8 lines of hex data
DisplayRAM:
	LD DE,(AddressPointer)
	PUSH DE
	CALL CLS
	POP DE

	CALL LineOfHex
	LD HL,0x0001
	CALL SETLOC
	CALL LineOfHex
	LD HL,0x0002
	CALL SETLOC
	CALL LineOfHex
	LD HL,0x0003
	CALL SETLOC
	CALL LineOfHex
	LD HL,0x0004
	CALL SETLOC
	CALL LineOfHex
	LD HL,0x0005
	CALL SETLOC
	CALL LineOfHex
	LD HL,0x0006
	CALL SETLOC
	CALL LineOfHex
	LD HL,0x0007
	CALL SETLOC
	CALL LineOfHex

	LD HL,0x4900
	CALL SETLOC
	LD HL,AppName
	CALL STROUT
	LD HL,0x4C01
	CALL SETLOC
	LD HL,AppVer
	CALL STROUT

	LD HL,0x4A07
	CALL SETLOC
	LD HL,HelpKey
	CALL STROUT
	LD HL,0x4A06
	CALL SETLOC
	LD HL,HelpLabel
	CALL STROUT

	RET

LineOfHex:
	PUSH DE
	PUSH DE
	LD A,D
	CALL Hex2SCR
	LD A,E
	CALL Hex2SCR
	LD A,' '
	CALL CHAROUT
	POP DE
	LD B,16

Display16:
	PUSH BC
	PUSH DE
	LD A,(DE)
	CALL Hex2SCR
	LD A,' '
	CALL CHAROUT
	POP DE
	INC DE
	POP BC
	DJNZ Display16
	LD A,' '
	CALL CHAROUT
	POP DE
	LD B,16

; Draw the ascii equivalent of the hex data, if its a renderable ascii value
drawascii:
	LD A,(DE)
	INC DE
	PUSH BC
	PUSH DE
	CALL DrawValidAscii
	POP DE
	POP BC
	DJNZ drawascii
	RET

; Send ascii to SCR. If <0x20 >0xFF show "."
DrawValidAscii:
	CP 0x20
	JP C,AsciiInv
	CP 0xFF
	JP NC,AsciiInv
	CALL CHAROUT
	RET

AsciiInv:
	LD A,'.'
	CALL CHAROUT
	RET

ERASEFLASH:
	LD A,(FlashPresent)
	CP 0
	JP Z,START
	CALL DrawTitle
	LD HL,0x0001
	CALL SETLOC
	LD HL,EraseMSG
	CALL STROUT
	CALL KILLBUF

	CALL CHARGET
	LD A,H
	CP A,'y'
	JP Z,EF1
	CP A,'Y'
	JP NZ,START
EF1:
	LD HL,0x0002
	CALL SETLOC
	LD HL,ErasingMSG
	CALL STROUT

; Flash erase code here
	IN A,(pBANKCTL) ;backup current bank
	PUSH AF

	LD A,0x80
	CALL FlashPreamble
	LD A,0x10
	CALL FlashPreamble
w4fe:
;	LD HL,200	; forced pause for debugging
;	CALL WAIT
;	LD HL,'.'	; progress dots, never loops enough
;	CALL CHAROUT
	LD A,(aROMWINDOW)
	LD B,A
	LD A,(aROMWINDOW)
	CP A,B
	JP NZ, w4fe

	LD A,0xF0
	CALL FlashPreamble

	POP AF
	OUT (pBANKCTL),A ; restore current bank
	JP START

TestForFlash: ; CFI query
	IN A,(pBANKCTL) ; backup current bank
	PUSH AF

	LD A,0x90
	CALL FlashPreamble
	LD A,(aROMWINDOW)
	CP 0xBF
	JP NZ,NotSST
	LD A,ST
	LD (FlashType),A
	JP SST

NotSST:
	LD A,0x90
	CALL FlashPreambleMX
	LD A,(aROMWINDOW)
	CP 0xC2 ; test for MX Flash
	JP NZ,NotMX
	LD A,MX
	LD (FlashType),A
	JP SST

NotMX:
	LD A,0x09
	CALL FlashPreambleMXswapped
	LD A,(aROMWINDOW)
	CP 0x43 ; test for MX Flash
	JP NZ,noFlash
	LD A,MXs
	LD (FlashType),A

SST:
	LD A,0xF0
	CALL FlashPreamble
	LD A,1
	LD (FlashPresent),A
	CALL ShowFlashMSG

noFlash:
	POP AF
	OUT (pBANKCTL),A ; restore current bank
	RET

FlashPreamble: ; command in A

	PUSH AF

	LD A,(FlashType)
	CP MX
	JP Z,UseMXFlashPreamble
	LD A,(FlashType)
	CP MXs
	JP Z,UseMXFlashPreambleSwapped
	JP UseSSTFlashPreamble

UseMXFlashPreamble:
	POP AF
	JP FlashPreambleMX
UseMXFlashPreambleSwapped:
	POP AF
	JP FlashPreambleMXswapped
UseSSTFlashPreamble:
	POP AF

	PUSH BC

	LD B,A
	LD C,pBANKCTL
	; The flash unlock sequence is 5555<AA, 2AAA<55, 5555<90h to read Hardware ID
	LD A,0x10
	OUT (pBANKCTL),A ; set flash bank 1
	LD A,0xAA
	LD (0x5555),A

	LD A,0x0F
	OUT (pBANKCTL),A ; set flash bank 0
	LD A,0x55
	LD (0x6AAA),A

	LD A,0x10
	OUT (pBANKCTL),A ; set flash bank 1
	LD A,B
	LD (0x5555),A

	POP BC
	RET

FlashPreambleMX: ; command in A
	PUSH BC

	LD B,A
	LD C,pBANKCTL
	; The flash unlock sequence is 555<AA, 2AA<55, 555<90h to read Hardware ID
	LD A,0x0F
	OUT (pBANKCTL),A ;set flash bank 0
	LD A,0xAA
	LD (0x4555),A

	LD A,0x55
	LD (0x42AA),A

	LD A,B
	LD (0x4555),A

	POP BC
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PCB versions 007-030 had scrambled address & data lines.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Address 0x02AA = 0xA214 = Bank 2, 0x6214
;Address 0x0555 = 0x5928 = Bank 1, 0x5928
FlashPreambleMXswapped: ; command in A
	PUSH BC

	LD B,A
	LD C,pBANKCTL
	; The flash unlock sequence is 555<AA, 2AA<55, 555<90h to read Hardware ID
	LD A,0x10
	OUT (pBANKCTL),A ;set flash bank 1
	LD A,0x55
	LD (0x6214),A
	LD A,0x11
	OUT (pBANKCTL),A ;set flash bank 2
	LD A,0xAA
	LD (0x5928),A
	LD A,0x10
	OUT (pBANKCTL),A ;set flash bank 1
	LD A,B
	LD (0x6214),A

	POP BC
	RET

SerialHandler: ; pass control over to the serial port for flash erase/writing
	CALL DrawTitle
	LD HL,0x1503
	CALL SETLOC
	LD HL,SerialMSG
	CALL STROUT

	LD HL,0x084C ; 9600 bps, 8n1, no xon, timer enabled
	CALL RSINIT
SH1:
	CALL GETDATA
	JP NZ,SerialDataRX
	CALL CHARSENSE
	JP Z,SH1 ; no data from keyboard, loop

	; Key pressed
	BIT 0,L		; F2?
	JP Z,SH1	; else loop
	CP kBACK	; also Del/Bksp?
	JP Z,START	; then exit serial mode
	JP SH1		; loop

SerialDataRX:
	; Received Serial byte is in A
	CP 'E' ; erase command
	JP Z,SerialErase
	CP 'Q' ; Quit Serial handler
	JP Z,START
	CP 'R' ; Read Mem address
	JP Z,ReadMemAddress
	CP 'W' ; write Mem address
	JP Z,WriteMemAddress
	CP 'P' ; write port 51
	JP Z,WritePort51
	CP 'p' ; read port 51
	JP Z,ReadPort51
	LD A,'?' ; Nack
	CALL SENDDATA
	JP START

SerialErase:
	IN A,(pBANKCTL) ; backup current bank
	PUSH AF

	LD A,0x80
	CALL FlashPreamble
	LD A,0x10
	CALL FlashPreamble
Sw4fe:
	LD A,(aROMWINDOW)
	LD B,A
	LD A,(aROMWINDOW)
	CP A,B
	JP NZ,Sw4fe

	LD A,0xF0
	CALL FlashPreamble

	POP AF
	OUT (pBANKCTL),A ; restore current bank

	LD A,1 ; ok
	CALL SENDDATA
	JP SH1

WritePort51:
	CALL GETDATA
	JP Z,WritePort51
	OUT (pBANKCTL),A
	LD (TempBank),A
	LD A,1 ; ack
	CALL SENDDATA
	JP SH1

ReadPort51:
	IN A,(pBANKCTL)
	CALL SENDDATA
	JP SH1

ReadMemAddress:
	; Wait for 2 bytes in the serial rx buffer
	CALL GETDATALEN
	LD A,L
	CP 2
	JP NZ,ReadMemAddress
	CALL GETDATA
	PUSH AF
	CALL GETDATA
	LD L,A
	POP AF
	LD H,A
	LD A,(HL)
	CALL SENDDATA
	JP SH1

WriteMemAddress:
	; Wait for 3 bytes in the serial rx buffer
	CALL GETDATALEN
	LD A,L
	CP 3
	JP NZ,WriteMemAddress
	CALL GETDATA
	PUSH AF
	CALL GETDATA
	LD L,A
	POP AF
	LD H,A
	PUSH HL
	CALL GETDATA
	POP HL
	PUSH AF

	; Check if HL < 0x8000
	LD A,H
	CP 0x80
	JP C,WriteFlashAddress ; Jump if HL < 0x8000 (carry set means H < 80h)
	POP AF
	LD (HL),A

	LD A,1 ; ack
	CALL SENDDATA
	JP SH1
WriteFlashAddress:

	POP AF
	; change this to write to the flash
	PUSH HL
	PUSH AF

	LD A,0xA0
	CALL FlashPreamble

	LD A,(TempBank)
	OUT (pBANKCTL),A
	POP AF
	POP hl
	LD (HL),A

	LD B,A
wffc: ; wait for flash complete
	LD A,(HL)
	CP B
	JP NZ,wffc
	LD A,1 ;ack
	CALL SENDDATA
	JP SH1

Hex2SCR:
	PUSH AF
	PUSH BC
	PUSH DE
	; Hex in, Ascii printed to screen
	LD B,A
	PUSH BC
	AND 0xF0
	RLC A
	RLC A
	RLC A
	RLC A
	CALL Nib2Asc
	POP BC
	LD A,B
	AND 0x0F
	CALL Nib2Asc
	POP DE
	POP BC
	POP AF
	RET
Nib2Asc:
	CP 0x0A
	JP C,HexIsNum
	ADD A,55
	CALL CHAROUT
	RET
HexIsNum:
	ADD A,48
	CALL CHAROUT
	RET

; Volatile variables
ALIGN 2

Value16Bit:
	DW 0;

AddressPointer:
	DW 0;

WriteAddressPointer:
	DW 0;

WriteDataPointer:
	DW 0;

TempBank:
	DB 0x0F

FlashType:
	DB 0

Buffer:
	DB '0'
	DB '0'
	DB '0'
	DB '0'

FlashPresent:
	DB 0

AddressMSG:
	DB "Address?",0

PortMSG:
	DB "Port?   ",0

DataMSG:
	DB "Data?   ",0

FlashMSG:
	DB "Writable flash card detected, enabling flash functions.",0

EraseMSG:
	DB "Are you sure you want to erase the flash card? (y/N) ",0

ErasingMSG:
	DB "Erasing...",0

SerialMSG:
	DB "Serial Interface Active (9600,8n1)",0

; max 7 lines, 1st line is already drawn
HelpMSG1:
	DB "S - Serial interface mode",0
HelpMSG2:
	DB "G - Go to address rom window: 4000-7FFF)",0
HelpMSG3:
	DB "W - Write a byte to a memory address",0
HelpMSG4:
	DB "P - Write to I/O port (ROM IC Card banks: port 51, data 0F-1F)",0
HelpMSG5:
	DB "Up/Dn - Go -/+ 0x80",0
HelpMSG6:
	DB "E - Erase Flash IC Card",0

ExitKey:
	DB "F2+Bksp",0
ExitLabel:
	DB "EXIT",0
HelpKey:
	DB "F1+1",0
HelpLabel:
	DB "HELP",0

AnyKeyMSG:
	DB "[Press any key]",0

DataEntryMSG:
	DB "0x    ",0

AppName:
	DB "MemUtil",0

AppVer:
	DB "v1.1",0

PRGEND:
