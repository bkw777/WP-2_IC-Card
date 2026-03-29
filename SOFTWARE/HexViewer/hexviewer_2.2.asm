; HexViewer 2.2
; Ben Grimmett
; https://discord.com/channels/761864233855615017/763902318135214084/1487211108447027230
; z88dk-z80asm -v -b -o=HXVIEW22.PR hexviewer_2.2.asm
; Copy HXVIEW22.PR to a WP-2 internal ram disk or ram/mram ic-card via TPDD, or run directly from "diskette".

CLS EQU 011Eh
CHARSENSE EQU 0100h
GETCH EQU 0103h
PUTCH EQU 01A3h
PUTSTR EQU 011Bh
RSINIT EQU 0140h
SENDDATA EQU 0146h
GETDATA EQU 0149h
GETDATALEN EQU 0143h
RSCLOSE EQU 014Ch
SETLOC EQU 0109h
GETLOC EQU 010Ch
SETCURSORONOFF EQU 010Fh
SETCURSORTYPE EQU 0112h

ST EQU 01h
MX EQU 02h
MXs EQU 03h

BKSP EQU 08h

; WP-2 "RUN file" header for executables that run from RAM
org 0AC00h-8
db "PR"
dw 256 * 8 ;PRGEND - PRGSTART + 1
dw PRGSTART
dw 0

PRGSTART:
	call TestForFlash

START:
	ld DE,(AddressPointer)
	call DisplayRAM

ReadKeyboard:

	ld A,(MonitorEnabled)
	cp 0
	jr Z, MonDisabled

	di
	ld A,6
	out (0),A
	in A,(0)
	push AF
	ei
	ld HL,4801h
	call SETLOC
	ld HL,PortMSG
	call PUTSTR
	ld HL,4802h
	call SETLOC
	pop AF
	call Hex2SCR

	call CHARSENSE
	ld A,H

	; Command line interpreter of sorts...
	cp 'm'
	jp Z,MonitorPort
	cp 'M'
	jp Z,MonitorPort
	jp ReadKeyboard

MonDisabled:

	call GETCH
	ld A,H

	; Command line interpreter of sorts...
	cp 'G'
	jr Z,GOTO
	cp 'g'
	jr Z,GOTO
	cp 'W'
	jp Z,WRITERAM
	cp 'w'
	jp Z,WRITERAM
	cp 'P'
	jp Z,WRITEPORT
	cp 'p'
	jp Z,WRITEPORT
	cp 'E'
	jp Z,ERASEFLASH
	cp 'e'
	jp Z,ERASEFLASH
	cp 'S'
	jp Z,SerialHandler
	cp 's'
	jp Z,SerialHandler
	cp 'm'
	jp Z,MonitorPort
	cp 'M'
	jp Z,MonitorPort
	cp 'f'
	jp Z,QueryFlash
	cp 'F'
	jp Z,QueryFlash

	cp 1Fh
	jr Z,NEXT
	cp 1Eh
	jr Z,PREVIOUS

	bit 0,L ; Check if F2 is held
	jp Z,ReadKeyboard ; If it's not, read the keyboard again
	cp BKSP	; If it is, check if Del/Bksp is being held - F2+Bksp = Exit
	jp NZ, ReadKeyboard ; If not, read the keyboard again

; Gracefully return to the OS
Exit:
	xor A
	out (51h),a
	ret

; Add 0x80 to address pointer
NEXT:
	ld HL, (AddressPointer) ; Load the 16-bit value from 0xA010 into HL
	ld DE, 80h       ; Load 0x80 into DE
	add HL, DE       ; Add DE to HL
	ld (AddressPointer), HL ; Store the result back to 0xA010
	jmp START

; Subtract 0x80 from address pointer
PREVIOUS:
	ld HL, (AddressPointer)  ; Load the 16-bit value from 0xA010 into HL
	ld DE, 80h       ; Load 0x80 into DE
	or A             ; Clear carry flag
	sbc HL, DE       ; Subtract DE from HL
	ld (AddressPointer), HL  ; Store the result back to 0xA010
	jmp START

; Go to a user requested memory location
GOTO:
	ld HL,4801h
	call SETLOC
	ld HL,AddressMSG
	call PUTSTR
	ld HL,4802h
	call SETLOC
	ld A,'>'
	call PUTCH
	ld A,0
	call SETCURSORTYPE
	ld A,0
	call SETCURSORONOFF
	ld HL,4902h
	call SETLOC

	call Get16bitFromUser ; returns value in HL
	ld (AddressPointer),HL

	ld A,1
	call SETCURSORONOFF
	jmp START

MonitorPort:

	ld A,(MonitorEnabled)
	cp 1
	jr NZ, dontturnoff
	xor A
	ld (MonitorEnabled),a

	jmp START
dontturnoff:
	ld HL,4801h
	call SETLOC
	ld HL,PortMSG
	call PUTSTR
	ld HL,4802h
	call SETLOC
	ld A,'>'
	call PUTCH

	ld A,0
	call SETCURSORTYPE
	ld A,0
	call SETCURSORONOFF
	ld HL,4902h
	call SETLOC

	call Get8bitFromUser
	ld (MonitorPortAddress),A
	ld A,1
	ld (MonitorEnabled),A
	ld A,1
	call SETCURSORONOFF
	jmp START

; Write a value to an IO port
WRITEPORT:
	ld HL,4801h
	call SETLOC
	ld HL,PortMSG
	call PUTSTR
	ld HL,4802h
	call SETLOC
	ld A,'>'
	call PUTCH

	ld A,0
	call SETCURSORTYPE
	ld A,0
	call SETCURSORONOFF
	ld HL,4902h
	call SETLOC

	call Get8bitFromUser
	push AF

	ld HL,4801h
	call SETLOC
	ld HL,DataMSG
	call PUTSTR
	ld HL,4802h
	call SETLOC
	ld A,'>'
	call PUTCH
	ld A,' '
	call PUTCH
	ld A,' '
	call PUTCH
	ld A,' '
	call PUTCH
	ld A,' '
	call PUTCH
	ld HL,4902h
	call SETLOC

	pop AF
	ld C,A
	call Get8bitFromUser

	out (C),A

	ld A,1
	call SETCURSORONOFF
	jmp START

; Write a value to a memory location
WRITERAM:
	ld HL,4801h
	call SETLOC
	ld HL,AddressMSG
	call PUTSTR
	ld HL,4802h
	call SETLOC
	ld A,'>'
	call PUTCH

	ld A,0
	call SETCURSORTYPE
	ld A,0
	call SETCURSORONOFF
	ld HL,4902h
	call SETLOC

	call Get16bitFromUser
	push HL

	ld HL,4801h
	call SETLOC
	ld HL,DataMSG
	call PUTSTR
	ld HL,4802h
	call SETLOC
	ld A,'>'
	call PUTCH
	ld A,' '
	call PUTCH
	ld A,' '
	call PUTCH
	ld A,' '
	call PUTCH
	ld A,' '
	call PUTCH
	ld HL,4902h
	call SETLOC

	call Get8bitFromUser
	pop HL
	push AF

	; Check if HL < 0x8000
	ld A,H
	cp 80h
	jp C,Write2Flash  ; Jump if HL < 0x8000 (carry set means H < 80h)

	pop AF
	ld (HL),A
	ld A,1
	call SETCURSORONOFF
	jmp START

Write2Flash:
	pop AF
	; change this to write to the flash
	push HL
	push AF

	LD A,0A0h
	call FlashPreamble
	pop AF
	pop HL
	ld (HL),A

	ld A,1
	call SETCURSORONOFF
	jmp START

; Ascii Hex input from keyboard, Returns in HL
Get16bitFromUser:
	push AF
	push BC
	push DE
	call GETCH
	ld A,H
	ld (Buffer),A
	call PUTCH
	call GETCH
	ld A,H
	ld (Buffer+1),A
	call PUTCH
	call GETCH
	ld A,H
	ld (Buffer+2),A
	call PUTCH
	call GETCH
	ld A,H
	ld (Buffer+3),A
	call PUTCH
	call ConvertHex16
	ld HL,(Value16Bit)
	pop DE
	pop BC
	pop AF
	ret

; Ascii Hex input from keyboard, Returns in A
Get8bitFromUser:
	push HL
	push BC
	push DE
	ld A,'0'
	ld (Buffer),A
	ld A,'0'
	ld (Buffer+1),A
	call GETCH
	ld A,H
	ld (Buffer+2),A
	call PUTCH
	call GETCH
	ld A,H
	ld (Buffer+3),A
	call PUTCH
	call ConvertHex16
	ld A,(Value16Bit)
	pop DE
	pop BC
	pop HL
	ret

; Convert 4 ASCII hex digits to 16-bit address
ConvertHex16:
	ld HL, 0            ; Initialize result
	ld DE, Buffer       ; Point to ASCII buffer
	ld B, 4             ; Process 4 digits
ConvertLoop:
	ld A, (DE)          ; Get ASCII digit
	call ToNibble       ; Convert to 4-bit value
	; Shift HL left by 4 bits
	add HL, HL
	add HL, HL
	add HL, HL
	add HL, HL
	or L                ; Combine nibble with L
	ld L, A             ; Update L
	inc DE              ; Next digit
	djnz ConvertLoop
	; Store result in AddressPointer
	ld (Value16Bit), HL
	ret

; Convert ASCII hex digit in A to 4-bit value (0-15)
; Handles 0-9, A-F, a-f
ToNibble:
	; Check for 0-9
	cp '0'
	jr C, InvalidNibble    ; < '0' is invalid
	cp '9'+1
	jr NC, CheckLetters    ; >= '9'+1, try letters
	sub '0'                ; Convert '0'-'9' to 0-9
	ret
CheckLetters:
	; Convert a-f to A-F by clearing bit 5
	and 0DFh               ; Make uppercase (e.g., 'a' -> 'A')
	cp 'A'
	jr C, InvalidNibble    ; < 'A' is invalid
	cp 'F'+1
	jr NC, InvalidNibble   ; >= 'F'+1 is invalid
	sub 'A'-10             ; Convert 'A'-'F' to 10-15
	ret
InvalidNibble:
	ld A, 0                ; Return 0 for invalid input
	ret

; Draw 8 lines of hex data
DisplayRAM:
	push DE
	call CLS
	pop DE
	call LineOfHex
	ld HL,0001h
	call SETLOC
	call LineOfHex
	ld HL,0002h
	call SETLOC
	call LineOfHex
	ld HL,0003h
	call SETLOC
	call LineOfHex
	ld HL,0004h
	call SETLOC
	call LineOfHex
	ld HL,0005h
	call SETLOC
	call LineOfHex
	ld HL,0006h
	call SETLOC
	call LineOfHex
	ld HL,0007h
	call SETLOC
	call LineOfHex
	ret

LineOfHex:
	push DE
	push DE
	ld A,D
	call Hex2SCR
	ld A,E
	call Hex2SCR
	ld A,' '
	call PUTCH
	pop DE
	ld b,16

Display16:
	push BC
	push DE
	ld A,(DE)
	call Hex2SCR
	ld A,' '
	call PUTCH
	pop DE
	inc DE
	pop BC
	djnz Display16
	ld A,' '
	call PUTCH
	pop DE
	ld B,16

; Draw the ascii equivalent of the hex data, if its a renderable ascii value
drawascii:
	ld A,(DE)
	inc DE
	push BC
	push DE
	call DrawValidAscii
	pop DE
	pop BC
	djnz drawascii
	ret

; Send ascii to SCR. If <0x20 >0xFF show "."
DrawValidAscii:
	cp 20h
	jr C,AsciiInv
	cp 0FFh
	jr NC, AsciiInv
	call PUTCH
	ret

AsciiInv:
	ld A,'.'
	call PUTCH
	ret

QueryFlash: ; Interrogate the CFI of the flash card.
	ret

ERASEFLASH:
	ld A,(FlashPresent)
	cp 0
	jmp Z,START
	call CLS
	ld HL,EraseMSG
	call PUTSTR
	call GETCH
	cp A,'Y'
	jmp NZ,START
	call CLS
	ld HL,ErasingMSG
	call PUTSTR

; Flash erase code here
	in A,(51h) ;backup current bank
	push AF

	ld A,080h
	call FlashPreamble
	ld A,010h
	call FlashPreamble
w4fe:
	ld A,(4000h)
	ld B,A
	ld A,(4000h)
	cp A,B
	jmp NZ, w4fe

	ld A,0F0h
	call FlashPreamble

	pop AF
	out (51h),A ; restore current bank
	jmp START

TestForFlash: ; CFI query

	call CLS
	in A,(51h) ; backup current bank
	push AF

	ld A,090h
	call FlashPreamble
	ld A,(4000h)
	cp 0BFh
	jr NZ,NotSST
	ld A,ST
	ld (FlashType),A
	jr SST

NotSST:
	ld A,090h
	call FlashPreambleMX
	ld A,(4000h)
	cp 0C2h ; test for MX Flash
	jr NZ,NotMX
	ld A,MX
	ld (FlashType),A
	jr SST

NotMX:
	ld A,09h
	call FlashPreambleMXswapped
	ld A,(4000h)
	cp 043h ; test for MX Flash
	jr NZ,noFlash
	ld A,MXs
	ld (FlashType),A

SST:
	ld HL,FlashMSG
	call PUTSTR

	ld A,0F0h
	call FlashPreamble
	ld A,1
	ld (FlashPresent),A
	call GETCH

noFlash:
	pop AF
	out (51h),A ; restore current bank
	ret

FlashPreamble: ; command in A

	push AF

	ld A,(FlashType)
	cp MX
	jr Z,UseMXFlashPreamble
	ld A,(FlashType)
	cp MXs
	jr Z,UseMXFlashPreambleSwapped

	jr USeSTFlashPreamble

UseMXFlashPreamble:
	pop AF
	jr FlashPreambleMX
UseMXFlashPreambleSwapped:
	pop AF
	jr FlashPreambleMXswapped
USeSTFlashPreamble:
	pop AF

	push BC

	ld B,A
	ld C,51h
	; The flash unlock sequence is 5555<AA, 2AAA<55, 5555<90h to read Hardware ID
	ld A,10h
	out (51h),A ; set flash bank 1
	ld A,0AAh
	ld (5555h),A

	ld A,0Fh
	out (51h),A ; set flash bank 0
	ld A,055h
	ld (6AAAh),A

	ld A,10h
	out (51h),A ; set flash bank 1
	ld A,B
	ld (5555h),A

	pop BC
	ret

FlashPreambleMX: ; command in A
	push BC

	ld B,A
	ld C,51h
	; The flash unlock sequence is 555<AA, 2AA<55, 555<90h to read Hardware ID
	ld A,0Fh
	out (51h),A ;set flash bank 0
	ld A,0AAh
	ld (4555h),A

	ld A,055h
	ld (42AAh),A

	ld A,B
	ld (4555h),A

	pop BC
	ret

;Banks! 0x4000-7FFF is one bank. Banks are mapped via port 0x51. 0x0F is bank0, 0x10 is bank 1 etc. Bank size is 0x4000 bytes. 
;bank 0 (0x0F) = 0x0000-0x3FFF
;Bank 1 (0x10) = 0x4000-0x7FFF
;Bank 2 (0x11) = 0x8000-0xBFFF
;Bank 3 (0x12) = 0xC000-0xFFFF

;Address 0x02AA = 0xA214 = Bank 2, 0x6214
;Address 0x0555 = 0x5928 = Bank 1, 0x5928
FlashPreambleMXswapped: ; command in A
	push BC

	ld B,A
	ld C,51h
	; The flash unlock sequence is 555<AA, 2AA<55, 555<90h to read Hardware ID
	ld A,10h
	out (51h),A ;set flash bank 1
	ld A,055h
	ld (6214h),A
	ld A,11h
	out (51h),A ;set flash bank 2
	ld A,0AAh
	ld (5928h),A
	ld A,10h
	out (51h),A ;set flash bank 1
	ld A,B
	ld (6214h),A

	pop BC
	ret

SerialHandler: ; pass control over to the serial port for flash erase/writing
	ld HL,084Ch ; 9600 bps, 8n1, no xon, timer enabled
	call RSINIT
	call CLS
	ld HL,SerialMSG
	call PUTSTR
SH1:
	call GETDATA
	jr NZ, SerialDataRX
	call CHARSENSE
	jr Z, SH1 ; no data from keyboard, loop back around
	; Key pressed
	ld A,H
	cp 01BH ; the esc / cancel key
	jp Z, START
	jr SH1 ; go again

SerialDataRX:
	; Received Serial byte is in A
	cp 'E' ; erase command
	jr z, SerialErase
	cp 'Q' ; Quit Serial handler
	jp z, START
	cp 'R' ; Read Mem address
	jp z, ReadMemAddress
	cp 'W' ; write Mem address
	jp z, WriteMemAddress
	cp 'P' ; write port 51
	jp z, WritePort51
	cp 'p' ; read port 51
	jp z, ReadPort51
	ld a,'?' ; Nack
	call SENDDATA
	jmp START

SerialErase:
	in A,(51h) ; backup current bank
	push AF

	ld A,080h
	call FlashPreamble
	ld A,010h
	call FlashPreamble
Sw4fe:
	ld A,(4000h)
	ld B,A
	ld A,(4000h)
	cp A,B
	jmp NZ, Sw4fe

	ld A,0F0h
	call FlashPreamble

	pop AF
	out (51h),A ; restore current bank

	ld A,01 ; ok
	call SENDDATA

	jr SH1

WritePort51:
	call GETDATA
	jr Z,WritePort51
	out (51h),A
	ld (TempBank),A
	ld A,01 ; ack
	call SENDDATA
	jmp SH1

ReadPort51:
	in A,(51h)
	call SENDDATA
	jmp SH1

ReadMemAddress:
	; Wait for 2 bytes in the serial rx buffer
	call GETDATALEN
	ld A,L
	cp 2
	jr NZ,ReadMemAddress
	call GETDATA
	push AF
	call GETDATA
	ld L,A
	pop AF
	ld H,A
	ld A,(HL)
	call SENDDATA
	jmp SH1

WriteMemAddress:
	; Wait for 3 bytes in the serial rx buffer
	call GETDATALEN
	ld A,L
	cp 3
	jr NZ,WriteMemAddress
	call GETDATA
	push AF
	call GETDATA
	ld L,A
	pop AF
	ld H,A
	push HL
	call GETDATA
	pop HL
	push AF

	; Check if HL < 0x8000
	ld A,H
	cp 80h
	jp C,WriteFlashAddress ; Jump if HL < 0x8000 (carry set means H < 80h)
	pop AF
	ld (HL),A

	ld A,01 ; ack
	call SENDDATA
	jmp SH1
WriteFlashAddress:

	pop AF
	; change this to write to the flash
	push HL
	push AF

	ld A,0A0h
	call FlashPreamble

	ld A,(TempBank)
	out (51h),A
	pop AF
	pop hl
	ld (HL),A

	ld B,A
wffc: ; wait for flash complete
	ld A,(HL)
	cp B
	jr NZ,wffc
	ld A,01 ;ack
	call SENDDATA
	jmp SH1

Hex2SCR: 
	push AF
	push BC 
	push DE
	; Hex in, Ascii printed to screen
	ld B,A
	push BC
	and 0F0h
	rlc A
	rlc A
	rlc A
	rlc A
	call Nib2Asc
	pop BC
	ld A,B
	and 0Fh
	call Nib2Asc
	pop DE
	pop BC
	pop AF
	ret
Nib2Asc:
	cp 0Ah
	jr C, HexIsNum
	add A,55
	call PUTCH
	ret
HexIsNum:
	add A,48
	call PUTCH
	ret

; Volatile variables
align 2

Value16Bit:
	dw 00h;

AddressPointer:
	dw Instructions

WriteAddressPointer:
	dw 00000h;

WriteDataPointer:
	dw 00000h;

TempBank:
	db 0Fh

FlashType:
	db 00h

Buffer:
	db '0'
	db '0'
	db '0'
	db '0'

FlashPresent:
	db 0

MonitorEnabled:
	db 0

MonitorPortAddress:
	db 0

Instructions:
	db "HexViewer---v2.2"
	db "S - Serial xfer "
	db "G - Goto Address" 
	db "W - Write Data  "
	db "P - Poke IO Addr"
	db "Up&Down +/- 0x80"
	db "EXIT (F2+=) Exit"
	db "----------------"

AddressMSG:
	db "Address?",0

PortMSG:
	db "Port?",0

DataMSG:
	db "Data?   ",0

FlashMSG:
	db "           Flash Detected! Enabling Flash Command Tools. Press any key...",0

EraseMSG:
	db "Are you sure you want to erase the flash card? (Y) ",0

ErasingMSG:
	db "Erasing... Please wait...",0

SerialMSG:
	db "Serial transfer running - 9600 8n1 - Press Escape to return to HexViewer        "
	db "E (0x45) - Erase Flash ROM                                                      "
	db "R (0x52) - Read Memory Address - 0x52 0x12 0x34 will return byte at 0x1234      "
	db "W (0x57) - Write Memory / Flash - 0x57 0x12 0x34 0x56 will store 0x56 at 0x1234 "
	db "p (0x70) - Read bank control register - 0x70 will return current banking value  "
	db "P (0x50) - Write to bank control register - 0x50 0x0F will select ROM bank 15   ",0

PRGEND:
