Building [HexViewer for WP-2](https://discord.com/channels/761864233855615017/763902318135214084/1487211108447027230)

## requirements  
The .asm may be compiled using z88dk-z80asm.  
Install [z88dk](https://github.com/z88dk/z88dk)  
There are precompiled versions for mac and windows.

Installing z88dk on ubuntu without using the snap or docker images.  
```
$ sudo apt install build-essential bison flex libxml2-dev zlib1g-dev m4 ragel re2c dos2unix texinfo texi2html gdb curl perl cpanminus ccache libboost-all-dev libmodern-perl-perl libyaml-perl liblocal-lib-perl libcapture-tiny-perl libpath-tiny-perl libtext-table-perl libdata-hexdump-perl libregexp-common-perl libclone-perl libfile-slurp-perl pkg-config libgmp3-dev
$ sudo cpanm App::Prove CPU::Z80::Assembler Data::Dump Data::HexDump Test::HexDifferences File::Path List::Uniq Modern::Perl Object::Tiny::RW Regexp::Common Test::Harness Text::Diff Text::Table YAML::Tiny
$ git clone --recursive git@github.com:z88dk/z88dk.git
$ cd z88dk
$ BUILD_SDCC=1 BUILD_SDCC_HTTP=1 PATH+=":$PWD/bin" ZCCCFG="$PWD/lib/config" sh build.sh
$ sudo make install
```

## build  
```
$ make clean all
```
This produces `HXVIEW22.PR`

Writing to a flash card from the WP-2 using HexViewer requires configuring both the WP-2 and the IC Card for the software write mod.  
* Inside the WP-2 add a bodge wire from RA4 pin 5 (near the cpu IC1) to RA5 pin 2 (near the card slot CN1).  
* On the card switch SW1 to the S3 position (or solder-blob the two S3 pads).

## install  
Start up a TPDD emulator on the PC:  
Examples, including the flags to support WP-2 8.2 filenames  
[LaddieAlpha](https://bitchin100.com/wiki/index.php?title=LaddieCon#LaddieAlpha): `C:\...> .\LaddieAlpha.EXE COM5 8` or `$ mono ./LaddieAlpha.EXE /dev/ttyUSB0 8`  
[dl2](https://github.com/bkw777/dl2): `$ dl -v -c wp2`

Copy `HXVIEWnn.PR` to the WP-2:  
On the WP-2, enter the word processor. Start an empty junk/temp document if necessary.  
From there, press FILES (F2+=),  
arrow left/right to DISKETTE and press Enter,  
arrow down to highlight `HXVIEWnn.PR`,  
press F1+C for copy, (or F1+1 for a menu then select Copy)  
select RAM DISK or MEMORY CARD (MEMORY does not work)

You can also run the executable directly from diskette without copying to ram disk or ic card.  
But do not try to copy it to the main 32k internal RAM. There is a bug in the main rom that corrupts run files when copied to internal main ram.

## run  
On the WP-2, enter the word processor. Start an empty junk/temp document if necessary.

From there, press FILES (F2+=)  
arrow left/right to DISKETTE or RAM DISK or MEMORY CARD, wherever the file is, and press Enter,  
arrow down to highlight the file,  
press RUN (F2+7).

To exit HexViewer press EXIT (F2+Bksp)

## usage
AA/DD arguments are hex pairs
```
E           erase flash chip
pAA         read byte from i/o port AA
PAADD       write byte DD to i/o port AA
RAAAA       read byte from memory address AAAA
WAAAADD     write byte DD to memory address AAAA
GAAAA       go to (view) memory address AAAA
S           serial interface (9600n81, ESC to close)
M           monitor
F           flash check
```

The same commands are accepted via the serial port after pressing S.  
This is how RomCardWriter.exe works.

To access a flash/rom card:  
* tell the main rom to select and map a 16k block from the card into the rom bank window  
* read/write to addresses within the rom bank window  

To write to a flash card you have to erase the card first.

ROM bank window is 16k from 0x4000 to 0x7FFF  
RAM bank window is 32k from 0x8000 to 0xFFFF  
Bank control is by writing to I/O port 0x51  
bit 0-4 select ROM bank number  
bit 5-7 select RAM bank number

RAM Bank 0-3 is internal expansion RAM  
RAM Bank 4-7 is IC card RAM  
ROM Bank 0-14 is Main ROM banks 0-14  
ROM Bank 15-30 is IC Card ROM banks 0-15

So, to access a flash/rom ic card:  
Write bank# to port 0x51  
where bank# is 0x0F to 0x1E

Example, to view the 1st 16k block of a flash/rom ic card:  
P 51 0F  
G 4000

To write a byte of data to the card:  
E             erase chip  
P 51 0F       select rom ic card, bank 0  
G 4000        view address 0x4000, should be FF because of chip-erase  
W 4000 5A     write "Z" to address 0x4000  
G 4000        view address 0x4000, should be 5A/"Z" now

### To write a ROM image to the flash card from the serial port  
RomCardWriter is only available as a Windows executable at this time, and the .cpp source is also just for Windows.  
It just issues the commands above via serial port, so it should be simple to reimplement in portable c or python or even bash.

* Start HexViewer on the WP-2  
* Press "S" to put HexViewer into serial xfer mode  
* Run RomCardWriter on the PC to send foo.PI  
```
C:\...> RomCardWriter COM5 MENU.PI
```
Takes 1-2 minutes.  
