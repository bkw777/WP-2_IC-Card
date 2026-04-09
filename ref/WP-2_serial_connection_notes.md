## use telcom as a terminal to login to linux
```
$ sudo stty -F /dev/ttyUSB0 9600 cs8 -parenb -cstopb ixoff ixon -ixany
$ sudo agetty -8 -L ttyUSB0 9600 vt52
```
WP-2: `SETUP` (`F2`+`-`) -> Telcom  
Device: RS232C  
Baud Rate: 9600  
Word Length(bits): 8  
Parity: None  
Stop bits: 1  
XON/XOFF: Enable  
Printer echo: off  
Duplex: Full

## use tpdd emulator to transfer files
`$ dl -v -c wp2` (Ctrl+C to exit)

## run or copy an executable file from disk
* On PC: Start a tpdd emulator
* On WP-2: Press `FILES` (`F2`+`=`) -> `DISKETTE` -> arrows to hightlight foo.PR
  * To run directly from disk: press `RUN` (`F2`+`7`)
  * To copy from `DISKETTE` to `RAM DISK` or `RAM CARD`: press `F1`+`C` or press `HELP` (`F1`+`1`) & select Copy
  * A bug in the system rom truncates run files copied to `MEMORY`.

`MEMORY` = built-in 32k main ram  
`RAM DISK` = optional additional 32k-128k ram installed in option ram socket inside WP-2  
`RAM CARD` = sram IC-card  
`DISKETTE` = TPDD/FB-100 drive or emulator connected to serial port  
