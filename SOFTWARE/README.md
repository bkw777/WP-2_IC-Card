# WP-2 "RUN files"

The WP-2 can run executables as either ROM images or oridinary files in RAM.  
The binary format is different for each.  
The main rom does not care what the filenames look like, but I am using a convention that ROM images are named *.PI and RAM executable files are named *.PR, after the ID field in the header of the respective binary formats.  

# HexViewer / MENU.PI / BASIC / RomCardWriter

The software to write to the rom card from the WP-2 (and the hardware mod to make it possible) comes from Ben Grimmett @BennVenn

[HexViewer](HexViewer) - .PR version of HexViewer

[RomCardWriter](RomCardWriter) - Windows app to write a ROM image to a flash card via HexViewer in serial xfer mode

WPBAS.PI - ROM image - MSBASIC ported to WP-2

MENU.PI - ROM image - multi-rom selector menu with HexViewer and MSBASIC and little space invader game right in the menu

To flash MENU.PI to a flash card using just the WP-2 itself (no programmer & programming adapter):

* The WP-2 must have the software write mod.  
  Inside the WP-2 add a bodge wire from RA4 pin 5 (near the cpu IC1) to RA5 pin 2 (near the card slot CN1).

* The flash rom card must be configured for write via S3 pin.  
  On the card switch SW1 to the S3 position, or solder-blob the two S3 pads.

* Connect a serial cable from a PC to the WP-2  
  Single-piece all-in-one cable that's perfect for this and annoying for any other use: https://amazon.com/dp/B072XV7GG3  
  No other adapters or cables needed with this. It goes directly from a PCs usb port to the WP-2's serial port.  
  More info & other options: http://tandy.wiki/WP-2#Serial_Cable_to_PC and http://tandy.wiki/Model_T_Serial_Cable#USB-Serial_Adapters

* Start a TPDD emulator on the PC.  
  [LaddieAlpha](https://bitchin100.com/wiki/index.php?title=LaddieCon#LaddieAlpha): `C:\...> .\LaddieAlpha.EXE COM5 8` or `$ mono ./LaddieAlpha.EXE /dev/ttyUSB0 8`  
  or  
  [dl2](https://github.com/bkw777/dl2): `$ dl -v -c wp2`

* Copy the RAM version of HexViewer `HXVIEWnn.PR` to the WP-2 internal ramdisk ("RAM DISK" not "MEMORY").  
  (If you don't have a ram disk, then [get one, it's just a $7 chip](https://www.digikey.com/short/70tr9zhp).  
  Until then, you can alternatively skip this step and in the next step run HexViewer directly from "DISKETTE" instead of "RAM DISK".)  
  
  On the WP-2, enter the word processor. Start an empty junk/temp document if necessary.  
  From there, press FILES (F2+=),  
  arrow left/right to DISKETTE and press Enter,  
  arrow down to highlight `HXVIEWnn.PR`,  
  press F1+C for copy, (or F1+1 for a menu then select Copy)  
  select RAM DISK (MEMORY does not work. MEMORY CARD works, but that requires a RAM card in the card slot, but the card slot will be occupied by a ROM card.)

* Run HexViewer on the WP-2  
  On the WP-2, enter the word processor. Start an empty junk/temp document if necessary.  
  From there, press FILES (F2+=),  
  arrow left/right to RAM DISK or DISKETTE and press Enter,  
  arrow down to highlight `HXVIEWnn.PR`,  
  press RUN (F2+7)

* Kill the TPDD server on the PC if not already. (Ctrl+C)

* In HexViewer press "S" to enter serial xfer mode.

* On the PC run RomCardWriter to send the ROM image.  
```
C:\...> RomCardWriter COM5 MENU.PI
```
This will take 1-2 minutes.

# Other WP-2 software

Several *.CMD files in the M100SIG archive.  
These run from RAM, so I would rename them to *.PR  
https://github.com/LivingM100SIG/Living_M100SIG/tree/main/M100SIG/Lib-15-WP2

CamelFORTH ported by John Hogerhuis  
http://bitchin100.com/files/wp2/CAMEL.ZIP

[DumpROM](DumpROM)
