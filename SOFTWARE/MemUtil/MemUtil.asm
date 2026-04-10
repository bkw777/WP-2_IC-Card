; MemUtil - Brian K. White
; Forked from HexViewer 2.2 - Ben Grimmett
; Compile to RUN File:  z88dk-z80asm -v -b -o=foo.PR foo.asm
; Compile to ROM Image: z88dk-z80asm -v -DROM -b -o=foo.PI foo.asm
;
; TODO: figure out the limits/rules about the file size
; TODO: figure out how to do "sub run files" to get past the size limit
;
; MYSTERY
; When the output file grows past ~2024 bytes there is some sort of
; truncation or corruption when the OS loads the file into ram to run.
; The help screen text is truncated mid way and ends with 3 bytes of some kind
; of binary, and it's always the same 3 bytes. Yet, the other strings that come
; later in the asm source are still present? Only HelpMSG# gets corrupted.
; And the program still runs and works.
; I think the 3 bytes are the same that always appear after the padding 0x1A's
; at the end of the file in ram ...1A 1A 1A 46 F9 03
;
; ROM target is not fully working but it builds, runs, partly works, returns.
; All flash functions ifdef'ed out when compiling for ROM as simply the initial
; crude way to avoid the conflict of touching the hardware you're running from.
;

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
pBANKCTL	EQU		0x51

; Memory Addresses
aROMWINDOW	EQU		0x4000
szROMBANK	EQU		0x4000
aRAMWINDOW	EQU		0x8000
szRAMBANK	EQU		0x8000
aWORKAREA	EQU		0xAC00

; RST Hooks
;hBREAK		EQU		0x28	; debug hook table break pointer
;hCALLFAR	EQU		0x30	; Call a routine in another slot
;	RST hCALLFAR
;	DB slot
;	DW addr

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
mGRPH		EQU		6	; BIT mGRPH,L NZ = either GRPH or CODE mode is active
mCODE		EQU		7	; If mGRPH, Then: BIT mCODE,L Z = GRPH, NZ = CODE


; Flash chip manufacturer IDs
; 0x5555/0x2AAA actually works on all, 0x555/0x2AA does not
ID_SST		EQU		0xBF	; SST	SST39SF020A-70-4C-TU		5555:AA	2AAA:55
							; Greenliant GLS29EE010-70-4C-WHE	5555:AA	2AAA:55
ID_MX		EQU		0xC2	; MXIC	MX29F040CTI-70G				555:AA	2AA:55
ID_ST		EQU		0x20	; STM	M29F512B-70NZ				555:AA	2AA:55
ID_AM		EQU		0x01	; AMD	AM29F010-70EC				5555:AA	2AAA:55
ID_AT		EQU		0x1F	; Atmel	AT29C010A-70TC				5555:AA	2AAA:55
							; Atmel	AT28C010-12TU				5555:AA	2AAA:55
ID_MXs 		EQU 	0x43	; not a real mfr id, MX chip on borked PCB design

;------------------------------------------------------------------------------
; HEADER
;------------------------------------------------------------------------------
IFDEF ROM	; Header for WP-2 executable ROM image
FLASH		EQU 0

ORG aROMWINDOW	; rom bank window start
DB "PI"			; ID
DW 0			; reserved
DB 0x0F			; bank number (15-31), bank 15 is the first 16k of the rom ic 
DW START		; entry addr  ; Error in service manual, says DB
DW 0			; reserved

ELSE		; Header for WP-2 executable RUN-file
FLASH		EQU 1

ORG aWORKAREA-8	; application work area
DB "PR"			; ID
DW PRGEND-PRGTOP+1	; length
DW START		; entry addr
DW 0			; located addr (0="here")

ENDIF

;------------------------------------------------------------------------------
; BODY
;------------------------------------------------------------------------------
PRGTOP:
START:


;------------------------------------------------------------------------------
; CONSOLE
;------------------------------------------------------------------------------
IF FLASH
	CALL TestForFlash
ENDIF

MAIN:
	CALL DisplayRAM

ReadKeyboard:
	CALL KILLBUF
	CALL CHARGET
	LD A,H

	CP kUP
	JP Z,PREVIOUS
	CP kDOWN
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
IF FLASH
	CP 'E'
	JP Z,ERASEFLASH
	CP 'e'
	JP Z,ERASEFLASH
ENDIF
	CP 'S'
	JP Z,SerialHandler
	CP 's'
	JP Z,SerialHandler

	; Help on either '?' or HELP (F1+1)
	CP '?'
	JP Z,DisplayHELP
	CP '1'				; F1+1 = HELP
	JP Z,RKHELP			; check F1

	; Exit on either Esc or EXIT
	CP kESC
	JP Z,Exit
	CP kBS				; F2+BS = EXIT
	JP Z,RKEXIT			; check F2

	JP ReadKeyboard

; got '1', is F1 pressed also?
RKHELP:
	BIT mF1,L			; F1
	JP NZ,DisplayHELP
	JP ReadKeyboard

; got kBS, is F2 pressed also?
RKEXIT:
	BIT mF2,L			; F2
	JP Z,ReadKeyboard
	; fall through to Exit:
; Return to the OS
Exit:
	XOR A
	OUT (pBANKCTL),A
IFDEF ROM
	RET Z
ELSE
	RET
ENDIF

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

IF FLASH
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
	JP MAIN

; Add 0x80 to address pointer
NEXT:
	LD HL,(AddressPointer)
	LD DE,0x80
	ADD HL,DE
	LD (AddressPointer),HL
	JP MAIN

; Subtract 0x80 from address pointer
PREVIOUS:
	LD HL,(AddressPointer)
	LD DE,0x80
	OR A
	SBC HL,DE
	LD (AddressPointer),HL
	JP MAIN

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
	JP MAIN

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
	LD (TempBank),A

	LD A,1
	CALL SETCURSORONOFF
	JP MAIN

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

IF FLASH
	; TODO test actual proper conditions before deciding flash write:
	; * addr >= aRomBank
	; * addr < aRomBank + lRomBank
	; * current bank >= 0F
	; * current bank <= 1F
	; Check if HL < 0x8000
	LD A,H
	CP 0x80
	JP C,Write2Flash  ; Jump if HL < 0x8000 (carry set means H < 0x80)
ENDIF

	POP AF
	LD (HL),A
	LD A,1
	CALL SETCURSORONOFF
	JP MAIN

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

	LD HL,0x4907
	CALL SETLOC
	LD A,'?'
	CALL CHAROUT
	LD A,'-'
	CALL CHAROUT
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

;------------------------------------------------------------------------------
; /CONSOLE
;------------------------------------------------------------------------------


;------------------------------------------------------------------------------
; SERIAL
;------------------------------------------------------------------------------

; Pass control over to the serial port for flash erase/writing
SerialHandler:
	CALL DrawTitle
	LD HL,0x1503
	CALL SETLOC
	LD HL,SerialMSG
	CALL STROUT

	; RS-232 SETUP
	; TODO: the user & service manuals both say there is no RTS/CTS or DSR/DTR,
	; but the RTS, CTS, DTR, and DSR are all wired up to IC9 (uPD71051, 8251-clone).
	; So presumably it should be possible to manually program IC9 to enable RTS/CTS.
	; TODO: test if maybe it's already silently doing RTS/CTS by default.
	LD HL,0x084C ; 9600, 8n1, no xonoff, timer enabled
	CALL RSINIT

SH1:
	CALL GETDATA
	JP NZ,SerialDataRX
	CALL CHARSENSE
	JP Z,SH1 ; no data from keyboard, loop

	; Key pressed - exit loop if Esc or EXIT (F2+BS)
	CP kESC		; ESC?
	JP Z,MAIN	; yes, quit
	CP kBS		; no, BS?
	JP NZ,SH1	; no, loop
	BIT mF2,L	; yes, also F2?
	JP NZ,MAIN	; yes, quit
	JP SH1		; loop

SerialDataRX:
	; Received Serial byte is in A
IF FLASH
	CP 'E' ; erase command
	JP Z,SerialErase
ENDIF
	CP 'Q' ; Quit Serial handler
	JP Z,MAIN
	CP 'R' ; Read Mem address
	JP Z,ReadMemAddress
	CP 'W' ; write Mem address
	JP Z,WriteMemAddress
	CP 'P' ; write port 51
	JP Z,WritePort51
	CP 'p' ; read port 51
	JP Z,ReadPort51
	CP 'X' ; raw write mem
	JP Z,RawWriteMemAddress
	LD A,'?' ; Nack
	CALL SENDDATA
	JP MAIN

WritePort51:
	CALL GETDATA
	JP Z,WritePort51 ; loop immediate
;	JP NZ,wp51a      ; sleep 100ms then loop
;	LD A,1
;	CALL WAIT
;	JP WritePort51
;wp51a:
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
IF FLASH
	; Check if HL < 0x8000
	PUSH AF
	LD A,H
	CP 0x80
	JP C,S_WriteFlashAddress ; Jump if HL < 0x8000 (carry set means H < 80h)
	POP AF
ENDIF
	LD (HL),A

	LD A,1 ; ack
	CALL SENDDATA
	JP SH1

RawWriteMemAddress:
    ;Wait for 3 bytes in the serial rx buffer
    CALL GETDATALEN
    LD A,L
    CP 3
    JP NZ,RawWriteMemAddress
    CALL GETDATA
    PUSH AF
    CALL GETDATA
    LD L,A
    POP AF
    LD H,A
    PUSH HL
    CALL GETDATA
    POP HL
    LD (HL),A
    LD A,1 ;ack
    CALL SENDDATA
    JP SH1

;------------------------------------------------------------------------------
; /SERIAL
;------------------------------------------------------------------------------

;------------------------------------------------------------------------------
IF FLASH
;------------------------------------------------------------------------------

FlashHelp:
	LD A,(FlashType)
	CP 0
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

Write2Flash:
	POP AF
	; change this to write to the flash
	PUSH HL
	PUSH AF

	LD A,0xA0
	CALL FlashPreamble ; start flash write cmd

	LD A,(TempBank)
	OUT (pBANKCTL),A ; switch to flash bank

	POP AF ; restore data byte to A
	POP HL ; restore addr to HL
	LD (HL),A	; write data to addr

; works, just not needed
;	LD	B,0xFF ; abort counter
;	LD C,A
;wffw: ; wait for flash complete
;	LD A,(HL)
;	CP C
;	JP Z,wffe
;	DJNZ wffe	; if we tried 256 times then give up
;;	LD A,1
;;	CALL WAIT	; sleep 100ms
;	JP wffw
;wffe:

	LD A,1
	CALL SETCURSORONOFF

; works, just not needed now
;----DEBUG--------------
; show how many loops it took to write
; ...answer: always 01
;	LD HL,0x4806
;	CALL SETLOC
;	LD A,0xFF
;	SUB B
;	CALL Hex2SCR
;	CALL CHARGET
;	CALL KILLBUF
;-----------------------

	JP MAIN

ERASEFLASH:
	LD A,(FlashType)
	CP 0
	JP Z,MAIN
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
	JP NZ,MAIN
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
	LD A,(aROMWINDOW)
	LD B,A
	LD A,(aROMWINDOW)
	CP A,B
	JP NZ, w4fe

	LD A,0xF0
	CALL FlashPreamble

	POP AF
	OUT (pBANKCTL),A ; restore current bank
	JP MAIN

; We don't actually do anything different depending on chip_id any more
; except to overall enable/disable writing if we recognize any flash at all.
TestForFlash: ; CFI query
	IN A,(pBANKCTL) ; backup current bank
	PUSH AF

	LD A,0x90
	CALL FlashPreamble
	LD A,(aROMWINDOW)
	CP ID_SST	; SST / Greenliant / Microchip
	JP Z,TF2
	CP ID_MX	; Macronix
	JP Z,TF2
	CP ID_ST	; STMicro
	JP Z,TF2
	CP ID_AM	; AMD
	JP Z,TF2
	CP ID_AT	; Atmel
	JP Z,TF2

	; no flash found
	XOR A

TF2:
	; remember whaever we found
	LD (FlashType),A	; store the finding
	CP 0
	JP Z,TFend			; skip the rest if no flash
	LD A,0xF0
	CALL FlashPreamble	; reset the chip out of command mode
TFend:
	POP AF
	OUT (pBANKCTL),A ; restore current bank
	RET

FlashPreamble: ; command in A
	PUSH BC	; stash B
	LD B,A	; save COMMAND in B
	;LD C,pBANKCTL ; we never use it between here & pop?

	; flash command sequence = 0x5555<0xAA, 0x2AAA<0x55, 0x5555<COMMAND
	; bank@ic = [addr@ic/banklen]   (division without remainder)
	; bank = bank@ic + 0x0F
	; addr = addr@ic - (bank@ic * banklen) + bankwindowaddr
	; addr = addr@ic - (bank@ic * 0x4000) + 0x4000

	; write 0xAA to addr 0x5555
	LD A,0x10 ; addr 0x5555/0x4000 = bank 1 + 0x0F = 0x10
	OUT (pBANKCTL),A ; set flash bank 1
	LD A,0xAA
	LD (0x5555),A ; addr 0x5555 - (1*0x4000) + 0x4000 = same 0x5555

	; write 0x55 to addr 0x2AAA
	LD A,0x0F ; addr 0x2AAA/0x4000 = bank 0 + 0x0F = 0x0F
	OUT (pBANKCTL),A ; set flash bank 0
	LD A,0x55
	LD (0x6AAA),A ; addr 0x2AAA - (0*0x4000) + 0x4000 = 0x6AAA

	; write COMMAND (saved in B) to addr 0x5555
	LD A,0x10
	OUT (pBANKCTL),A ; set flash bank 1
	LD A,B
	LD (0x5555),A

	POP BC
	RET

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

S_WriteFlashAddress:

	POP AF
	; change this to write to the flash
	PUSH HL
	PUSH AF

	LD A,0xA0
	CALL FlashPreamble

	LD A,(TempBank)
	OUT (pBANKCTL),A
	POP AF
	POP HL
	LD (HL),A

	LD B,0xFF ; abort counter
	LD C,A
wfa1: ; wait for flash complete
	LD A,(HL)
	CP C
	JP Z,wfa2 ; write done
	DJNZ wfa2 ; abort after 256 tries
	JP wfa1 ; retry
wfa2:
	LD A,1 ;ack
	CALL SENDDATA
	JP SH1

;------------------------------------------------------------------------------
ENDIF ; /FLASH
;------------------------------------------------------------------------------


;------------------------------------------------------------------------------
; Variables, Constatnts, Strings
;------------------------------------------------------------------------------

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
	DB "P - Write to I/O port (set rom ic card bank: port 51 data 0F-1F)",0
HelpMSG_UD:
	DB "Up/Dn - Move by 0x80",0

IF FLASH
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
	DB "v1.6",0

;------------------------------------------------------------------------------
; /Variables, Constatnts, Strings
;------------------------------------------------------------------------------

PRGEND:
