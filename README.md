# Expansion IC Card for TANDY WP-2

Status: 2020-10-19  
Testing is almost done but not complete yet.  
STILL JUST FOR REFERENCE AT THIS TIME  

An earlier v003 RAM version has been tested and verified. The basic circuit works, and all physical/mechanical aspects of the v003 carrier and pcb outline and pin header are settled.
 
Changes from the last-tested version, which need to be proven:  
* Added D1 between VDD from the bus and the rest of the card, to prevent C1 from draining instantly into the WP-2 when the WP-2 is turned off while the card is connected.  
* Moved the disable-on-disconnect resistor (R2) from CE2-to-GND to /CE1-to-VMEM, and tied CE2 to VMEM. IE, use /CE1 to put the chip to sleep on disconnect instead of CE2. CE2 is tied to VDD inside the WP-2 not actually switched, so the pulldown had potential across it at all times not just when the chip was actively being used. So we may as well ignore it, and this removes an annoying trace that has to cross the entire board, and the /CE1 pullup only fights with the WP-2 briefly during actual access/use.  
* Changed value of R1 to 470 ohms to charge C1 faster, yet still limit the max power-on current to about 1ma.  

The ROM version has not been tested yet.  

The ROM programming adapter has not been tested yet.  

The v004_RAM_B version is entirely new. The battery circuit and physical fit of the battery holder and the alignment of the pin header without any carrier is all untested yet.  

PCBs are ordered for all boards and waiting for delivery.  
* v003_RAM - JLCPCB, 0.8mm pcb, black soldermask, ENIG finish, remove batch code  
* v003_ROM - JLCPCB, 0.8mm pcb, black soldermask, ENIG finish, remove batch code  
* v004_RAM_B - JLCPCB, 1.2mm pcb, black soldermask, ENIG finish, remove batch code  
* ROM programming adapter - OSHPARK, standard 1.6mm pcb  

## RAM version
![](WP-2_IC_Card_v003_RAM_1.jpg)  
![](WP-2_IC_Card_v003_RAM_2.jpg)  
![](WP-2_IC_Card_v003_RAM_3.jpg)  
![](WP-2_IC_Card_v003_Carrier.jpg)  
![](WP-2_IC_Card_v003_RAM_4.jpg)  
![](WP-2_IC_Card_v003_RAM_5.jpg)  
![](WP-2_IC_Card_v003_RAM_6.jpg)  
![](PCB/WP-2_IC_Card_v003_RAM.svg)  

CARRIER  (RAM and ROM versions both use this same carrier)  
[Carrier v003 at Shapeways](https://shpws.me/Si2L)  

PCB (Select 0.8mm pcb option at checkout)  
[PCB v003_RAM at OSHPark](https://oshpark.com/shared_projects/7H6gMMx5)  

BOM  
[Parts for v003_RAM from DigiKey](https://www.digikey.com/short/zn95q5)


## ROM version
![](WP-2_IC_Card_v003_ROM_1.jpg)  
![](WP-2_IC_Card_v003_ROM_2.jpg)  
![](WP-2_IC_Card_v003_ROM_3.jpg)  
![](PCB/WP-2_IC_Card_v003_ROM.svg)  

PCB (Select 0.8mm pcb option at checkout)  
[PCB v003_ROM at OSHPark](https://oshpark.com/shared_projects/rLP4ZOHt)  

BOM  
[Parts for v003_ROM from DigiKey](https://www.digikey.com/short/zn95jj)


## ROM Programming Adapter
![](WP-2_IC_Card_v003_ROM_programming_adapter_1.jpg)  
![](WP-2_IC_Card_v003_ROM_programming_adapter_2.jpg)  
![](WP-2_IC_Card_v003_ROM_programming_adapter_3.jpg)  
![](PCB/WP-2_IC_Card_v003_ROM_programming_adapter.svg)  

PCB (Select 0.8mm pcb option at checkout)  
[PCB v003_ROM_programming_adapter at OSHPark](https://oshpark.com/shared_projects/5rdprQ0J)  

BOM  
[Parts for v003_ROM_programming_adapter from DigiKey](https://www.digikey.com/short/zn9rqn)

Take 2 of the un-used pins from the 2.54mm set and solder-bridge one side to make a "male jumper" for the WRITE pads on the IC-Card. Bend the pins apart slightly so the fit is stiff.


## RAM version with battery and no carrier
![](WP-2_IC_Card_v004_RAM_B_1.jpg)  
![](WP-2_IC_Card_v004_RAM_B_2.jpg)  
![](WP-2_IC_Card_v004_RAM_B_3.jpg)  
![](WP-2_IC_Card_v004_RAM_B_4.jpg)  
![](WP-2_IC_Card_v004_RAM_B_5.jpg)  
![](PCB/WP-2_IC_Card_v004_RAM_B.svg)  

PCB (Select 0.8mm pcb option at checkout)  
[PCB v004_RAM_B at OSHPark](https://oshpark.com/shared_projects/ooY1Jmux)  

BOM  
[Parts for v004_RAM_B from DigiKey](https://www.digikey.com/short/znbqq9)


# Reference Material
[WP-2 Manual](https://archive.org/search.php?query=Tandy%20WP-2)  
Contains schematics, pinout, and mechanical drawings of the card and slot.

Pin Socket Header:  
[Original Connectors](ref/JC20-B38S-F1.pdf)  
Datasheet for both the slot in the computer and the connector in the card.  

You can't get the real connector any more, but you can get a generic socket header which fits the pins.  
The pins inside the card slot are 1 row x 38 pins, 1.27mm pitch, 6.0mm long

SAMTEC 8.5mm Pin Socket  
<https://duckduckgo.com/?q=SMS-138-01>  
<https://www.digikey.com/en/products/detail/samtec-inc/SMS-138-01-G-S/9773732>  
<https://www.mouser.com/ProductDetail/Samtec/SMS-138-01-G-S>  

There are less expensive generic female 1.27mm pitch pin headers on ebay and aliexpress etc, but they don't work for this. Sorry :/

PCB:  
The carrier needs 0.8mm thick PCBs instead of the standard 1.6mm.

The "..._B" PCBs need to be 1.2mm or thinner, not the standard 1.6mm. May use the 0.8mm option from OSHPark. JLCPCB has 1.2mm.  

The programing adapter has no special needs.  

RAM:  
Compatible Specs: SRAM, 128Kx8, 5v, Parallel, TSOP-32 (8x20mm) or sTSOP-32 (8x14mm)  
Several parts are compatible. Several examples are listed in the schematic, and the BOM links include a compatibe part.  Here are some pre-loaded searches:  
[DigiKey](https://www.digikey.com/short/zw38nv)  
[Mouser](https://mou.sr/2GcUWHl) (many of the pictures are wrong, so ignore the pictures)  

ROM:  
Compatible Specs: FLASH, 256Kx8, 5v, Parallel, TSOP-32 (8x20mm) or sTSOP-32 (8x14mm)  
As with the SRAM, several parts are compatible. A few example part numbers are listed in the schematic, and the BOM links include a compatible part.  

# TODO
CamelFORTH on ROM?  
But how to construct rom image?  

Document how to export gerbers for JLCPCB  

Document how to select the right options in JLCPCB  

Format the battery-backed SRAM version, save a few files on it, then use a temporary manually wired programming adapter (NOT the programming adapter for the ROM board), and use a programmer to dump the contents of the SRAM to examine how the WP-2 uses the RAM.  

Add a 5v power output to power a [MounT](https://github.com/bkw777/MounT) ?
