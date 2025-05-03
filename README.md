# Expansion IC-Card for [TANDY WP-2](tandy.wiki/WP-2), [TANDY WP-3](https://www.retrocoding.uk/tandy-wp-3-word-processor/), [Citizen CBM-10WP](http://mo5.com/musee-machines-cbm10wp.html), [NTS WP-10C](https://munk.org/typecast/2020/09/09/tandy-wp-2-user-manual-happy-septandy/)

![](PCB/out/WP-2_IC-Card_SRAM.jpg)  
![](PCB/out/WP-2_IC-Card_SRAM.slider.jpg)

The TANDY WP-2 and other clones of the Citizen CBM-10WP have an expansion slot that accepts ["IC Cards"](#reference-material).

Here are a few different cards to fit that slot.

* A [battery-backed SRAM card](#sram-card) like the original cards  
* A [non-volatile MRAM card](#mram-card) that needs no battery  
* A [ROM card](#flash-card) of only academic value, since there are no known ROM images to load onto it  
* A [programming adapter](#programming-adapter) that can read and write both the RAM and ROM cards  
* A [breakout card](#breakout-card) to allow connecting the bus to a breadboard or logic analyser etc

## Fabrication & assembly notes

**REQUIRES 1.2mm PCB**  
Standard 1.6mm PCB thickness is too thick. Thinner is ok, and allows the possibility to print a bottom cover to protect the bottom surface of the pcb, but 1.2 mm is most convenient and the standard 1.6mm will NOT fit.

ENIG copper finish will give you a better battery terminal without the expense and custom steps of proper selective hard gold.

Attach the cover with thin adhesive transfer tape aka "cell phone / lcd repair" tape, ideally 3-5mm wide.  
The cards all have 5mm wide blocks for 5mm adhesive tape.  
https://www.amazon.com/dp/B078H298G2/  
https://www.amazon.com/dp/B019OQ4YX4/  
https://www.amazon.com/dp/B0DRV5D4YG/  
<!-- https://amazon.com/dp/B06Y34587N/ (This one is wider than 5mm but has no carrier film in the middle, just gummy adhesive that squishes into any form, so the width doesn't matter and you can just lay it anywhere right over the chips and pins etc.) -->
Or glue, but adhesive is easier to remove later.

It's not a bad idea to cover the bottom of the pcb with a piece of shipping or packing tape to protect the pcb from scratches.  
Just lay a single 2-inch piece right across the middle and don't worry about the small bit of uncovered pcb on either side.

The various solder-jumpers are for hacking and custom software development.  
They are pre-connected for normal operation and you normally just ignore them. Don't solder them or cut them. If you get solder on them, clean it off to make the pcb flat again. The printed covers don't have cavities over those locations like for the other components.  
They can be used to make the RAM cards emulate a ROM card, or enable all 256K in RAM mode, etc.  
For the RAM cards, when bank size 128K is cut and 256K is jumpered, the bank switch becomes 2 banks of 256K instead of 4 banks of 128K, where positions 1 & 2 both select the same bank 1, and positions 3 & 4 both select the same bank 2.  

Most cards have a few different styles and configurations of the printed cover.  
If you are printing on your own FDM printer, the "slider" versions might be difficult to print accurately enough, so the "finger" versions are a simpler alternative.  
The bank switches are optional on all cards, so there are versions of the covers without any bank switch.  
For the ROM card this is also true for the write-protect switch.  
There are a few more options available in the openscad file. There are a lot of configurable variables with comments at the top of the file.  

Gerbers, BOMs, and STLs are in [releases](../../releases/)

[pictures](https://photos.app.goo.gl/M8KbMLbY8BXGH7LL8)

----

## SRAM CARD  
<!--
[128K SRAM BOM from DigiKey](https://www.digikey.com/short/fdjd3j85)  
[128K SRAM PCB and COVER from PCBWAY](https://www.pcbway.com/project/shareproject/WP_2_RAM_IC_Card.html)  
IMPORTANT, when ordering the PCB:  
* **Thickness: 1.2** <-- MOST IMPORTANT - DO NOT MISS  
* **Min Track/Spacing: 6/6mil**  
The PCBWAY ordering page may auto-select thinner minimum traces which is expensive, but thise pcb actually has all traces at least 0.2mm (7.8mil), so you should manually change the option to 6mil.  
* **Surface Finish: Immersion gold(ENIG)**  
Makes it expensive, but you want the battery terminal to be gold.  
* **Other Special request: Bottom solder mask full cover.**  
There are no openings in the bottom soldermask layer, so you have to tell them that you want 100% soldermask coverage rather than 0% coverage.

You can save some money on the ENIG by using Elecrow instead of PCBWAY.

![](PCB/out/WP-2_IC-Card_SRAM_128K.jpg)  
![](PCB/out/WP-2_IC-Card_SRAM_128K.covered.jpg)  
![](PCB/out/WP-2_IC-Card_SRAM_128K.top.jpg)  
![](PCB/out/WP-2_IC-Card_SRAM_128K.bottom.jpg)  
![](PCB/out/WP-2_IC-Card_SRAM_128K.svg)  
![](COVER/out/WP-2_IC-Card_Cover_SRAM.png)


****
### work in progress updated SRAM card
-->

Fully populated to use all of a 256K or 512K chip  
![](PCB/out/WP-2_IC-Card_SRAM.jpg)

Configured for a 128K chip, or to use just 128K of a larger chip  
![](PCB/out/WP-2_IC-Card_SRAM.ce2.jpg)

![](PCB/out/WP-2_IC-Card_SRAM.slider.jpg)  
![](PCB/out/WP-2_IC-Card_SRAM.finger.jpg)  
![](PCB/out/WP-2_IC-Card_SRAM.no_bank.jpg)  
![](PCB/out/WP-2_IC-Card_SRAM.write-enable.jpg)

![](PCB/out/WP-2_IC-Card_SRAM.top.jpg)  
![](PCB/out/WP-2_IC-Card_SRAM.bottom.jpg)  
![](PCB/out/WP-2_IC-Card_SRAM.svg)

(These links are for an earlier simpler version of the card without any banks. It still accepts up to 512K chip, but only uses 128K.)  
[128K SRAM BOM from DigiKey](https://www.digikey.com/short/fdjd3j85)  
[128K SRAM PCB and COVER from PCBWAY](https://www.pcbway.com/project/shareproject/WP_2_RAM_IC_Card.html)  

<!--
WP-2_IC-Card_Cover_SRAM_slider.stl is a cover with a sliding actuator for the bank switch  
WP-2_IC-Card_Cover_SRAM_finger.stl is a cover with a simple concave opening for the bank switch  
WP-2_IC-Card_Cover_SRAM_none.stl is a cover with no bank-switch opening  
-->

<!-- [128K SRAM PCB and COVER from PCBWAY](https://www.pcbway.com/project/shareproject/WP_2_RAM_IC_Card.html)  -->

<!-- When ordering the PCB:  -->
<!-- * **Thickness: 1.2** DO NOT FORGET  -->
<!--
* **Min Track/Spacing: 6/6mil**  
The PCBWAY ordering page may auto-select thinner minimum traces which is expensive, but thise pcb actually has all traces at least 0.2mm (7.8mil), so you should manually change the option to 6mil.  
-->
<!-- 
* **Surface Finish: Immersion gold(ENIG)**  (for the battery)  
* **Other Special request: "Bottom solder mask full cover."**  
-->
<!-- There are no openings in the bottom soldermask layer, so you have to tell them that you want full soldermask instead of none.  -->

<!-- Elecrow produces ENIG cheaper than PCBWAY. Just upload the gerber zip from [releases](../../releases) -->
<!--
For 128K (AS6C1008, IS62C1024, etc):  
  Don't populate SW1, D1, R3, R4  
  Solder-bridge JP4 VMEM-CE2  
  Print the "SRAM_none" cover  
-->


----

## MRAM Card

RAM card without a battery!

This card is expensive.  
The BOM cost is over $50 before tax or shipping and not including the PCB or the 3d-printed top cover.  
The total including PCB, BOM, printed cover, tax, & shipping is over $100.

However it does provide **4** 128k cards in a single card, without any battery.

NOTE: MRAM is permanently damaged by exposure to magnetic fields.  
The particular part used here is [internally shielded](PCB/datasheets/EST02880_Magnetic_Immunity_for_Everspin_MRAM_073115.pdf) and specifically the Industrial version claims to be safe to 125 gauss.  
The Commercial and Automotive versions are only safe to 25 gauss. A fridge magnet is 100 gauss.  
The BOM specifies the Industrial part so it should be reasonably safe, however you should still generally avoid exposure to magnetic fields.  

[512K MRAM PCB and COVER from PCBWAY](https://www.pcbway.com/project/shareproject/512k_MRAM_IC_Card_for_TANDY_WP_2_30f542a7.html)  
[512K MRAM BOM from DigiKey](https://www.digikey.com/short/nqjddjf5)  , [Mouser](https://www.mouser.com/ProjectManager/ProjectDetail.aspx?AccessID=f6eb946163)  
<!-- RIP Shapeways... [MRAM-512 cover from Shapeways](http://shpws.me/TIyf)  -->

Supports both a 512K chip with a bank-select switch for 4 x 128K banks, or a 128K chip and you simply omit the indicated bank-select parts.

![](ref/IMG_0049.JPG)  
![](ref/IMG_0050.JPG)  
![](ref/IMG_0053.JPG)  
![](ref/IMG_0058.JPG)  
![](PCB/out/WP-2_IC-Card_MRAM.jpg)  
![](PCB/out/WP-2_IC-Card_MRAM.slider.jpg)  
![](PCB/out/WP-2_IC-Card_MRAM.finger.jpg)  
![](PCB/out/WP-2_IC-Card_MRAM.top.jpg)  
![](PCB/out/WP-2_IC-Card_MRAM.bottom.jpg)  
![](PCB/out/WP-2_IC-Card_MRAM.svg)

----

## ROM CARD  
There are no known rom images for any rom cards.  
Don't bother building one of these unless you are trying to develop romware yourself.

<!-- [ROM card PCB from OSHPark](https://oshpark.com/shared_projects/F9gte3be) (Select 0.8mm PCB thickness)  -->
[ROM PCB from PCBWAY](https://www.pcbway.com/project/shareproject/WP_2_ROM_IC_Card.html)  
[ROM BOM from DigiKey](https://www.digikey.com/short/540dqm8m)

![](PCB/out/WP-2_IC-Card_ROM.jpg)  
![](PCB/out/WP-2_IC-Card_ROM.slider.jpg)  
![](PCB/out/WP-2_IC-Card_ROM.finger.jpg)  
![](PCB/out/WP-2_IC-Card_ROM.write-protect.jpg)  
![](PCB/out/WP-2_IC-Card_ROM.top.jpg)  
![](PCB/out/WP-2_IC-Card_ROM.bottom.jpg)  
![](PCB/out/WP-2_IC-Card_ROM.svg)

----

## Programming Adapter
The programming adapter supports both ROM and RAM cards.  
Use with a standard eprom programmer such as TL-866.

<!-- [Programming Adapter PCB from OSHPark](https://oshpark.com/shared_projects/TkzNwgho)  -->
[Programming Adapter PCB from PCBWAY](https://www.pcbway.com/project/shareproject/TANDY_WP_2_IC_Card_Programming_Adapter.html)

[Programming adapter BOM from DigiKey](https://www.digikey.com/short/v2r3pqp4)

![](/PCB/out/WP-2_IC-Card_programming_adapter.jpg)  

<!-- 
Example reading ROM card, jumpers in ROM position.
![](WP-2_IC-Card_programming_adapter.ROM.jpg)  

Example reading RAM card (SRAM or MRAM), jumpers in RAM position.
![](WP-2_IC-Card_programming_adapter.RAM.jpg)  
-->

![](PCB/out/WP-2_IC-Card_programming_adapter.svg)

### To program the ROM card

Switch the write-enable switch on the rom card to the unlock position.  
(or close the solder jumper JP1 if no switch installed)

Set all 4 jumpers on the programming adapter to ROM.

Example using a TL-866 programmer to write a file named `rom.bin` to the ROM card:  
`minipro --device SST39SF020A --write rom.bin`

<!-- old version of the breakout card also had a footprint for the rom chip and some extra pins to enable/disable it -->
<!-- current breakout card no longer has that, this is just for reference for TechTangents who has one.-->
<!-- 
### To program the Breakout/ROM card

Same as for ROM card except:

Install a jumper from /CE1 to /CE_IC on the card.  
Install a jumper from R/W to /WE_IC on the card.  (This one takes the place of the male jumper on the normal rom card above)  
Remove jumper from  GND to /DET on the card.  
-->

### Reading/Writing the RAM card

Set all 4 jumpers on the programming adapter to RAM.

Examples using a TL-866 programmer (628128 is the generic part number compatible with the SRAM on the card):  
`minipro --skip_id --device 628128 --read ram.bin`  
`minipro --skip_id --device 628128 --write ram.bin`

----

## BREAKOUT CARD

<!-- [Breakout PCB from OSHPark](https://oshpark.com/shared_projects/4spvX9oV) (Select 0.8mm PCB thickness)  -->
[Breakout PCB from PCBWAY](https://www.pcbway.com/project/shareproject/TANDY_WP_2_IC_Card_Breakout.html) (Select 1.2mm PCB thickness)  

[Breakout BOM from DigiKey](https://www.digikey.com/short/323npm39)  

![](PCB/out/WP-2_IC-Card_Breakout.jpg)  
![](PCB/out/WP-2_IC-Card_Breakout.svg)


# Moving files between a card and a PC

Connect the WP-2 to a PC via [9 pin female-female rs-232 null-modem cable](https://amazon.com/dp/B00QM8ZP5E) and [usb-serial adapter](https://amazon.com/dp/B074VN9ZG4)(usb-c example), 
or a one-piece [usb-null-modem cable](https://amazon.com/dp/B07DRHB264).

Run [DL2](https://github.com/bkw777/dl2) or [LaddieAlpha](https://bitchin100.com/wiki/index.php?title=LaddieCon#LaddieAlpha) on the pc.

Then use the WP-2 (press `F2`+`=`) to copy files between `MEMORY CARD` and `DISKETTE`.

# Reference Material
[WP-2 Owner & Service Manuals](https://archive.org/search.php?query=Tandy%20WP-2)  
Card slot signals & usage: Service Manual 8-2, C-3.  
Executable "RUN" files: Service Manual 4-16, D-1.

### Connector:  
[Original Connectors](ref/JC20-B38S-F1.pdf)  
Datasheet for both the slot in the computer and the connector in the card.  

You can't get the real connector any more, but you can get a generic socket header which fits the pins.  
The pins inside the card slot are 1 row x 38 pins, 1.27mm pitch, 6.0mm long

SAMTEC 8.5mm Pin Socket  
<https://duckduckgo.com/?q=SMS-138-01>  
<https://www.digikey.com/en/products/detail/samtec-inc/SMS-138-01-G-S/9773732>  
<https://www.mouser.com/ProductDetail/Samtec/SMS-138-01-G-S>

There are much less expensive generic female 1.27mm pin headers on ebay and aliexpress, but they don't work for this. Sorry :/ The metal parts inside the cheap connectors aren't held in place accurately enough, and the pins in the WP-2 hit the edges of the metal parts in female sockets, and no amount of wiggling gets all 38 pins to line up and let the card insert. And trying just risks damaging the pins inside the WP-2. So, the Samtec socket is both deep enough to take the 6mm-long pins, and is manufactured to tight enough tolerances that the pins slot right into the socket with no problems.

### Notes about some of the card slot signals:  

* Pin 2, /DET Card Detect  
  Pin 2 -> RA5 -> IC5 pin 64, "T1"
  
  WP-2 uses this to detect the type of card.  
  The pin is pulled up to VDD inside the WP-2.  
  A RAM card connects this pin to GND, which tells the WP-2 that it is a RAM card.  
  A ROM card leaves this pin not connected, which means it will be pulled high by the pullup resistor inside the WP-2, which tells the WP-2 that it is a ROM card.

* Pin 14, 2nd GND  
  This pin is tied to GND inside the WP-2, but it looks like it's an un-used input or output, not intended to be used as a power gnd.  
  It looks like this pin was partially implimented as Pin 14 -> RA5 -> IC5 pin 65, "T2", just like S1-S3, but ended up not being used in the final production.  
  So instead, IC5 pin 65 is pulled up to VDD and not connected to the socket or anything else, and the connector pin is tied to GND and not connected to anything else.  
  It's possible the "IC Card" spec defines a function for that pin, and the gnd is just a way to satisfy that part of the spec in case there are cards that expect it, like how CE2 is hard-wired to VDD.  
  
  The cards in this repo all include a cuttable solder-jumper to disconnect pin 14 from GND on the card, in case there is some other machine (not WP-2) that might not like the pin being shorted to gnd.

* Pin 3, CE2, active-high chip-enable  
  This is not a real CE2 signal from the WP-2, it's just connected directly to VDD inside the WP-2. The card is only enabled/disabled by /CE1. Some of these designs connect the pin anyway as long as the card is based on a chip that actually has a CE2 pin anyway, because it's possible there is some other machines besides WP-2 that use the same card standard, and possibly one of those might actually use the signal. But for instance the 512K MRAM chip does not have a CE2 pin, and that card does not bother to add logic to impliment it, so the pin is NC on that card.

* Pins 15, 16, & 36  
  
  Pin 15 -> RA5 -> IC5 pin 66, "S1"  
  Pin 16 -> RA5 -> IC5 pin 67, "S2"  
  Pin 36 -> RA5 -> IC5 pin 68, "S3"
  
  RA5 is 100k pullup to VDD.
  
  IC5 is a gate array with unknown programming.
  
  The S1, S2, S3 labels come from a schematic in the service manual. They are not mentioned anywhere else.
  
  The service manual says the original IC Cards have no connections on any of these pins (that's in the cards, not in the WP-2).
  
  It is unknown if the WP-2 does anything at all with these pins.  
  They are connected to a chip, and the chip is a gate array that could be programmed to do anything.  
  The only clues are that the pins are actually connected to anything at all instead of NC, and that they are pulled up rather than down or floating.  
  It suggests there was a possible reserved usage, and that it was an active-low signal, and that possibly software could do it on the existing hardware.  
  One guess for pins 15 & 16 might be made purely from their position on the connector. Possibly the spec for the "Toshiba IC-Card" interface includes pins for A18 and A19 that the WP-2 just doesn't happen to use. Though, unused address lines pins would more likely be pulled down than up, since address lines are active-high.

* Pin 17, A17: Only used for ROM. the WP-2 only supports up to 128K in a RAM card.

* Pin 37, BCHK/Vchk, Battery Voltage Check: It's unknown exactly how this was intended to be used by the "IC-Card" spec.  
  The SRAM card here simply connects pin 37 to BATT+. This seems to do nothing at all on a WP-2 but maybe some other machine like WP-3 or Citizen uses it.  
  The schematic on page 8-2 in the servivce manual doesn't show Vchk connecting to anything, and I also cannot find anything anywhere on the motherboard that has continuity with this pin.  
  Other similar machines did have a pin that was used for the host machine to read the level of the battery on a RAM card.  
  See the VBB pin in [Atari Portfolio Technical reference Guide, page 11](https://archive.org/details/atariportfoliotechnicalreferenceguide1989/page/n10/mode/1up).  

### Other similar machines and card standards that are NOT the same and NOT compatible

The "Toshiba IC-Card" appears to have been almost a standard, maybe, before PCMCIA type 1 was formalized. And so it's tempting to try to find other possible cards that might be compatible besides the ones sold by Tandy. There might be some but I have not found any yet.

Just for the sake of keeping track somewhere, the following look very similar, but are NOT the same and NOT compatible.

* Amstrad NC100 and clones & derivatives like NTS DreamWriter 325.  
  They look very similar but the memory card in those is PCMCIA Type 1, which is totally different from this.

* ITT Canon Star Card  
  Single row 38 pins (or maybe 39 or 40, references say 38-pin, but you can physically count 39 holes plus another smaller hole in pictures)
  But no polarity notch on the pin-38 side.

* Yamaha MCD32 / MCD64  
  This one is insidious. It combines both the fact that it *looks* perfect and probably fits perfectly,
  with the fact that it would short the WP-2's VCC directly to GND.
  It has the same single-row 38-pin connector and the same shape of keying notch on one side.
  You could probably plug this card in and it would probably fit perfectly.
  The key notch is on the on the wrong side, so you'd have to plug it in upside-down, but maybe the pins are just numbered the other way and doesn't really matter?
  Well it's not merely the same card but updside down. The pinout is different.
  Just for starters, MCD has GND on both pin 1 and pin 38, while WP-2 has GND on pin 1 and VCC on pin 38.
  So, no matter which direction the pin numbers count, no matter what the rest of the pinout looks like,
  if you managed to insert the card it would short the WP-2's VCC power rail directly to GND!

# TODO
* CamelFORTH on ROM?  
  But how to construct rom image?  
  Try to deduce how a rom is supposed to work by recording the bus while trying to load a dictionary while the breakout board has the /DET pin not connected to GND.

* Document how to create a RUN file.  
  Figure that out and write some sort of reproduceable toolchain & Makefile template hello world project to create new executables.  
  Known examples:  
  * John Hogerhuis [CamelFORTH](http://bitchin100.com/files/wp2/CAMEL.ZIP)  
  * "Christopher" from "randomvariations" [DUMPROM](https://randomvariations.com/category/tandy-wp-2/)  
  * Ben Grimmett [HEXVIEW](https://www.facebook.com/groups/Model.T.Computers/files/files)

* Use the programming adapter to dump ram card images and reverse engineer the "filesystem".  
  The files themselves (at least .DO) are already fairly well documented: https://bitchin100.com/files/wp2/wp2format.html

* Possibly eventually add an mcu to the card that can read & write the sram and present a standard usb mass storage interface to a pc.

* Add a 5v power output for a [MounT](https://github.com/bkw777/MounT) & [PDDuino](https://github.com/bkw777/PDDuino)?
