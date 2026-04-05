; MemUtil 1.0 - Brian K. White
; Forked from HexViewer 2.2 - Ben Grimmett
; compile: z88dk-z80asm -v -b -o=foo.PR foo.asm
; start tpdd: dl -v -c wp2
; On WP-2 F2+= -> "DISKETTE", F1+1 -> Copy
; copy foo.PR from "DISKETTE" to "RAM DISK" or "RAM CARD", or run (F2+7) directly from "DISKETTE"

CLS EQU 0x011E
CHARSENSE EQU 0x0100
GETCH EQU 0x0103
PUTCH EQU 0x01A3
PUTSTR EQU 0x011B
RSINIT EQU 0x0140
SENDDATA EQU 0x0146
GETDATA EQU 0x0149
GETDATALEN EQU 0x0143
RSCLOSE EQU 0x014C
SETLOC EQU 0x0109
GETLOC EQU 0x010C
SETCURSORONOFF EQU 0x010F
SETCURSORTYPE EQU 0x0112

ST EQU 0x01
MX EQU 0x02
MXs EQU 0x03

BKSP EQU 0x08

PORT_BANK_CTL EQU 0x51

;IF ON-ROM
;
; WP-2 "RUN File" header for executable ROM image
;ORG 0x4000
;DB "PI"
;DW 0
;DB 0x0F
;DB PRGSTART
;DW 0
;
;ELSE
;
; WP-2 "RUN file" header for executable RAM file
ORG 0xAC00-8
DB "PR"
;DW 256 * 8 ;PRGEND - PRGSTART + 1
DW PRGEND - PRGSTART + 1
DW PRGSTART
DW 0
;
;ENDIF

PRGSTART:
	CALL TestForFlash

START:
	LD DE,(AddressPointer)
	CALL DisplayRAM

ReadKeyboard:

	LD A,(MonitorEnabled)
	CP 0
	JR Z,MonDisabled

	DI
	LD A,6
	OUT (0),A
	IN A,(0)
	PUSH AF
	EI
	LD HL,0x4801
	CALL SETLOC
	LD HL,PortMSG
	CALL PUTSTR
	LD HL,0x4802
	CALL SETLOC
	POP AF
	CALL Hex2SCR

	CALL CHARSENSE
	LD A,H

	; Command line interpreter of sorts...
	CP 'm'
	JP Z,MonitorPort
	CP 'M'
	JP Z,MonitorPort
	JP ReadKeyboard

MonDisabled:

	CALL GETCH
	LD A,H

	; Command line interpreter of sorts...
	CP 'G'
	JR Z,GOTO
	CP 'g'
	JR Z,GOTO
	CP 'W'
	JP Z,WRITERAM
	CP 'w'
	JP Z,WRITERAM
	CP 'P'
	JP Z,WRITEPORT
	CP 'p'
	JP Z,WRITEPORT
;	CP 'O'
;	JP Z,WRITEPORT
;	CP 'o'
;	JP Z,WRITEPORT
	CP 'E'
	JP Z,ERASEFLASH
	CP 'e'
	JP Z,ERASEFLASH
	CP 'S'
	JP Z,SerialHandler
	CP 's'
	JP Z,SerialHandler
	CP 'm'
	JP Z,MonitorPort
	CP 'M'
	JP Z,MonitorPort
;	CP 'f'
;	JP Z,QueryFlash
;	CP 'F'
;	JP Z,QueryFlash
	CP '?'
	JP Z,HELP

	CP 0x1F
	JR Z,NEXT
	CP 0x1E
	JR Z,PREVIOUS

	BIT 0,L ; Check if F2 is held
	JP Z,ReadKeyboard ; If it's not, read the keyboard again
	CP BKSP ; If it is, check if Del/Bksp is being held - F2+Bksp = Exit
	JP NZ,ReadKeyboard ; If not, read the keyboard again

; Return to the OS
Exit:
	XOR A
	OUT (PORT_BANK_CTL),A
	RET

; Go to the help screen
HELP:
	LD HL,Instructions
	LD (AddressPointer),HL
	JMP START

; Add 0x80 to address pointer
NEXT:
	LD HL,(AddressPointer)
	LD DE,0x80
	ADD HL,DE
	LD (AddressPointer),HL
	JMP START

; Subtract 0x80 from address pointer
PREVIOUS:
	LD HL,(AddressPointer)
	LD DE,0x80
	OR A
	SBC HL,DE
	LD (AddressPointer),HL
	JMP START

; Go to a user requested memory location
GOTO:
	LD HL,0x4801
	CALL SETLOC
	LD HL,AddressMSG
	CALL PUTSTR
	LD HL,0x4802
	CALL SETLOC
	LD A,'>'
	CALL PUTCH
	LD A,0
	CALL SETCURSORTYPE
	LD A,0
	CALL SETCURSORONOFF
	LD HL,0x4902
	CALL SETLOC

	CALL Get16bitFromUser ; returns value in HL
	LD (AddressPointer),HL

	LD A,1
	CALL SETCURSORONOFF
	JMP START

MonitorPort:

	LD A,(MonitorEnabled)
	CP 1
	JR NZ, dontturnoff
	XOR A
	LD (MonitorEnabled),a

	JMP START

dontturnoff:
	LD HL,0x4801
	CALL SETLOC
	LD HL,PortMSG
	CALL PUTSTR
	LD HL,0x4802
	CALL SETLOC
	LD A,'>'
	CALL PUTCH

	LD A,0
	CALL SETCURSORTYPE
	LD A,0
	CALL SETCURSORONOFF
	LD HL,0x4902
	CALL SETLOC

	CALL Get8bitFromUser
	LD (MonitorPortAddress),A
	LD A,1
	LD (MonitorEnabled),A
	LD A,1
	CALL SETCURSORONOFF
	JMP START

; Write a value to an IO port
WRITEPORT:
	LD HL,0x4801
	CALL SETLOC
	LD HL,PortMSG
	CALL PUTSTR
	LD HL,0x4802
	CALL SETLOC
	LD A,'>'
	CALL PUTCH

	LD A,0
	CALL SETCURSORTYPE
	LD A,0
	CALL SETCURSORONOFF
	LD HL,0x4902
	CALL SETLOC

	CALL Get8bitFromUser
	PUSH AF

	LD HL,0x4801
	CALL SETLOC
	LD HL,DataMSG
	CALL PUTSTR
	LD HL,0x4802
	CALL SETLOC
	LD A,'>'
	CALL PUTCH
	LD A,' '
	CALL PUTCH
	LD A,' '
	CALL PUTCH
	LD A,' '
	CALL PUTCH
	LD A,' '
	CALL PUTCH
	LD HL,0x4902
	CALL SETLOC

	POP AF
	LD C,A
	CALL Get8bitFromUser

	OUT (C),A

	LD A,1
	CALL SETCURSORONOFF
	JMP START

; Write a value to a memory location
WRITERAM:
	LD HL,0x4801
	CALL SETLOC
	LD HL,AddressMSG
	CALL PUTSTR
	LD HL,0x4802
	CALL SETLOC
	LD A,'>'
	CALL PUTCH

	LD A,0
	CALL SETCURSORTYPE
	LD A,0
	CALL SETCURSORONOFF
	LD HL,0x4902
	CALL SETLOC

	CALL Get16bitFromUser
	PUSH HL

	LD HL,0x4801
	CALL SETLOC
	LD HL,DataMSG
	CALL PUTSTR
	LD HL,0x4802
	CALL SETLOC
	LD A,'>'
	CALL PUTCH
	LD A,' '
	CALL PUTCH
	LD A,' '
	CALL PUTCH
	LD A,' '
	CALL PUTCH
	LD A,' '
	CALL PUTCH
	LD HL,0x4902
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
	JMP START

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
	JMP START

; Ascii Hex input from keyboard, Returns in HL
Get16bitFromUser:
	PUSH AF
	PUSH BC
	PUSH DE
	CALL GETCH
	LD A,H
	LD (Buffer),A
	CALL PUTCH
	CALL GETCH
	LD A,H
	LD (Buffer+1),A
	CALL PUTCH
	CALL GETCH
	LD A,H
	LD (Buffer+2),A
	CALL PUTCH
	CALL GETCH
	LD A,H
	LD (Buffer+3),A
	CALL PUTCH
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
	CALL GETCH
	LD A,H
	LD (Buffer+2),A
	CALL PUTCH
	CALL GETCH
	LD A,H
	LD (Buffer+3),A
	CALL PUTCH
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
	CALL ToNibble       ; Convert to 4-bit value
	; Shift HL left by 4 bits
	ADD HL,HL
	ADD HL,HL
	ADD HL,HL
	ADD HL,HL
	OR L                ; Combine nibble with L
	LD L,A             ; Update L
	INC DE              ; Next digit
	DJNZ ConvertLoop
	; Store result in AddressPointer
	LD (Value16Bit),HL
	RET

; Convert ASCII hex digit in A to 4-bit value (0-15)
; Handles 0-9, A-F, a-f
ToNibble:
	; Check for 0-9
	CP '0'
	JR C,InvalidNibble    ; < '0' is invalid
	CP '9'+1
	JR NC,CheckLetters    ; >= '9'+1, try letters
	SUB '0'                ; Convert '0'-'9' to 0-9
	RET
CheckLetters:
	; Convert a-f to A-F by clearing bit 5
	AND 0DFh               ; Make uppercase (e.g., 'a' -> 'A')
	CP 'A'
	JR C,InvalidNibble    ; < 'A' is invalid
	CP 'F'+1
	JR NC,InvalidNibble   ; >= 'F'+1 is invalid
	SUB 'A'-10             ; Convert 'A'-'F' to 10-15
	RET
InvalidNibble:
	LD A,0                ; Return 0 for invalid input
	RET

; Draw 8 lines of hex data
DisplayRAM:
	PUSH DE
	CALL CLS
	POP DE
	CALL LineOfHex
	LD HL,0x01
	CALL SETLOC
	CALL LineOfHex
	LD HL,0x02
	CALL SETLOC
	CALL LineOfHex
	LD HL,0x03
	CALL SETLOC
	CALL LineOfHex
	LD HL,0x04
	CALL SETLOC
	CALL LineOfHex
	LD HL,0x05
	CALL SETLOC
	CALL LineOfHex
	LD HL,0x06
	CALL SETLOC
	CALL LineOfHex
	LD HL,0x07
	CALL SETLOC
	CALL LineOfHex
	RET

LineOfHex:
	PUSH DE
	PUSH DE
	LD A,D
	CALL Hex2SCR
	LD A,E
	CALL Hex2SCR
	LD A,' '
	CALL PUTCH
	POP DE
	LD B,16

Display16:
	PUSH BC
	PUSH DE
	LD A,(DE)
	CALL Hex2SCR
	LD A,' '
	CALL PUTCH
	POP DE
	INC DE
	POP BC
	DJNZ Display16
	LD A,' '
	CALL PUTCH
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
	JR C,AsciiInv
	CP 0xFF
	JR NC,AsciiInv
	CALL PUTCH
	RET

AsciiInv:
	LD A,'.'
	CALL PUTCH
	RET

;QueryFlash: ; Interrogate the CFI of the flash card.
;	RET

ERASEFLASH:
	LD A,(FlashPresent)
	CP 0
	JMP Z,START
	CALL CLS
	LD HL,EraseMSG
	CALL PUTSTR
	CALL GETCH
	CP A,'Y'
	JMP NZ,START
	CALL CLS
	LD HL,ErasingMSG
	CALL PUTSTR

; Flash erase code here
	IN A,(PORT_BANK_CTL) ;backup current bank
	PUSH AF

	LD A,0x80
	CALL FlashPreamble
	LD A,0x10
	CALL FlashPreamble
w4fe:
	LD A,(0x4000)
	LD B,A
	LD A,(0x4000)
	CP A,B
	JMP NZ, w4fe

	LD A,0xF0
	CALL FlashPreamble

	POP AF
	OUT (PORT_BANK_CTL),A ; restore current bank
	JMP START

TestForFlash: ; CFI query

	CALL CLS
	IN A,(PORT_BANK_CTL) ; backup current bank
	PUSH AF

	LD A,0x90
	CALL FlashPreamble
	LD A,(0x4000)
	CP 0xBF
	JR NZ,NotSST
	LD A,ST
	LD (FlashType),A
	JR SST

NotSST:
	LD A,0x90
	CALL FlashPreambleMX
	LD A,(0x4000)
	CP 0xC2 ; test for MX Flash
	JR NZ,NotMX
	LD A,MX
	LD (FlashType),A
	JR SST

NotMX:
	LD A,0x09
	CALL FlashPreambleMXswapped
	LD A,(0x4000)
	CP 0x43 ; test for MX Flash
	JR NZ,noFlash
	LD A,MXs
	LD (FlashType),A

SST:
	LD HL,FlashMSG
	CALL PUTSTR

	LD A,0xF0
	CALL FlashPreamble
	LD A,1
	LD (FlashPresent),A
	CALL GETCH

noFlash:
	POP AF
	OUT (PORT_BANK_CTL),A ; restore current bank
	RET

FlashPreamble: ; command in A

	PUSH AF

	LD A,(FlashType)
	CP MX
	JR Z,UseMXFlashPreamble
	LD A,(FlashType)
	CP MXs
	JR Z,UseMXFlashPreambleSwapped

	JR USeSTFlashPreamble

UseMXFlashPreamble:
	POP AF
	JR FlashPreambleMX
UseMXFlashPreambleSwapped:
	POP AF
	JR FlashPreambleMXswapped
USeSTFlashPreamble:
	POP AF

	PUSH BC

	LD B,A
	LD C,PORT_BANK_CTL
	; The flash unlock sequence is 5555<AA, 2AAA<55, 5555<90h to read Hardware ID
	LD A,0x10
	OUT (PORT_BANK_CTL),A ; set flash bank 1
	LD A,0xAA
	LD (0x5555),A

	LD A,0x0F
	OUT (PORT_BANK_CTL),A ; set flash bank 0
	LD A,0x55
	LD (0x6AAA),A

	LD A,0x10
	OUT (PORT_BANK_CTL),A ; set flash bank 1
	LD A,B
	LD (0x5555),A

	POP BC
	RET

FlashPreambleMX: ; command in A
	PUSH BC

	LD B,A
	LD C,PORT_BANK_CTL
	; The flash unlock sequence is 555<AA, 2AA<55, 555<90h to read Hardware ID
	LD A,0x0F
	OUT (PORT_BANK_CTL),A ;set flash bank 0
	LD A,0xAA
	LD (0x4555),A

	LD A,0x55
	LD (0x42AA),A

	LD A,B
	LD (0x4555),A

	POP BC
	RET

;Banks! 0x4000-7FFF is one bank. Banks are mapped via port 0x51. 0x0F is bank0, 0x10 is bank 1 etc. Bank size is 0x4000 bytes. 
;bank 0 (0x0F) = 0x0000-0x3FFF
;Bank 1 (0x10) = 0x4000-0x7FFF
;Bank 2 (0x11) = 0x8000-0xBFFF
;Bank 3 (0x12) = 0xC000-0xFFFF

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PCB versions 007-030 had scrambled address & data lines.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Address 0x02AA = 0xA214 = Bank 2, 0x6214
;Address 0x0555 = 0x5928 = Bank 1, 0x5928
FlashPreambleMXswapped: ; command in A
	PUSH BC

	LD B,A
	LD C,PORT_BANK_CTL
	; The flash unlock sequence is 555<AA, 2AA<55, 555<90h to read Hardware ID
	LD A,0x10
	OUT (PORT_BANK_CTL),A ;set flash bank 1
	LD A,0x55
	LD (0x6214),A
	LD A,0x11
	OUT (PORT_BANK_CTL),A ;set flash bank 2
	LD A,0xAA
	LD (0x5928),A
	LD A,0x10
	OUT (PORT_BANK_CTL),A ;set flash bank 1
	LD A,B
	LD (0x6214),A

	POP BC
	RET

SerialHandler: ; pass control over to the serial port for flash erase/writing
	LD HL,0x084C ; 9600 bps, 8n1, no xon, timer enabled
	CALL RSINIT
	CALL CLS
	LD HL,SerialMSG
	CALL PUTSTR
SH1:
	CALL GETDATA
	JR NZ,SerialDataRX
	CALL CHARSENSE
	JR Z,SH1 ; no data from keyboard, loop back around
	; Key pressed
	LD A,H
	CP 0x1B ; the esc / cancel key
	JP Z,START
	JR SH1 ; go again

SerialDataRX:
	; Received Serial byte is in A
	CP 'E' ; erase command
	JR Z,SerialErase
	CP 'Q' ; Quit Serial handler
	JP Z,START
	CP 'R' ; Read Mem address
	JP Z,ReadMemAddress
	CP 'W' ; write Mem address
	JP Z,WriteMemAddress
	CP 'P' ; write port 51
	JP Z,WritePort51
	CP 'O' ; write port 51
	JP Z,WritePort51
	CP 'p' ; read port 51
	JP Z,ReadPort51
	CP 'I' ; read port 51
	JP Z,ReadPort51
	LD A,'?' ; Nack
	CALL SENDDATA
	JMP START

SerialErase:
	IN A,(PORT_BANK_CTL) ; backup current bank
	PUSH AF

	LD A,0x80
	CALL FlashPreamble
	LD A,0x10
	CALL FlashPreamble
Sw4fe:
	LD A,(0x4000)
	LD B,A
	LD A,(0x4000)
	CP A,B
	JMP NZ,Sw4fe

	LD A,0xF0
	CALL FlashPreamble

	POP AF
	OUT (PORT_BANK_CTL),A ; restore current bank

	LD A,1 ; ok
	CALL SENDDATA

	JR SH1

WritePort51:
	CALL GETDATA
	JR Z,WritePort51
	OUT (PORT_BANK_CTL),A
	LD (TempBank),A
	LD A,1 ; ack
	CALL SENDDATA
	JMP SH1

ReadPort51:
	IN A,(PORT_BANK_CTL)
	CALL SENDDATA
	JMP SH1

ReadMemAddress:
	; Wait for 2 bytes in the serial rx buffer
	CALL GETDATALEN
	LD A,L
	CP 2
	JR NZ,ReadMemAddress
	CALL GETDATA
	PUSH AF
	CALL GETDATA
	LD L,A
	POP AF
	LD H,A
	LD A,(HL)
	CALL SENDDATA
	JMP SH1

WriteMemAddress:
	; Wait for 3 bytes in the serial rx buffer
	CALL GETDATALEN
	LD A,L
	CP 3
	JR NZ,WriteMemAddress
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
	JMP SH1
WriteFlashAddress:

	POP AF
	; change this to write to the flash
	PUSH HL
	PUSH AF

	LD A,0xA0
	CALL FlashPreamble

	LD A,(TempBank)
	OUT (PORT_BANK_CTL),A
	POP AF
	POP hl
	LD (HL),A

	LD B,A
wffc: ; wait for flash complete
	LD A,(HL)
	CP B
	JR NZ,wffc
	LD A,1 ;ack
	CALL SENDDATA
	JMP SH1

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
	JR C,HexIsNum
	ADD A,55
	CALL PUTCH
	RET
HexIsNum:
	ADD A,48
	CALL PUTCH
	RET

; Volatile variables
ALIGN 2

Value16Bit:
	DW 0;

AddressPointer:
	DW Instructions

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

MonitorEnabled:
	DB 0

MonitorPortAddress:
	DB 0

Instructions:
;	DB "                "
	DB "MemUtil     v1.0"
	DB "S - Serial xfer "
	DB "G - Go to addr  "
	DB "W - Write       "
	DB "P - Port        "
	DB "? - Help        "
	DB "Up&Down +/- 0x80"
	DB "F2+Del - Exit   "

AddressMSG:
	DB "Address?",0

PortMSG:
	DB "Port?   ",0

DataMSG:
	DB "Data?   ",0

FlashMSG:
	DB "MemUtil:  Flash Detected! Enabling Flash Command Tools. Press any key...",0

EraseMSG:
	DB "MemUtil:  Are you sure you want to erase the flash card? (Y) ",0

ErasingMSG:
	DB "Erasing... Please wait...",0

SerialMSG:
;      "                                                                                "
	DB "MemUtil:  Serial Interface Mode (9600,8n1)       Press [Esc] to exit serial mode",0

;	DB " Mem Util : Serial Interface Mode (9600,8n1) : Press [Esc] to exit serial mode  "
;	DB "E     - Erase                     0x45 -> erase entire flash chip on ROM IC Card"
;	DB "Raa   - Read address aa                  0x52 0x12 0x34 -> return byte at 0x1234"
;	DB "Waadd - Write address aa data dd     0x57 0x12 0x34 0x56 -> write 0x56 at 0x1234"
;	DB "G     - Read bank control register          0x49 -> return current banking value"
;	DB "Bn    - Write n to bank control register         0x4F 0x0F -> select ROM bank 15",0

PRGEND:
