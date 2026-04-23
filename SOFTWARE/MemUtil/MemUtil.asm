; MemUtil - Brian K. White
; Forked from HexViewer 2.2 - Ben Grimmett
; Compile to RUN File:  z88dk-z80asm -v -b -o=foo.PR foo.asm
; Compile to ROM Image: z88dk-z80asm -v -DROM -b -o=foo.PI foo.asm
;
; TODO: serial mode is not tested at all
;
; ROM target is not fully working but it builds, runs, partly works, returns.
; All flash functions ifdef'ed out when compiling for ROM as simply the initial
; crude way to avoid the conflict of touching the hardware you're running from.
;

DEBUG_SERIAL	EQU		1

;------------------------------------------------------------------------------
; WP-2 platform constants
;------------------------------------------------------------------------------

; WP-2 System ROM Calls
CHARSENSE		EQU		0x0100	; Check keyboard buffer, nonblocking get status
CHARGET			EQU		0x0103	; Get one character, wait for input
KILLBUF			EQU		0x0106	; Kill key buffer
SETLOC			EQU		0x0109	; Set cursor location
;GETLOC			EQU		0x010C	; Get cursor location
SETCURSORONOFF	EQU		0x010F	; Set cursor on/off
SETCURSORTYPE	EQU		0x0112	; Set cursor type
SETCOLOR		EQU		0x0115	; Set character color
CHAROUT			EQU		0x0118	; Output character to console, no esc seq
;PUTCHAR		EQU		0x01A3	; Output character to console, support esc seq
STROUT			EQU		0x011B	; Output string to console, no esc seq
CLS				EQU		0x011E	; Clear screen
;BEEP			EQU		0x0121	; Beep a buzzer
;CHECKCNCL		EQU		0x0124	; Check that CNCL key is pressed NOW
;PRNOUT			EQU		0x0130	; Output one byte of data to printer
;PRNSTATUS		EQU		0x0133	; Check printer status
;READSLOT		EQU		0x0160	; Read data in a slot
;CHGSLOT		EQU		0x0166	; Change slots
RSINIT			EQU		0x0140	; Initialize RS232C (Baud rate etc...)
GETDATALEN		EQU		0x0143	; Get the length of effective data in aux-buffer
SENDDATA		EQU		0x0146	; Output one byte of data to RS232C
GETDATA			EQU		0x0149	; Get data from the aux-buffer
RSCLOSE			EQU		0x014C	; Close RS232C
;TAPEIN			EQU		0x0150	; Read data from tape
;TAPEOUT		EQU		0x0153	; Write data to tape
;MOTORON		EQU		0x0156	; Motor on
;MOTOROFF		EQU		0x0159	; Motor off
;SYNCREAD		EQU		0x0169	; Read Sync
;SYNCWRITE		EQU		0x016C	; Write Sync
;LINEIN			EQU		0x01A6	; Cooked line input
;LINEIN2		EQU		0x01AC	; Cooked line input with default string
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
;DEVROOM		EQU		0x01C1	; Get devices rest size (remaining 128-byte blocks)
;SEEK			EQU		0x01BE	; Seek file pointer - only ram disk & ic card ram disk
;WAIT			EQU		0x01A0	; Wait for fixed time in 0.1s
;RUNIC			EQU		0x01AF	; Run IC card program
;RUNFILE		EQU		0x01B2	; Run a program file
;POFFCOUNTPOINTER	EQU	0x01B5	; Get power off counter pointer
;SETBTYPE		EQU		0x01B8	; Set battery type
;GETWORK		EQU		0x01BB	; Get work area

; I/O Ports
pUARTDATA	EQU		0x10		; 8251 character data
pUARTCTRL	EQU		0x11		; 8251 control/status
pBANKCTRL	EQU		0x51

; Memory Addresses
aROMWINDOW	EQU		0x4000
szROMBANK	EQU		0x4000
aRAMWINDOW	EQU		0x8000
szRAMBANK	EQU		0x8000
aWORKAREA	EQU		0xAC00
aKEYBUF		EQU		0x835E		; 1st byte = status bits: F2 F1 CTRL RSHIFT LSHIFT CAPS GR/CD NORMAL/GRCD
aCONSCTRL	EQU		0x8403

; RST Hooks
;hCMPHLDE	EQU		0x20	; Compare HL to DE
;hBREAK		EQU		0x28	; Debug hook table break pointer
;hCALLFAR	EQU		0x30	; Call a routine in another slot

; Keyboard keys
kTAB	EQU		0x0B
kBS		EQU		0x08
kENTER	EQU		0x0D
kESC	EQU		0x1B
kRIGHT	EQU		0x1C
kLEFT	EQU		0x1D
kUP		EQU		0x1E
kDOWN	EQU		0x1F
kDEL	EQU		0x7F

; Keyboard modifiers (L bits after CHARSENSE or CHARGET)
mF2			EQU		0	; BIT mF2,L NZ = F2 is pressed
mF1			EQU		1	; BIT mF1,L NZ = F1 is pressed
mCTRL		EQU		2	; BIT mCTRL,L NZ = Ctrl is pressed
mRSHIFT		EQU		3	; BIT mRSHIFT,L NZ = Right Shift is pressed
mLSHIFT		EQU		4	; BIT mLSHIFT,L NZ = Left Shift is pressed
mCAPSLOCK	EQU		5	; BIT mCAPSLOCK,L NZ = Caps Lock is on
mCODE		EQU		6	; BIT mCODE,L Z = ALT=GRPH, NZ = ALT=CODE
mALT		EQU		7	; BIT mALT,L Z = normal, NZ = ALT

;------------------------------------------------------------------------------
; Application constants
;------------------------------------------------------------------------------

; Flash chip manufacturer IDs
; 0x5555/0x2AAA actually works on all, 0x555/0x2AA does not
ID_SST		EQU		0xBF	; SST	SST39SF020A-70-4C-TU		5555:AA	2AAA:55
							; Greenliant GLS29EE010-70-4C-WHE	5555:AA	2AAA:55
ID_MX		EQU		0xC2	; MXIC	MX29F040CTI-70G				555:AA	2AA:55
ID_ST		EQU		0x20	; STM	M29F512B-70NZ				555:AA	2AA:55
ID_AM		EQU		0x01	; AMD	AM29F010-70EC				5555:AA	2AAA:55
ID_AT		EQU		0x1F	; Atmel	AT29C010A-70TC				5555:AA	2AAA:55
							; Atmel	AT28C010-12TU				5555:AA	2AAA:55
;ID_MXs 		EQU 	0x43	; not a real mfr id, MX chip on borked PCB design

; Flash chip commands
fcGetId		EQU		0x90
fcExitId	EQU		0xF0
fcErase		EQU		0x80
fcEraseChip	EQU		0x10
fcEraseSect	EQU		0x30
fcByteProg	EQU		0xA0

VerifyFlashCMDRetries		EQU		0xFF
StateSerial		EQU		0		; State bit 0: UI mode: 0=ui 1=serial
;StateXX		EQU		1		; State bit 1:
;StateXX		EQU		2		; State bit 2:
;StateXX		EQU		3		; State bit 3:
;StateXX		EQU		4		; State bit 4:
;StateXX		EQU		5		; State bit 5:
;StateXX		EQU		6		; State bit 6:
;StateXX		EQU		7		; State bit 7:

; Encode control bytes to allow XON/XOFF.
; wxmodem style: For each DLE, XON, XOFF:
; out: RAW -> ENC=RAWxor0x40 -> DLE ENC
; in:  DLE ENC -> discard DLE -> RAW=ENCxor0x40
DLE		EQU		0x10	; -> 0x10 0x50
XON		EQU		0x11	; -> 0x10 0x51
XOFF	EQU		0x13	; -> 0x10 0x53

; HL = RS-232 parameters
;LD H,8		; bps 9=19200 8=9600 7=4800 6=2400 5=1200 4=600 3=300 2=150 1=75
;RES 7,L	; 0 0 1 1	stop bits
;SET 6,L	; 0 1 0 1	0 1 1.5 2
;RES 5,L	; x 0 1		parity
;RES 4,L	; 0 1 1		none odd even
;SET 3,L	; 0 0 1 1	data bits
;SET 2,L	; 0 1 0 1	5 6 7 8
;RES 1,L	; xonoff RES=disable SET=enable
;RES 0,L	; timer interrupt RES=enable SET=disable

;RSINIT_PARAMS	EQU 0x084C	; 9600, 8n1, no xonoff, timer intr enabled
RSINIT_PARAMS	EQU 0x084E	; 9600, 8n1, xonoff, timer intr enabled

MACRO _toupper
	AND 0xDF		; a-f to A-F by clearing bit 5
ENDM

;------------------------------------------------------------------------------
; Executable header
;------------------------------------------------------------------------------

; yes these 2 headers are not the same length

IFDEF ROM	; Header for WP-2 ROM image
FLASH_SUPPORT		EQU 0

ORG aROMWINDOW		; rom bank window start
DB "PI"				; ID
DW 0				; reserved
DB 0x0F				; bank number (15-31), bank 15 is the first 16k of the rom ic 
DW START			; entry addr
DW 0				; reserved

ELSE		; Header for WP-2 RUN file
FLASH_SUPPORT		EQU 1

ORG aWORKAREA-8		; application_work_area - length_of_header
DB "PR"				; ID
DW PRGEND-PRGTOP+1	; length
DW START			; entry addr
DW 0				; located addr (0="here")

ENDIF

;------------------------------------------------------------------------------
; BODY
;------------------------------------------------------------------------------
PRGTOP:
START:

	CALL CLS

;------------------------------------------------------------------------------
; CONSOLE
;------------------------------------------------------------------------------
IF FLASH_SUPPORT
	CALL TestForFlash
ENDIF

C_MAIN:
	LD HL,State
	RES StateSerial,(HL)		; unset serial interface mode flag

	CALL DisplayRAM

IFDEF DEBUG
	LD A,0x02
	LD H,' '
	LD L,0
	CALL DBG
ENDIF

ReadKeyboard:
	CALL KILLBUF
	CALL CHARGET
	LD A,H

	CALL toupper

	CP kUP
	JP Z,PREVIOUS
	CP kDOWN
	JP Z,NEXT
	CP 'G'
	JP Z,GOTO
	CP 'W'
	JP Z,WRITERAM
	CP 'P'
	JP Z,WRITEPORT
IF FLASH_SUPPORT
	CP 'E'
	JP Z,ERASEFLASH
ENDIF
	CP 'S'
	JP Z,SerialHandler

	; Help on either '?' or HELP (F1+1)
	CP '?'
	JP Z,DisplayHELP
	CP '1'				; F1+1 = HELP
	JP Z,rkHELP			; Got '1', check F1

	; Exit on either Esc/Cncl or EXIT (F2+BS)
	CP kESC
	JP Z,Exit
	CP kBS				; F2+BS = EXIT
	JP Z,rkEXIT			; Got BS, check F2

	JP ReadKeyboard

; got '1', is F1 pressed also?
rkHELP:
	BIT mF1,L			; F1
	JP NZ,DisplayHELP
	JP ReadKeyboard

; got kBS, is F2 pressed also?
rkEXIT:
	BIT mF2,L			; F2
	JP Z,ReadKeyboard
	; fall through to Exit:
; Return to the OS
Exit:
	XOR A				; A=0x00
	OUT (pBANKCTRL),A	; reset bank to 0x00 before exit
	RET					; exit flag A=0x00: system reclaims program area memory

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

; Go to the help screen
DisplayHELP:
	CALL DrawTitle

	LD HL,0x2600
	CALL SETLOC
	LD HL,HelpLabel
	CALL STROUT

	LD HL,0x0001
	CALL SETLOC
	LD HL,HelpMSG_S
	CALL STROUT

	LD HL,0x0002
	CALL SETLOC
	LD HL,HelpMSG_G
	CALL STROUT

	LD HL,0x0003
	CALL SETLOC
	LD HL,HelpMSG_W
	CALL STROUT

	LD HL,0x0004
	CALL SETLOC
	LD HL,HelpMSG_P
	CALL STROUT

	LD HL,0x0005
	CALL SETLOC
	LD HL,HelpMSG_UD
	CALL STROUT

IF FLASH_SUPPORT
	CALL FlashHelp
ENDIF

	LD HL,0x0007
	CALL SETLOC
	LD HL,ExitLabel
	CALL STROUT

	LD HL,0x2407
	CALL SETLOC
	LD A,'?'
	CALL CHAROUT
	LD A,' '
	CALL CHAROUT
	LD A,'-'
	CALL CHAROUT
	LD A,' '
	CALL CHAROUT
	LD HL,HelpLabel
	CALL STROUT

	CALL GetAnyKey
	JP C_MAIN

; Add 0x80 to address pointer
NEXT:
	LD HL,(AddressPointer)
	LD DE,0x80
	ADD HL,DE
	LD (AddressPointer),HL
	JP C_MAIN

; Subtract 0x80 from address pointer
PREVIOUS:
	LD HL,(AddressPointer)
	LD DE,0x80
	OR A
	SBC HL,DE
	LD (AddressPointer),HL
	JP C_MAIN

; Go to a user requested memory location
GOTO:
	LD DE,0x4803
	LD HL,AddressMSG
	LD A,16
	CALL HexInput
	LD (AddressPointer),HL
	JP C_MAIN

; Write a value to an IO port
WRITEPORT:
	; get port number
	LD DE,0x4802
	LD HL,PortMSG
	LD A,8
	CALL HexInput
	LD C,L

	; get data
	LD DE,0x4804
	LD HL,DataMSG
	LD A,8
	CALL HexInput
	OUT (C),L

	; if port=pBANKCTRL then save data to (Bank)
	;LD A,C
	;CP pBANKCTRL
	;JP NZ,C_MAIN
	;LD A,L
	;LD (Bank),A
	JP C_MAIN

; Write a value to a memory location
; H = addrH
; L = addrL
; B = data
WRITERAM:
	; show ui if in ui mode
	LD A,(State)
	BIT StateSerial,A
	CALL Z,WriteAddrUI		; console mode
; HL = addr
; B = data
IF FLASH_SUPPORT
	;LD D,A
	; only do flash write cmd if:
	; FlashType > 0 : flash ic card detected
	; 0E < bank < 1F : rom ic card bank
	; 0x3FFF < addr < 0x8000 : rom ic card bank window addr
	LD A,(FlashType)
	OR A
	JP Z,wa3		; no flash detected
	LD A,H
	CP 0x40
	JP C,wa3		; addr < 0x4000
	CP 0x80
	JP NC,wa3	; addr !< 0x8000
	IN A,(pBANKCTRL)
	CP 0x0F
	JP C,wa3		; bank < 0x0F
	CP 0x1F
	JP NC,wa3	; bank !< 0x1F
	; met all flash criteria, do flash write
	CALL FlashByteProg
	LD E,1
	JP ENDC
wa3:
	; not flash, do normal write
	;LD A,D
ENDIF
	LD (HL),B
	LD E,1
	JP ENDC

WriteAddrUI:
	LD DE,0x4802
	LD HL,AddressMSG
	LD A,16
	CALL HexInput
	PUSH HL				; HL = addr
	LD DE,0x4804
	LD HL,DataMSG
	LD A,8
	CALL HexInput
	LD B,L				; A = data
	POP HL
	RET

; Convert ASCII hex digit in A to 4-bit value (0-15)
; Handles 0-9, A-F, a-f
h2nyb:
	CP '0'
	JP C,h2nyb_invalid		; < '0' invalid
	CP '9'+1
	JP NC,h2nyb_af			; > '9', try a-f
	SUB '0'					; '0'-'9' to 0-9
	RET
h2nyb_af:
	_toupper
	CP 'A'
	JP C,h2nyb_invalid		; < 'A' invalid
	CP 'F'+1
	JP NC,h2nyb_invalid		; > 'F' invalid
	SUB 'A'-10				; 'A'-'F' to 10-15
	RET
h2nyb_invalid:
	XOR A					; Return 0 for invalid input
	RET

; A to ascii hex pair to screen
Hex2SCR:
	PUSH AF
	PUSH BC
	PUSH DE
	LD B,A
	PUSH BC
	AND 0xF0
	RLC A
	RLC A
	RLC A
	RLC A
	CALL N2A
	POP BC
	LD A,B
	AND 0x0F
	CALL N2A
	POP DE
	POP BC
	POP AF
	RET
N2A:			; nybble to ascii
	ADD A,0x90
	DAA
	ADC A,0x40
	DAA
	CALL CHAROUT
	RET

; prompt HL
; position DE
; len A
; return HL
HexInput:
	PUSH AF
	PUSH HL
	LD HL,DE
	CALL SETLOC
	POP HL
	CALL STROUT
	LD HL,DE
	INC L
	CALL SETLOC
	LD HL,DataEntryMSG
	CALL STROUT
	LD HL,DE
	INC H
	INC H
	INC L
	CALL SETLOC
	XOR A
	CALL SETCURSORONOFF
	POP AF
	CP 16
	JP Z,GetHex16		; jump to collect 4 hex digits
	LD A,'0'			; fill first 2 digits with 00
	LD (Buffer),A
	LD (Buffer+1),A
	JP GetHex8			; jump to collect last 2 hex digits
GetHex16:				; collect 4 hex digits
	CALL CHARGET
	LD A,H
	LD (Buffer),A
	CALL CHAROUT
	CALL CHARGET
	LD A,H
	LD (Buffer+1),A
	CALL CHAROUT
GetHex8:				; collect 2 hex digits
	CALL CHARGET
	LD A,H
	LD (Buffer+2),A
	CALL CHAROUT
	CALL CHARGET
	LD A,H
	LD (Buffer+3),A
	CALL CHAROUT		; why bother? no time to see it
	LD A,1
	CALL SETCURSORONOFF
ConvertHex16:	; Convert 4 ASCII hex digits to 16-bit address
	LD HL,0				; Initialize result
	LD DE,Buffer		; Point to ASCII buffer
	LD B,4				; Process 4 digits
CH16L:
	LD A,(DE)			; Get ASCII digit
	CALL h2nyb			; Convert to 4-bit value
	; Shift HL left by 4 bits
	ADD HL,HL
	ADD HL,HL
	ADD HL,HL
	ADD HL,HL
	OR L               ; Combine nybble with L
	LD L,A             ; Update L
	INC DE             ; Next digit
	DJNZ CH16L
	RET

; Draw 8 lines of hex data
DisplayRAM:
	LD A,1
	CALL SETCURSORONOFF
	CALL CLS

	LD DE,(AddressPointer)
	LD HL,0
	LD B,8
dr0:
	CALL SETLOC
	CALL LineOfHex
	INC L
	DJNZ dr0

	LD HL,0x4900
	CALL SETLOC
	LD HL,AppName
	CALL STROUT
	LD HL,0x4C01
	CALL SETLOC
	LD HL,AppVer
	CALL STROUT

	LD HL,0x4907
	CALL SETLOC
	LD A,'?'
	CALL CHAROUT
	LD A,'-'
	CALL CHAROUT
	LD HL,HelpLabel
	CALL STROUT

	RET

; DE = addr
LineOfHex:
	PUSH BC		; save parents DJNZ
	PUSH DE		; local use
; draw the address
	LD A,D
	CALL Hex2SCR
	LD A,E
	CALL Hex2SCR
	LD A,' '
	CALL CHAROUT
; draw 16 hex pairs
	LD B,16
lh0:
	LD A,(DE)
	CALL Hex2SCR
	LD A,' '
	CALL CHAROUT
	INC DE
	DJNZ lh0
	LD A,' '
	CALL CHAROUT
; Draw the ascii equivalent of the hex data, if its a renderable ascii value
	POP DE		; reset to starting addr
	LD B,16
lh1:
	LD A,(DE)
	CALL DrawAscii
	INC DE
	DJNZ lh1
	POP BC		; restore parents DJNZ
	RET

DrawAscii:
	CP 0x20
	JP C,DrawCtrl
	CP 0xFF
	JP Z,DrawCtrl
	JP CHAROUT
; draw ctrl bytes as inverse video byte+64  (carat notation but inverse in place of ^)
DrawCtrl:
	PUSH AF
	LD A,1
	CALL SETCOLOR
	POP AF
	ADD 0x40
	CALL CHAROUT
	XOR A
	JP SETCOLOR

; end of command
; ui vs serial return
; E = serial return
ENDC:
	LD A,(State)
	BIT StateSerial,A
	JP Z,C_MAIN		; ui return
	LD A,E
	CALL txb
	JP S_MAIN		; serial return

;------------------------------------------------------------------------------
; SERIAL
;------------------------------------------------------------------------------

; Pass control over to the serial port for flash erase/writing
SerialHandler:
	LD HL,State
	SET StateSerial,(HL)		; set serial interface mode flag

	CALL DrawTitle
	LD HL,0x1500
	CALL SETLOC
	LD HL,SerialMSG
	CALL STROUT
	LD HL,0x0001
	CALL SETLOC

	; RS-232 SETUP
	; TODO: the user & service manuals both say there is no RTS/CTS or DSR/DTR,
	; but the RTS, CTS, DTR, and DSR are all wired up to IC9 (uPD71051, 8251-clone).
	; It may be possible to manually program IC9 to enable RTS/CTS.

	;LD H,8		; bps 9=19200 8=9600 7=4800 6=2400 5=1200 4=600 3=300 2=150 1=75
	;RES 7,L	; 0 0 1 1	stop bits
	;SET 6,L	; 0 1 0 1	0 1 1.5 2
	;RES 5,L	; x 0 1		parity
	;RES 4,L	; 0 1 1		none odd even
	;SET 3,L	; 0 0 1 1	data bits
	;SET 2,L	; 0 1 0 1	5 6 7 8
	;RES 1,L	; xonoff RES=disable SET=enable
	;RES 0,L	; timer interrupt RES=enable SET=disable

	LD HL,RSINIT_PARAMS
	CALL RSINIT

; top of serial interface command loop
S_MAIN:
	CALL CHARSENSE		; check local keyboard for exit key
	JP Z,sm0			; no keypress, proceed
	CP kESC				; ESC?
	JP Z,C_MAIN			; yes, quit
	CP kBS				; no, BS?
	JP NZ,sm0			; no, proceed
	BIT mF2,L			; yes, also F2?
	JP NZ,C_MAIN		; yes, quit
sm0:
	CALL rxb
	CP DLE
	JP NZ,S_MAIN	; read & discard until DLE
	CALL rxb
	LD C,A			; cmd
	CALL rxb
	LD H,A			; valH
	CALL rxb
	LD L,A			; valL
	CALL rxb
	LD B,A			; data
	LD A,C
S_CMD:
IFDEF DEBUG_SERIAL
	CALL CHAROUT
ENDIF
IF FLASH_SUPPORT
	CP 'E'
	JP Z,ERASEFLASH
ENDIF
;	CP 'Q' ; exit serial interface mode
;	JP Z,C_MAIN
;	CP 'R'
;	JP Z,ReadMemAddress
	CP 'W'
	JP Z,WRITERAM
	CP 'B'
	JP Z,SetBank
;	CP 'p'
;	JP Z,GetBank
;	CP 'X'
;	JP Z,RawWriteMemAddress
;	CP 'B'
;	JP Z,BurstReadAddress
;	CP 'V'
;	JP Z,BurstWriteAddress
	LD A,'?' ; Nack
IFDEF DEBUG_SERIAL
	CALL CHAROUT
ENDIF
	CALL txb
	JP S_MAIN

SetBank:
	LD A,B
	OUT (pBANKCTRL),A
GetBank:
	IN A,(pBANKCTRL)
	CALL txb
	JP S_MAIN

;ReadMemAddress:
;	; Wait for 2 bytes in the serial rx buffer
;	CALL GETDATALEN
;	LD A,L
;	CP 2
;	JP NZ,ReadMemAddress
;	CALL GETDATA
;	LD H,A
;	CALL GETDATA
;	LD L,A
;	LD A,(HL)
;	CALL SENDDATA
;	JP S_MAIN
;
;RawWriteMemAddress:
;Wait for 3 bytes in the serial rx buffer
;	CALL GETDATALEN
;	LD A,L
;	CP 3
;	JP NZ,RawWriteMemAddress
;	CALL GETDATA
;	LD H,A
;	CALL GETDATA
;    LD L,A
;    CALL GETDATA
;    LD (HL),A
;    LD A,1 ;ack
;    CALL SENDDATA
;    JP S_MAIN

;BurstReadAddress:
;    ; Wait for 3 bytes: addrHi, addrLo, count
;    CALL GETDATALEN
;    LD A,L
;    CP 3
;    JP NZ,BurstReadAddress
;    CALL GETDATA
;    LD H,A
;    CALL GETDATA
;    LD L,A
;    CALL GETDATA
;    LD B,A
;br0:
;    LD A,(HL)
;    CALL SENDDATA
;    INC HL
;    DJNZ br0
;    JP S_MAIN
;
;BurstWriteAddress:
;    CALL GETDATALEN
;    LD A,L
;    CP 10        ; wait for addr(2) + data(8) = 10 bytes total
;    JP NZ,BurstWriteAddress
;    CALL GETDATA
;    LD H,A
;    CALL GETDATA
;    LD L,A
;    LD B,8       ; fixed burst of 8 bytes
;bw0:
;    PUSH BC
;    CALL GETDATA
;IF FLASH_SUPPORT
;	; FIXME - flash-vs-mem like WRITERAM
;    PUSH AF
;    LD A,fcByteProg
;    CALL FlashCMD
;    POP AF
;ENDIF
;    LD (HL),A
;bw1:
;    LD C,(HL)
;    LD A,(HL)
;    CP C
;    JP NZ,bw1
;    INC HL
;    POP BC
;    DJNZ bw0
;    LD A,1
;    CALL SENDDATA
;    JP S_MAIN

;------------------------------------------------------------------------------
IF FLASH_SUPPORT
;------------------------------------------------------------------------------

; wait for flash cmd to complete (2 consecutive reads match)
WaitFlashBusy:
	LD A,(aROMWINDOW)
wfb0:
	LD L,A
	LD A,(aROMWINDOW)
	CP L
	JP NZ,wfb0
	RET

; HL = addr
; D = data
FlashByteProg:
	LD A,fcByteProg
	CALL FlashCMD
	LD (HL),D
	JP WaitFlashBusy

FlashHelp:
	LD A,(FlashType)
	OR A
	RET Z
	LD HL,0x0006
	CALL SETLOC
	LD HL,HelpMSG_E
	CALL STROUT
	CALL PrintFlashType
	RET

PrintFlashType:
	LD A,' '
	CALL CHAROUT
	LD A,'('
	CALL CHAROUT
	LD A,(FlashType)
	CALL Hex2SCR
	LD A,')'
	CALL CHAROUT
	RET

ERASEFLASH:
	; abort if not flash
	LD A,(FlashType)
	LD E,A
	OR E
	JP Z,ENDC

	; show ui if in ui mode
	LD A,(State)
	BIT StateSerial,A
	CALL Z,EraseFlashUI	; console ui
	LD A,fcErase
	CALL FlashCMD
	LD A,fcEraseChip
	CALL FlashCMD
	CALL WaitFlashBusy
	LD E,1
	JP ENDC

EraseFlashUI:
	; draw prompt
	CALL DrawTitle
	LD HL,0x0001
	CALL SETLOC
	LD HL,EraseMSG
	CALL STROUT
	CALL KILLBUF
	XOR A
	CALL SETCURSORONOFF
	CALL CHARGET
	LD A,H
	_toupper
	CP A,'Y'
	RET NZ
	LD HL,0x0002
	CALL SETLOC
	LD HL,ErasingMSG
	JP STROUT

; We don't actually do anything different depending on chip_id any more
; except to overall enable/disable writing if we recognize any flash at all.
TestForFlash: ; CFI query

;	LD A,0x10
;	LD H,' '
;	LD L,0
;	CALL DBGp

	IN A,(pBANKCTRL)
	LD B,A					; remember initial bank
	LD A,fcGetId
	CALL FlashCMD			; send the flash get_id command
	LD A,0x0F
	OUT (pBANKCTRL),A	; select rom ic bank 0
	LD A,(aROMWINDOW)		; read the mfr id
	LD L,A
	LD A,B
	OUT (pBANKCTRL),A		; restore bank setting
	; do we recognize the mfr id?
	LD A,L
	CP ID_SST	; SST / Greenliant / Microchip
	JP Z,tf0
	CP ID_MX	; Macronix
	JP Z,tf0
	CP ID_ST	; STMicro
	JP Z,tf0
	CP ID_AM	; AMD
	JP Z,tf0
	CP ID_AT	; Atmel
	JP Z,tf0
	; no flash recognized
	XOR A
tf0:
	LD (FlashType),A	; store the result
	OR A
	RET Z			; skip the rest if no flash
	LD A,fcExitId
;	JP FlashCMD	; reset the chip out of command mode
;   fall through to FlashCMD
FlashCMD: ; CMD in A
	PUSH BC
	PUSH DE
	PUSH HL
	LD D,A

;	LD A,0x20
;	LD H,'C'
;	LD L,C
;	CALL DBGp

	; FIXME - WHY THE F IS THIS ?
	; ?????????????????????????????????????????????????????????????????????????
	; For some reason you must overwrite A with XOR or LD(any value)
	; before this particular IN. If you do not,
	; then E will contain the incoming A as if the IN never happened.
	; ?????????????????????????????????????????????????????????????????????????
	XOR A
	IN A,(pBANKCTRL)
	LD E,A

	;LD A,0x21
	;LD H,'E'
	;LD L,E
	;CALL DBGp

	; address and bank number transformations
	;
	; rom bank window is 0x4000-0x7FFF
	; banks 0-15 on a rom ic are banks 0F-1E in the system
	;
	; bank_window_addr = 0x4000
	; bank_len = 0x4000
	; 1st_rom_ic_bank = 0x0F
	; 
	; bank@ic = [addr@ic/bank_len]          (division without remainder)
	; bank = bank@ic + 1st_rom_ic_bank
	; addr = addr@ic - (bank@ic * bank_len) + bank_window_addr
	;
	; bank = bank@ic + 0x0F
	; addr = addr@ic - (bank@ic * 0x4000) + 0x4000

	; flash command sequence is: 0x5555<0xAA, 0x2AAA<0x55, 0x5555<CMD

	; write 0xAA to addr@ic 0x5555
	LD A,0x10			; bank = [0x5555/0x4000] + 0x0F = 0x10
	OUT (pBANKCTRL),A
	LD A,0xAA
	LD (0x5555),A		; addr = 0x5555 - ([0x5555/0x4000] * 0x4000) + 0x4000 = 0x5555

	; write 0x55 to addr 0x2AAA
	LD A,0x0F			; bank = [0x2AAA/0x4000] + 0x0F = 0x0F
	OUT (pBANKCTRL),A
	LD A,0x55
	LD (0x6AAA),A		; addr = 0x2AAA - ([0x2AAA/0x4000] * 0x4000) + 0x4000 = 0x6AAA

	; write CMD to addr 0x5555
	LD A,0x10			; bank = [0x5555/0x4000] + 0x0F = 0x10
	OUT (pBANKCTRL),A
	LD A,D
	LD (0x5555),A		; addr = 0x5555 - ([0x5555/0x4000] * 0x4000) + 0x4000 = 0x5555

	; restore initial bank settimg

	;LD A,0x22
	;LD H,'E'
	;LD L,E
	;CALL DBGp

	LD A,E
	OUT (pBANKCTRL),A

	;LD A,0x23
	;LD H,' '
	;LD L,0
	;CALL DBGp

	POP HL
	POP DE
	POP BC
	RET

;------------------------------------------------------------------------------
ENDIF ; /FLASH
;------------------------------------------------------------------------------

toupper:
	CP 'a'
	RET C
	CP 'z'+1
	RET NC
	_toupper
	RET

; receive serial byte
; if DLE, discard and read another byte and xor 0x40
rxb:
	CALL GETDATA
	JP Z,rxb
	CP DLE
	RET NZ
rx0:
	CALL GETDATA
	JP Z,rx0
	XOR 0x40
	RET

; send serial byte
; if DLE,XON,XOFF, send DLE then A xor 0x40
txb:
	CP DLE			; if outgoing data is DLE
	JP Z,tx1
	CP XON			; ... or XON
	JP Z,tx1
	CP XOFF			; ... or XOFF
	JP Z,tx1		; then encode it, else...
tx0:				; send data
	CALL SENDDATA
	JP C,tx0		; retry until sent
	RET
tx1:				; send DLE prefix
	LD D,A
	LD A,DLE
tx2:
	CALL SENDDATA
	JP C,tx2		; retry until sent
	LD A,D
	XOR 0x40		; transform data
	JP tx0

IFDEF DEBUG
; A = breakpoint number
; H = register name
; L = register value
; print debug & wait for keystroke
DBGp:
	CALL DBG
	JP CHARGET
; print debug data
DBG:
	PUSH HL
	LD HL,0x4606
	CALL SETLOC
	CALL Hex2SCR	; print A / breakpoint number
	LD A,':'
	CALl CHAROUT
	POP HL
	LD A,H
	CALL CHAROUT	; print H / register name
	LD A,L
	CALL Hex2SCR	; print L / register value
	LD A,'b'
	CALL CHAROUT
	IN A,(pBANKCTRL)
	JP Hex2SCR		; print bank value
ENDIF

;------------------------------------------------------------------------------
; Variables, Constatnts, Strings
;------------------------------------------------------------------------------

ALIGN 2

AddressPointer:
	DW 0;

FlashType:
	DB 0

Buffer:
	DS 4

State:
	DB 0

AddressMSG:
	DB "Address?",0

PortMSG:
	DB "Port?",0

DataMSG:
	DB "Data?",0

SerialMSG:
	DB "Serial Interface Active (9600,8n1)",0

HelpMSG_S:
	DB "S - Serial interface mode",0
HelpMSG_G:
	DB "G - Go to address (rom bank window: 4000-7FFF)",0
HelpMSG_W:
	DB "W - Write a byte to a memory address",0
HelpMSG_P:
	DB "P - Write to I/O port (set rom ic card bank: port 51 data 0F-1E)",0
HelpMSG_UD:
	DB "Up/Dn - Move by 0x80",0

IF FLASH_SUPPORT
HelpMSG_E:
	DB "E - Erase Flash IC Card",0
EraseMSG:
	DB "Are you sure you want to erase the flash card? (y/N)",0
ErasingMSG:
	DB "Erasing...",0
ENDIF

ExitLabel:
	DB "Cncl - EXIT",0

HelpLabel:
	DB "HELP",0

AnyKeyMSG:
	DB "[Press any key]",0

DataEntryMSG:
	DB "0x    ",0

AppName:
	DB "MemUtil",0

AppVer:
	DB "1.09",0

PRGEND:
