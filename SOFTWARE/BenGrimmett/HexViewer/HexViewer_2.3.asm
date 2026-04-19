CLS     EQU 011EH
CHARSENSE EQU 0100H
GETCH   EQU 0103H
PUTCH  EQU 01A3H
PUTSTR EQU 011BH
RSINIT EQU 0140H
SENDDATA EQU 0146H
GETDATA EQU 0149H
GETDATALEN EQU 143H
RSCLOSE EQU 014CH
SETLOC EQU 109H
GETLOC EQU 10CH
SETCURSORONOFF EQU 10FH
SETCURSORTYPE EQU 112H

ST EQU 01H
MX EQU 02H
MXs EQU 03H

BKSP EQU 08H

        ORG 0AC00H-8
        DB "PR"
        DW 256 * 8;PRGEND - PRGSTART + 1
        DW PRGSTART
        DW 0
		
		
PRGSTART:
		call TestForFlash
START:
		ld DE,(AddressPointer)
		call DisplayRAM

        
ReadKeyboard:

		ld a,(MonitorEnabled)
		cp 0
		jr z, MonDisabled
		
		di
		ld a,6
		out (0),a
		in a,(0)
		push af
		EI
		ld HL,4801h
		call SETLOC
		ld HL,PortMSG
		call PUTSTR
		ld HL,4802h
		call SETLOC
		pop AF
		call Hex2SCR
		
		
		CALL CHARSENSE
		ld a,h
		
		;Command line interpreter of sorts...
		cp 'm'
		jp Z,MonitorPort
		cp 'M'
		jp Z,MonitorPort
		jp ReadKeyboard
		
MonDisabled:

		CALL GETCH
		ld a,h
		
		;Command line interpreter of sorts...
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
		
		cp 1FH
		jr Z,NEXT
		cp 1EH
		jr Z,PREVIOUS
		
		BIT 0,L ;Check if F2 is held
		JP Z,ReadKeyboard ;If it's not, read the keyboard again
		CP BKSP	;If it is, check if Del/Bksp is being held - F2+Bksp = Exit
		Jp NZ, ReadKeyboard ;If not, read the keyboard again
Exit:
		XOR A	;Gracefully return to the OS
		out (51h),a
		RET
		
NEXT:	;Add 0x80 to address pointer
		LD HL, (AddressPointer)  ; Load the 16-bit value from 0xA010 into HL
		LD DE, 0x80      ; Load 0x70 into DE
		ADD HL, DE       ; Add DE to HL
		LD (AddressPointer), HL  ; Store the result back to 0xA010
		JMP START
PREVIOUS:	;SUB 0x80 to address pointer
		LD HL, (AddressPointer)  ; Load the 16-bit value from 0xA010 into HL
		LD DE, 0x80      ; Load 0x70 into DE
		OR A             ; Clear carry flag
		SBC HL, DE       ; Subtract DE from HL
		LD (AddressPointer), HL  ; Store the result back to 0xA010
		JMP START
GOTO: ; Go to a user requested memory location
		ld HL,4801h
		call SETLOC
		ld HL,AddressMSG
		call PUTSTR
		ld HL,4802h
		call SETLOC
		ld a,'>'
		call PUTCH
		ld a,0
		call SETCURSORTYPE
		ld a,0
		call SETCURSORONOFF
		ld HL,4902h
		call SETLOC		
		
		call Get16bitFromUser ;returns value in HL
		ld (AddressPointer),HL

		ld a,1
		call SETCURSORONOFF
		jmp START


MonitorPort:

	ld a,(MonitorEnabled)
	cp 1
	jr nz, dontturnoff
	xor a
	ld (MonitorEnabled),a
	
	jmp START
