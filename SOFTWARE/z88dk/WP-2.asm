; Template asm for WP-2 executable
; z88dk-z80asm compiler, geany code editor

; geany setup:
; - Install /usr/share/geany/filedefs/filetypes.Z80asm.conf
; - Document -> Set Filetype -> Programming Languages -> Z80asm source file

; build RUN file : z88dk-z80asm -b -o=foo.PR foo.asm
; build ROM image: z88dk-z80asm -DROM -b -o=foo.PI foo.asm

; WP-2 System ROM Calls
CMPHLDE			EQU		0x0020	; Compare HL to DE
CHARSENSE		EQU		0x0100	; Check keyboard buffer, nonblocking get status
CHARGET			EQU		0x0103	; Get one character, wait for input
KILLBUF			EQU		0x0106	; Kill key buffer
SETLOC			EQU		0x0109	; Set cursor location
GETLOC			EQU		0x010C	; Get cursor location
SETCURSORONOFF	EQU		0x010F	; Set cursor on/off
SETCURSORTYPE	EQU		0x0112	; Set cursor type
SETCOLOR		EQU		0x0115	; Set character color
CHAROUT			EQU		0x0118	; Output character to console, no esc seq
PUTCHAR			EQU		0x01A3	; Output character to console, support esc seq
STROUT			EQU		0x011B	; Output string to console, no esc seq
CLS				EQU		0x011E	; Clear screen
BEEP			EQU		0x0121	; Beep a buzzer
CHECKCNCL		EQU		0x0124	; Check that CNCL key is pressed NOW
PRNOUT			EQU		0x0130	; Output one byte of data to printer
PRNSTATUS		EQU		0x0133	; Check printer status
READSLOT		EQU		0x0160	; Read data in a slot
CHGSLOT			EQU		0x0166	; Change slots
RSINIT			EQU		0x0140	; Initialize RS232C (Baud rate etc...)
GETDATALEN		EQU		0x0143	; Get the length of effective data in aux-buffer
SENDDATA		EQU		0x0146	; Output one byte of data to RS232C
GETDATA			EQU		0x0149	; Get data from the aux-buffer
RSCLOSE			EQU		0x014C	; Close RS232C
TAPEIN			EQU		0x0150	; Read data from tape
TAPEOUT			EQU		0x0153	; Write data to tape
MOTORON			EQU		0x0156	; Motor on
MOTOROFF		EQU		0x0159	; Motor off
SYNCREAD		EQU		0x0169	; Read Sync
SYNCWRITE		EQU		0x016C	; Write Sync
LINEIN			EQU		0x01A6	; Cooked line input
LINEIN2			EQU		0x01AC	; Cooked line input with default string
UNGETFORLINP	EQU		0x01A9	; Unget Char for LINEIN and LINEIN2
MALLOC			EQU		0x0170	; Memory allocation
MCHGSIZE		EQU		0x0173	; Changes the size of mALLOCed BLOCK
MFREE			EQU		0x0176	; Free mALLOCed BLOCK
MCLOSE			EQU		0x017C	; Close (save) mALLOCed BLOCK
MNAME			EQU		0x017F	; Names the mALLOCed BLOCK - must before MCLOSE
LIST0			EQU		0x0182	; Initialize file listing - must before LIST
LIST			EQU		0x0185	; Get the file list
OPEN			EQU		0x0188	; Opena file
READ			EQU		0x018B	; Read a file
WRITE			EQU		0x018E	; Write a file
CLOSE			EQU		0x0191	; Close a file
DELETE			EQU		0x0194	; Delete a file
RENAME			EQU		0x0197	; Rename a file
FORMAT			EQU		0X019A	; Format a disk-device
DEVROOM			EQU		0x01C1	; Get devices rest size (remaining 128-byte blocks)
SEEK			EQU		0x01BE	; Seek file pointer - only ram disk & ic card ram disk
WAIT			EQU		0x01A0	; Wait for fixed time in 0.1s
RUNIC			EQU		0x01AF	; Run IC card program
RUNFILE			EQU		0x01B2	; Run a program file
POFFCOUNTPOINTER	EQU	0x01B5	; Get power off counter pointer
SETBTYPE		EQU		0x01B8	; Set battery type
GETWORK			EQU		0x01BB	; Get work area

; I/O Ports
pBANKCTL	EQU		0x51

; Memory Addresses
aROMWINDOW	EQU		0x4000
szROMBANK	EQU		0x4000
aRAMWINDOW	EQU		0x8000
szRAMBANK	EQU		0x8000
aWORKAREA	EQU		0xAC00

; RST Hooks
hBREAK		EQU		0x28	; debug hook table break pointer
hCALLFAR	EQU		0x30	; Call a routine in another slot
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


;------------------------------------------------------------------------------
; HEADER
;------------------------------------------------------------------------------
IFDEF ROM	; Header for WP-2 executable ROM image

ORG aROMWINDOW	; rom bank window
DB "PI"			; ID
DW 0			; reserved
DB 0x0F			; bank number (15-31), 0x0F = first 16k of rom ic card
DW START		; entry addr ; error in service manual, says DB
DW 0			; reserved

ELSE		; Header for WP-2 executable RUN file

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

; ...program code...

EXIT:
IFDEF ROM
	RET Z
ELSE
	XOR A
	RET
ENDIF

; ...program code...

PRGEND:
END:
