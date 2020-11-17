# Expansion IC Card for TANDY WP-2

The TANDY WP-2 has an expansion slot that accepts "IC Cards" that may be either RAM or ROM, up to 128K RAM, up to 256K ROM. Here are two cards to fit that slot, a RAM card and a ROM card, and a programming adapter to program the ROM card. The RAM card includes a battery backup.

Both cards must be made from a thinner PCB than the standard 1.6mm.  
The RAM card may be up to 1.0mm thick.  
The ROM card may be up to 1.2mm thick.  

## Status: 2020-11-15  

<B>The RAM card is verified working.</B>  

However the current design uses diodes that are SUPER TINY. They are ridiculous to try to solder manually. Not just because they are so tiny. The even worse problem is that you can't see the polarity marking on the top, even with magnification, it's just too faint. With a lot of light and magnification you can just barely sort of maybe guess which direction is right. You have to actually test them with a meter. I need to find a larger package diode that still has the lowest possible forward voltage.

You CAN safely buy the parts and order the pcb for this design as of now, if you are OK with dealing with those diodes. The electrical design is at least verified and working.

<B>The ROM card is NOT verified working yet.</B>  
The ROM card may actually be ok but there was an error in the programming adapter.  
The current files are updated and the new programming adapter is on the way, but it's not proven yet.  


## RAM CARD  

Requires a thinner PCB than normal.  
This PCB may be up to 1.0mm thick.  

![](WP-2_IC_Card_RAM.jpg)  
![](PCB/WP-2_IC_Card_RAM.svg)  

[RAM card PCB from OSHPark](https://oshpark.com/shared_projects/eNruwuT6) (Select 0.8mm PCB thickness at checkout)  
[RAM card PCB from PCBWAY](https://www.pcbway.com/project/shareproject/WP_2_RAM_IC_Card.html) (Select 1.0mm PCB thickness at checkout)

[RAM card BOM from DigiKey](https://www.digikey.com/short/zn0wrr)


## ROM CARD

Requires a thinner PCB than normal.  
This PCB may be up to 1.2mm thick.  

![](WP-2_IC_Card_ROM.jpg)  
![](PCB/WP-2_IC_Card_ROM.svg)  

[ROM card PCB from OSHPark](https://oshpark.com/shared_projects/a1B99MTF) (Select 0.8mm PCB thickness at checkout)  
[ROM card PCB from PCBWAY](https://www.pcbway.com/project/shareproject/WP_2_ROM_IC_Card.html) (Select 1.2mm PCB thickness at checkout)  

[ROM card BOM from DigiKey](https://www.digikey.com/short/zn95jj)


## ROM Programming Adapter
Use with a standard eprom programmer such as TL-866, to write to the ROM card.

![](WP-2_IC_Card_ROM_programming_adapter.jpg)  
![](WP-2_IC_Card_ROM_programming_adapter_2.jpg)  
![](PCB/WP-2_IC_Card_ROM_programming_adapter.svg)  

[ROM Card programming adapter PCB from OSHPark](https://oshpark.com/shared_projects/r3IEDyuR)  
[ROM Card programming adapter PCB from PCBWAY](https://www.pcbway.com/project/shareproject/WP_2_IC_Card_ROM_programming_adapter.html)

[ROM Card programming adapter BOM from DigiKey](https://www.digikey.com/short/zn9rqn)

Build notes:

Make a "male jumper" for the WRITE pads on the ROM card by taking 2 of the left over 2.54mm pins and solder-bridge the two pins on the short side.  
There is a pair of holes in the programming adapter to store the write-enable jumper when not in use.

The center line of 1.27mm pins isn't quite tall enough to make good contact with the socket on the ROM card.  

Make the center pins taller this way:  

Start with the pcb you want to solder, and the pin header, and insert the pins into the top of the pcb, as expected, don't solder yet.  

Take one of the extra pcbs (you get 3 to 5 copies of the pcb depending on who you ordered the pcb from) and slide it onto the pins, all the way down to the insulator.  

Now you have a sandwich with two pcbs, and the pin header insulator in between.  

Flip the stack over so that you are looking at the bottom of the main pcb, and the bottom legs of the pins are facing up as though you were about to solder them.  

Take a small hard flat tool like the joined end of a set of tweezers or a spudger stick tool or something, lay the end of the tool flat on the ends of a few pins, and drive the pins straight in, right down flush with the surface of the pcb.

Support the stack by just holding on to the extra pcb, now positioned on the bottom of the stack while it's flipped upside down, and push directly on the end of the pins.

The extra pcb holds the pin header insulator in place and lets you drive the pin through the insulator, until the tool hits the surface of the main pcb.

Do this for all the pins untill all the pins are pushed through and the tips of the pins are flush with the surface of the pcb.  

Now apply flux to the pads and solder them. Just put solder on the iron and touch it to the pads, and let the flux bring the solder down into the via, leaving a little round dome. Give it at least a second per pin to heat up and flow down the hole.  

After all pins are soldered, slide the extra pcb off the pins. pull from both ends of the pcb at the same time to avoid tilting and binding and bending the pins on the way off. It really wants to do that.  

The point of all that was that now the pins are taller than they would have been and they're now tall enough to make good contact with the socket on the card.  

# Reference Material
[WP-2 Owner & Service Manuals](https://archive.org/search.php?query=Tandy%20WP-2)  
Card slot signals & usage: Service Manual 8-2, C-3.  
Executable "RUN" files: Service Manual 4-16, D-1.  

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

RAM:  
Compatible Specs: SRAM, 128Kx8, 5v, Parallel, TSOP-32 (8x20mm) or sTSOP-32 (8x14mm)  
Several parts are compatible. Several examples are listed in the schematic, and the BOM links include a compatibe part.  Here are some pre-loaded searches:  
[DigiKey](https://www.digikey.com/short/zw38nv)  
[Mouser](https://mou.sr/2GcUWHl) (many of the pictures are wrong, so ignore the pictures)  

ROM:  
Compatible Specs: FLASH, 256Kx8, 5v, Parallel, TSOP-32 (8x20mm) or sTSOP-32 (8x14mm)  
As with the SRAM, several parts are compatible. A few example part numbers are listed in the schematic, and the BOM links include a compatible part.  

Notes about some of the card slot signals:  

Pin 2, /DET Card Detect: WP-2 uses to detect the type of card. The pin has a pullup to VDD inside the WP-2. A RAM card should connect this pin to GND, which tells the WP-2 that it is a RAM card. A ROM card should leave this pin not connected, which means it will be pulled high by the pullup resistor inside the WP-2, which tells the WP-2 that it is a ROM card.

Pin 3, CE2, active-high chip-enable: CE2 is not actually an inverse copy of /CE1 and does not actually change state. It's wired directly to VDD inside the WP-2. It's even a heavy trace that could be used as an alternative power source not just a signal. Since it's not actually switched, it's not the best way to enable/disable the IC, even if the SRAM chip has a CE2 pin. It would work, just that the IC would be enabled 100% of the time that the card was inserted and the WP-2 was powered on. These PCBs don't connect CE2 from the WP-2. They do hardwire the CE2 pin on the SRAM chip to VMEM right on the card.

Pin 15 -> RA5 -> IC5 pin 66, "S1"  
Pin 16 -> RA5 -> IC5 pin 67, "S2"  
Pin 36 -> RA5 -> IC5 pin 68, "S3"  

RA5 is 100k pullup to VDD.  
IC5 is a gate array with unknown programming.  

The service manual says these pins (15, 16, 36) are NC in the original IC Cards.

Pin 17, A17: Only used for ROM. RAM may only go up to 128K. ROM may go to 256K. The RAM card does not connect A17. The ROM card does.

Pin 37, BCHK/Vchk, Battery Voltage Check: Unknown usage. The schematic on service manual page 8-2 doesn't show Vchk connecting to anything else. I also cannot find anything anywhere on the board that connects to the pin. I probed all over the board and could not find continuity anywhere. These PCBs don't connect Vchk.  

# TODO
CamelFORTH on ROM?  
But how to construct rom image? Same as RAM (which requires formatting and is a filesystem with multiple files and names and metadata like a disk)? Or raw executable written starting a 0x0000?

Document how to export gerbers for JLCPCB  

Document how to select the right options in JLCPCB  

Format the battery-backed SRAM version, save a few files on it, then use a temporary manually wired programming adapter (NOT the programming adapter for the ROM board), and use a programmer to dump the contents of the SRAM to examine how the WP-2 uses the RAM. If nothing else, perhaps it's possible to make a rom card that just looks like an ordinary ram filesystem with CamelFORTH or huge spellcheck & thesaurus dictionaries on it?  

Add a 5v power output to power a [MounT](https://github.com/bkw777/MounT) ?