dontturnoff:
	ld HL,4801h
		call SETLOC
		ld HL,PortMSG
		call PUTSTR
		ld HL,4802h
		call SETLOC
		ld a,'>'
		call PUTCH


		ld a,0
		call SETCURSORTYPE
		ld a,0
		call SETCURSORONOFF
		ld HL,4902h
		call SETLOC		

		call Get8bitFromUser
		ld (MonitorPortAddress),a
		ld a,1
		ld (MonitorEnabled),a
		ld a,1
		call SETCURSORONOFF
		jmp START
		
WRITEPORT: ;Write a value to a IO port
		ld HL,4801h
		call SETLOC
		ld HL,PortMSG
		call PUTSTR
		ld HL,4802h
		call SETLOC
		ld a,'>'
		call PUTCH


		ld a,0
		call SETCURSORTYPE
		ld a,0
		call SETCURSORONOFF
		ld HL,4902h
		call SETLOC		

		call Get8bitFromUser
		push af

		ld HL,4801h
		call SETLOC
		ld HL,DataMSG
		call PUTSTR
		ld HL,4802h
		call SETLOC
		ld a,'>'
		call PUTCH		
		ld a,' '
		call PUTCH		
		ld a,' '
		call PUTCH		
		ld a,' '
		call PUTCH		
		ld a,' '
		call PUTCH		
		ld HL,4902h
		call SETLOC
		
		pop af
		ld c,a
		call Get8bitFromUser
			
		out (c),a		
		
		ld a,1
		call SETCURSORONOFF
		jmp START
				
		
		
WRITERAM: ;Write a value to a memory location
		ld HL,4801h
		call SETLOC
		ld HL,AddressMSG
		call PUTSTR
		ld HL,4802h
		call SETLOC
		ld a,'>'
		call PUTCH

		ld a,0
		call SETCURSORTYPE
		ld a,0
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
		ld a,'>'
		call PUTCH		
		ld a,' '
		call PUTCH		
		ld a,' '
		call PUTCH		
		ld a,' '
		call PUTCH		
		ld a,' '
		call PUTCH		
		ld HL,4902h
		call SETLOC
		
		call Get8bitFromUser
		pop HL
		push af

        ; Check if HL < 0x8000
        ld a,h
        cp 80h
        jp c,Write2Flash  ; Jump if HL < 0x8000 (carry set means H < 80h)
        
		pop af	
		ld (HL),A
		ld a,1
		call SETCURSORONOFF
		jmp START

Write2Flash:
		pop af	
		;change this to write to the flash
		push HL
		push AF
		
		LD A,0A0h
		call FlashPreamble
		pop af
		pop hl
		ld (HL),a
		
		ld a,1
		call SETCURSORONOFF
		jmp START
				
Get16bitFromUser: ;Ascii Hex input from keyboard, Returns in HL
		push af
		push bc
		push de
		CALL GETCH
		ld a,h
		ld (Buffer),a
		call PUTCH
		CALL GETCH
		ld a,h
		ld (Buffer+1),a
		call PUTCH
		CALL GETCH
		ld a,h
		ld (Buffer+2),a
		call PUTCH
		CALL GETCH
		ld a,h
		ld (Buffer+3),a
		call PUTCH
		call ConvertHex16
		ld HL,(Value16Bit)
		pop de
		pop bc
		pop af		
		ret
	
	
Get8bitFromUser: ;Ascii Hex input from keyboard, Returns in A
		push HL
		push bc
		push de
		ld a,'0'
		ld (Buffer),a
		ld a,'0'
		ld (Buffer+1),a
		CALL GETCH
		ld a,h
		ld (Buffer+2),a
		call PUTCH
		CALL GETCH
		ld a,h
		ld (Buffer+3),a
		call PUTCH
		call ConvertHex16
		ld A,(Value16Bit)
		pop de
		pop bc
		pop HL	
		ret
		
; Convert 4 ASCII hex digits to 16-bit address
ConvertHex16:
    LD HL, 0            ; Initialize result
    LD DE, Buffer       ; Point to ASCII buffer
    LD B, 4             ; Process 4 digits
ConvertLoop:
    LD A, (DE)          ; Get ASCII digit
    CALL ToNibble       ; Convert to 4-bit value
    ; Shift HL left by 4 bits
    ADD HL, HL
    ADD HL, HL
    ADD HL, HL
    ADD HL, HL
    OR L                ; Combine nibble with L
    LD L, A             ; Update L
    INC DE              ; Next digit
    DJNZ ConvertLoop
    ; Store result in AddressPointer
    LD (Value16Bit), HL
    RET
    

; Convert ASCII hex digit in A to 4-bit value (0-15)
; Handles 0-9, A-F, a-f
ToNibble:
    ; Check for 0-9
    CP '0'
    JR C, InvalidNibble    ; < '0' is invalid
    CP '9'+1
    JR NC, CheckLetters    ; >= '9'+1, try letters
    SUB '0'                ; Convert '0'-'9' to 0-9
    RET
CheckLetters:
    ; Convert a-f to A-F by clearing bit 5
    AND 0xDF               ; Make uppercase (e.g., 'a' -> 'A')
    CP 'A'
    JR C, InvalidNibble    ; < 'A' is invalid
    CP 'F'+1
    JR NC, InvalidNibble   ; >= 'F'+1 is invalid
    SUB 'A'-10             ; Convert 'A'-'F' to 10-15
    RET
InvalidNibble:
    LD A, 0                ; Return 0 for invalid input
    RET
    
DisplayRAM: ;Draw 8 lines of hex data
		push DE
        CALL CLS
		POP DE
		CALL LineOfHex
		ld HL,0001h
		call SETLOC
		CALL LineOfHex
		ld HL,0002h
		call SETLOC
		CALL LineOfHex
		ld HL,0003h
		call SETLOC
		CALL LineOfHex
		ld HL,0004h
		call SETLOC
		CALL LineOfHex
		ld HL,0005h
		call SETLOC
		CALL LineOfHex
		ld HL,0006h
		call SETLOC
		CALL LineOfHex
		ld HL,0007h
		call SETLOC
		CALL LineOfHex
		ret

LineOfHex:
		PUSH DE
		PUSH DE
		ld a,d
		call Hex2SCR
		ld a,e
		call Hex2SCR
		ld a,' '
		call PUTCH
		POP DE
		ld b,16
Display16:
	push BC
	push DE
	ld a,(DE)
	call Hex2SCR
	ld a,' '
	call PUTCH
	pop DE
	inc DE
	pop BC
	djnz Display16
	ld a,' '
	call PUTCH
	POP DE
	
	ld b,16
drawascii: ;Draw the ascii equivalent of the hex data, if its a renderable ascii value
	ld a,(DE)
	inc DE
	push BC
	push DE
	call DrawValidAscii
	pop DE
	pop BC
	DJNZ drawascii

	
	ret
DrawValidAscii:
	;send ascii to sCR, unless invalid then show .
	;valid codes are:
	;20h to Ffh
	cp 20h
	jr c,AsciiInv
	cp 0FFh
	jr nc, AsciiInv
	call PUTCH
	ret
AsciiInv:
	ld a,'.'
	call PUTCH
	ret		
	
	
QueryFlash: ;Interrogate the CFI of the flash card.


	ret
	
ERASEFLASH:
	ld a,(FlashPresent)
	cp 0
	jmp z,START
	call CLS
	ld HL,EraseMSG
	call PUTSTR
	call GETCH
	cp a,'Y'
	jmp nz,START
	call CLS
	ld HL,ErasingMSG
	call PUTSTR

;;Flash erase code here
	in a,(51h) ;backup current bank
	push af
		
	LD A,080h
	call FlashPreamble
	LD A,010h
	call FlashPreamble
w4fe:
	ld a,(4000h)
	ld b,a
	ld a,(4000h)
	cp a,b
	jmp nz, w4fe
	
	LD A,0F0h
	call FlashPreamble
	
	pop af
	out (51h),a ;restore current pank
	JMP START
	
	
TestForFlash: ;CFI query

	call CLS
	in a,(51h) ;backup current bank
	push af
		
	LD A,090h
	call FlashPreamble
	ld a,(4000h)
	cp 0BFh
	jr nz,NotSST
	ld a,ST
	ld (FlashType),a
	jr SST
NotSST:
	LD A,090h
	call FlashPreambleMX
	ld a,(4000h)
	cp 0C2h ;test for MX Flash
	jr nz,NotMX
	ld a,MX
	ld (FlashType),a
	jr SST

NotMX:
	LD A,09h
	call FlashPreambleMXswapped
	ld a,(4000h)
	cp 043h ;test for MX Flash
	jr nz,noFlash
	ld a,MXs
	ld (FlashType),a


SST:	
	ld HL,FlashMSG
	call PUTSTR
	
	LD A,0F0h
	call FlashPreamble
	ld a,1
	ld (FlashPresent),a
	call GETCH
	
noFlash:
	pop af
	out (51h),a ;restore current pank
	ret


FlashPreamble: ;command in A

	push af
	
	ld a,(FlashType)
	cp MX
	jr z,UseMXFlashPreamble
	ld a,(FlashType)
	cp MXs
	jr z,UseMXFlashPreambleSwapped
	
	jr USeSTFlashPreamble
	
UseMXFlashPreamble:
	pop af
	jr FlashPreambleMX
UseMXFlashPreambleSwapped:
	pop af
	jr FlashPreambleMXswapped
USeSTFlashPreamble:
	pop af

	push bc

	
	ld b,a
	ld c,51h
	;The flash unlock sequence is 5555<AA, 2AAA<55, 5555<90h to read Hardware ID
	ld a,10h
	out (51h),a ;set flash bank 1
	ld a,0AAh
	ld (5555h),a

	ld a,0Fh
	out (51h),a ;set flash bank 0
	ld a,055h
	ld (6AAAh),a
	
	ld a,10h
	out (51h),a ;set flash bank 1
	ld a,b
	ld (5555h),a
	

	pop bc
	ret


FlashPreambleMX: ;command in A
	push bc

	ld b,a
	ld c,51h
	;The flash unlock sequence is 555<AA, 2AA<55, 555<90h to read Hardware ID
	ld a,0Fh
	out (51h),a ;set flash bank 0
	ld a,0AAh
	ld (4555h),a

	ld a,055h
	ld (42AAh),a
	
	ld a,b
	ld (4555h),a

	pop bc
	ret


;Banks! 0x4000-7FFF is one bank. Banks are mapped via port 0x51. 0x0F is bank0, 0x10 is bank 1 etc. Bank size is 0x4000 bytes. 
;bank 0 (0x0F) = 0x0000-0x3FFF
;Bank 1 (0x10) = 0x4000-0x7FFF
;Bank 2 (0x11) = 0x8000-0xBFFF
;Bank 3 (0x12) = 0xC000-0xFFFF

;Address 0x02AA = 0xA214 = Bank 2, 0x6214
;Address 0x0555 = 0x5928 = Bank 1, 0x5928
FlashPreambleMXswapped: ;command in A
	push bc

	ld b,a
	ld c,51h
	;The flash unlock sequence is 555<AA, 2AA<55, 555<90h to read Hardware ID
	ld a,10h
	out (51h),a ;set flash bank 1
	ld a,055h
	ld (6214h),a
	ld a,11h
	out (51h),a ;set flash bank 2
	ld a,0AAh
	ld (5928h),a
	ld a,10h
	out (51h),a ;set flash bank 1
	ld a,b
	ld (6214h),a

	pop bc
	ret


SerialHandler:	;pass control over to the serial port for flash erase/writing
		ld	hl,084Ch	; 9600 bps, 8n1, no xon, timer enabled
		call	RSINIT
		call CLS
		ld HL,SerialMSG
		call PUTSTR
SH1:
	CALL GETDATA
	jr nz, SerialDataRX
	CALL CHARSENSE
	jr z, SH1 ;no data from keyboard, loop back around
	;Key pressed
	ld a,h
	cp 01bH ;the esc / cancel key
	jp z, START
	JR SH1 ;go again
	
SerialDataRX:
	;Received Serial byte is in A
	cp 'E' ;erase command
	jr z, SerialErase
	cp 'Q' ;Quit Serial handler
	jp z, START
	cp 'R' ;Read Mem address
	jp z, ReadMemAddress
	cp 'W' ;write Mem address
	jp z, WriteMemAddress
	cp 'B'
	jp z, BurstReadAddress
	cp 'X' ;rawwrite Mem address
	jp z, RawWriteMemAddress
	cp 'V' ;rawwrite Mem address
	jp z, BurstWriteAddress
	cp 'P' ;write port 51
	jp z, WritePort51
	cp 'p' ;read port 51
	jp z, ReadPort51
	ld a,'?' ;Nack
	CALL SENDDATA
	
	JMP START
	
	BurstReadAddress:
	jmp BurstReadAddressMain
	BurstWriteAddress:
	jmp BurstWriteAddressMain
SerialErase:
	in a,(51h) ;backup current bank
	push af
		
	LD A,080h
	call FlashPreamble
	LD A,010h
	call FlashPreamble
Sw4fe:
	ld a,(4000h)
	ld b,a
	ld a,(4000h)
	cp a,b
	jmp nz, Sw4fe
	
	LD A,0F0h
	call FlashPreamble
	
	pop af
	out (51h),a ;restore current pank
	
	ld a,01 ;ok
	call SENDDATA
	
	jr SH1
WritePort51:
	call GETDATA
	jr z,WritePort51
	out (51h),a
	ld (TempBank),a
	ld a,01 ;ack
	CALL SENDDATA
	jmp SH1
ReadPort51:
	in a,(51h)
	CALL SENDDATA
	jmp SH1

ReadMemAddress:
	;Wait for 2 bytes in the serial rx buffer
	CALL GETDATALEN
	ld a,l
	cp 2
	jr nz,ReadMemAddress
	call GETDATA
	push af
	call GETDATA
	ld l,a
	pop af
	ld h,a
	ld a,(HL)
	CALL SENDDATA
	JMP SH1

WriteMemAddress:
	;Wait for 3 bytes in the serial rx buffer
	CALL GETDATALEN
	ld a,l
	cp 3
	jr nz,WriteMemAddress
	call GETDATA
	push af
	call GETDATA
	ld l,a
	pop af
	ld h,a
	push HL
	call GETDATA
	pop HL
	push af

    ; Check if HL < 0x8000
    ld a,h
    cp 80h
    jp c,WriteFlashAddress ; Jump if HL < 0x8000 (carry set means H < 80h)
	pop af	
	ld (HL),A

	
	
	ld a,01 ;ack
	CALL SENDDATA
	JMP SH1

RawWriteMemAddress:
	;Wait for 3 bytes in the serial rx buffer
	CALL GETDATALEN
	ld a,l
	cp 3
	jr nz,RawWriteMemAddress
	call GETDATA
	push af
	call GETDATA
	ld l,a
	pop af
	ld h,a
	push HL
	call GETDATA
	pop HL
	ld (HL),A
	ld a,01 ;ack
	CALL SENDDATA
	JMP SH1


WriteFlashAddress:
	
		pop af	
		;change this to write to the flash
		push HL
		push AF
		

		LD A,0A0h
		call FlashPreamble
	
		ld a,(TempBank)
		out (51h),a
		pop af
		pop hl
		ld (HL),a
			
		ld b,a
wffc: ;wait for flash complete
		ld a,(HL)
		cp b
		jr nz,wffc
		ld a,01 ;ack
		CALL SENDDATA
		jmp SH1
		
		
		
BurstReadAddressMain:
    ; Wait for 3 bytes: addrHi, addrLo, count
    CALL GETDATALEN
    ld a,l
    cp 3
    jr nz,BurstReadAddressMain
    call GETDATA
    push af
    call GETDATA
    ld l,a
    pop af
    ld h,a          ; HL = address
    push HL
    call GETDATA    ; A = count (1-128)
    ld b,a          ; B = byte counter
    pop HL
BurstReadLoop:
    ld a,(HL)
    call SENDDATA
    inc HL
    djnz BurstReadLoop
    jmp SH1


BurstWriteAddressMain:
    CALL GETDATALEN
    ld a,l
    cp 10        ; wait for addr(2) + data(8) = 10 bytes total
    jr nz,BurstWriteAddressMain
    call GETDATA
    push af
    call GETDATA
    ld l,a
    pop af
    ld h,a       ; HL = start address
    ld b,8       ; fixed burst of 8 bytes
BurstWriteLoop:
    push BC
    push HL
    call GETDATA
    push AF
    LD A,0A0h
    call FlashPreamble
    ld a,(TempBank)
    out (51h),a
    pop AF
    pop HL
    ld (HL),a
BWpoll:
    ld c,(HL)
    ld a,(HL)
    cp c
    jr nz,BWpoll
    inc HL
    pop BC
    djnz BurstWriteLoop
    ld a,01h
    CALL SENDDATA
    jmp SH1

Hex2SCR: 
	push af
	push bc 
	push DE
	; Hex in, Ascii printed to sCReen
	ld b,a
	push BC
	and 0F0h
	rlc a
	rlc a
	rlc a
	rlc a
	call Nib2Asc
	POP BC
	ld a,b
	and 0Fh
	call Nib2Asc
	pop DE
	pop bc
	pop af
	ret
Nib2Asc:
	cp 0Ah
	jr c, HexIsNum
	add a,55
	call PUTCH
	ret
HexIsNum:
	add a,48
	call PUTCH
	ret	
	
;Volatile variables
	align 2
	Value16Bit:
		DW 00H;
	AddressPointer:
		DW Instructions
	WriteAddressPointer:
		DW 00000H;
	WriteDataPointer:
		DW 00000H;
	TempBank:
		DB 0Fh
	FlashType:
		DB 00h

		
Buffer:
		DB '0'
		DB '0'
		DB '0'
		DB '0'
FlashPresent: DB 0
MonitorEnabled: DB 0
MonitorPortAddress: DB 0

Instructions:
	DB "HexViewer---v2.3"
	DB "S - Serial xfer "
	DB "G - Goto Address" 
	DB "W - Write Data  "
	DB "P - Poke IO Addr"
	DB "Up&Down +/-0x80 "
	DB "Exit to Exit    "
	DB "----------------"
AddressMSG:
	DB "Address?",0	
PortMSG:
	DB "Port?",0	
DataMSG:
	DB "Data?   ",0	
FlashMSG:
	DB "           Flash Detected! Enabling Flash Command Tools. Press any key...",0	
EraseMSG:
	DB "Are you sure you want to erase the flash card? (Y) ",0	
ErasingMSG:
	DB "Erasing... Please wait...",0	
SerialMSG:
	DB "Serial transfer running - 9600 8n1 - Press Escape to return to HexViewer        "
	DB "E (0x45) - Erase Flash ROM                                                      "
	DB "R (0x52) - Read Memory Address 0x52 0x12 0x34 will return (0x1234)              "
	DB "W (0x57) - Write Memory / Flash - 0x57 0x12 0x23 0x56 will store 0x55 > 0x1234  "
	DB "p (0x70) - Read bank control register - 0x70 will return current banking value  "
	DB "P (0x50) - Write to bank control register - 0x50 0x0F will set ROM bank 15      ",0
	
	
PRGEND:
