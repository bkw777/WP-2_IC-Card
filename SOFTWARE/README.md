# WP-2 "RUN files"

There are 2 slightly different executable file formats, one for ROM images, and one for RAM executable files.  
This repo adopts a convention that ROM image filenames are *.PI and RAM executable filenames are *.PR,  
after the ID field in the file header, aka first 2 bytes of the file.  

Documentation about RUN files:  
https://archive.org/details/Tandy_WP-2_Portable_Wordprocessor_Service_Manual_1989_Tandy/page/n36/mode/1up

## RUN a RAM executable file  
RUN files may be run from `RAM DISK` (extra 32k or 128k SRAM chip installed in the DIP-32 socket inside the WP-2),  
`MEMORY CARD` (RAM/MRAM IC Card in the card slot), or `DISKETTE` (TPDD drive or emulator).  
(Not `MEMORY`, because there is a bug in the system rom that corrupts RUN files when copied to the internal main 32k)

Enter the word processor. Start an empty junk document if necessary.  
From there press FILES (F2+=)  
Arrow left/right to `RAM DISK`, `MEMORY CARD`, or `DISKETTE` and press Enter  
Arrow up/down to the file and press RUN (F2+7)

## RUN a ROM IC Card
Enter the word processor. Start an empty junk document if necessary.  
From there press RUN (F2+7)

# HexViewer / MENU.PI / BASIC / RomCardWriter

The software to write to a ROM flash card from the WP-2 (and the hardware mod to make it possible) comes from [Ben Grimmett / @BennVenn](https://discord.com/invite/F5ckxM2)

[HexViewer](HexViewer) - RAM executable file version of HexViewer

[RomCardWriter](RomCardWriter) - Windows app to write a ROM image to a flash card via HexViewer in serial xfer mode

WPBAS.PI - ROM image - MSBASIC ported to WP-2  
  `MONITOR` exits BASIC back to the system rom.

MENU.PI - ROM image - multi-rom image with selector menu front-end  
  Includes MSBASIC and HexViewer, and the top level selector menu is also a space invader game.

## Writing a ROM image to a FLASH card from the WP-2  
To flash a ROM image (MENU.PI or WPBAS.PI) to a flash card using just the WP-2 itself (and a PC and a serial connection), without a programmer & programming adapter:

* Perform the S3 write mod on the WP-2.  
  Inside the WP-2, add a bodge wire from RA4 pin 5 (near the cpu IC1) to RA5 pin 2 (near the card slot CN1).

* Configure the ROM IC-Card to use the S3 write mod.  
  On the card, switch SW1 to the S3 position, or solder-blob the S3 pads.

* Connect a serial cable from a PC to the WP-2  
  For reference, here is a one-piece cable with null-modem and gender-change built-in,  
  which connects directly from a usb port to the WP-2: https://amazon.com/dp/B072XV7GG3  

* Start a [TPDD server](http://tandy.wiki/TPDD_server) (FB-100 floppy drive emulator) on the PC.  
  Examples, including the options to support WP-2 8.2 filenames:  
  * [LaddieAlpha](https://bitchin100.com/wiki/index.php?title=LaddieCon#LaddieAlpha)  
    `C:\...> .\LaddieAlpha.EXE COM5 8`  
    or  
  * [dl2](https://github.com/bkw777/dl2)  
    `$ dl -v -c wp2`

* Copy the RAM version of HexViewer `HXVIEWnn.PR` from `DISKETTE` to `RAM DISK` (not `MEMORY`) on the WP-2.  
  If you don't have a ram disk, then [get one, it's just a $7 chip](https://www.digikey.com/short/70tr9zhp).  
  Until then, you can alternatively skip this step, and in the next step run HexViewer directly from `DISKETTE` instead of `RAM DISK`.  
  (There is a bug in the system rom that corrupts RUN files when copied to the main internal 32k.  
  RUN files do work from a RAM IC card, but for this job the card slot is occupied by a ROM IC card.)
  
  On the WP-2, enter the word processor. Start an empty junk/temp document if necessary.  
  From there, press `FILES` (F2+=),  
  arrow left/right to `DISKETTE` and press Enter,  
  arrow down to highlight `HXVIEWnn.PR`,  
  press F1+C for copy, (or F1+1 for a menu then select Copy)  
  select `RAM DISK`

* Run HexViewer on the WP-2  
  On the WP-2, enter the word processor. Start an empty junk/temp document if necessary.  
  From there, press `FILES` (F2+=),  
  arrow left/right to `RAM DISK` (or `DISKETTE`) and press Enter,  
  arrow down to highlight `HXVIEWnn.PR`,  
  press `RUN` (F2+7)

* Kill the TPDD server on the PC. (Ctrl+C)

* In HexViewer press `S` to enter serial xfer mode.

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

[DumpROM](DumpROM) by Christofer @ randomvariations
