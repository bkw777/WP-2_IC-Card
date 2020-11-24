# Expansion IC Card for TANDY WP-2

The TANDY WP-2 has an expansion slot that accepts "IC Cards" that may be either RAM or ROM, up to 128K RAM, up to 256K ROM. Here are two cards to fit that slot, a RAM card and a ROM card, and a programming adapter to program the ROM card. The RAM card includes a battery backup.

Both cards must be made from a thinner PCB than the standard 1.6mm.  
The RAM card may be up to 1.0mm thick.  
The ROM card may be up to 1.2mm thick.  

## RAM CARD  

Requires a thinner PCB than normal.  
This PCB may be up to 1.0mm thick.  

![](WP-2_IC_Card_RAM.jpg)  
![](PCB/WP-2_IC_Card_RAM.svg)  

[RAM card PCB from OSHPark](https://oshpark.com/shared_projects/9GL8sgML) (Select 0.8mm PCB thickness at checkout)  
[RAM card PCB from PCBWAY](https://www.pcbway.com/project/shareproject/WP_2_RAM_IC_Card.html) (Select 1.0mm PCB thickness at checkout)

[RAM card BOM from DigiKey](https://www.digikey.com/short/z0bfvq)


## ROM CARD

Requires a thinner PCB than normal.  
This PCB may be up to 1.2mm thick.  

![](WP-2_IC_Card_ROM.jpg)  
![](PCB/WP-2_IC_Card_ROM.svg)  

[ROM card PCB from OSHPark](https://oshpark.com/shared_projects/X0Se70ZD) (Select 0.8mm PCB thickness at checkout)  
[ROM card PCB from PCBWAY](https://www.pcbway.com/project/shareproject/WP_2_ROM_IC_Card.html) (Select 1.2mm PCB thickness at checkout)  

[ROM card BOM from DigiKey](https://www.digikey.com/short/zn95jj)


## ROM Programming Adapter
Use with a standard eprom programmer such as TL-866, to write to the ROM card.

![](WP-2_IC_Card_ROM_programming_adapter.jpg)  
![](WP-2_IC_Card_ROM_programming_adapter_2.jpg)  
![](PCB/WP-2_IC_Card_ROM_programming_adapter.svg)  

[ROM Card programming adapter PCB from OSHPark](https://oshpark.com/shared_projects/tvMoYMrG)  
[ROM Card programming adapter PCB from PCBWAY](https://www.pcbway.com/project/shareproject/WP_2_IC_Card_ROM_programming_adapter.html)

[ROM Card programming adapter BOM from DigiKey](https://www.digikey.com/short/zn9rqn)

Build notes:

Make a "male jumper" for the WRITE ENABLE pads on the ROM card by taking 2 of the left over 2.54mm pins and solder-bridge the two pins on the short side.  
There is a pair of holes in the programming adapter to store the write-enable jumper when not in use.  

The center line of 1.27mm pins isn't quite tall enough to make good contact with the socket on the ROM card.  

Make the center pins taller this way:  

Take 2 programming adapter PCBs, one you will solder, one you will use as a jig.

Start with the pcb you want to solder, and the pin header, and insert the pins into the top of the pcb.  

Take the 2nd pcb and slide it onto the pins, all the way down to the insulator.  

Now you have a sandwich with two pcbs, and the pin header insulator in between.  

Flip the stack over so that you are looking at the bottom of the 1st pcb, and the bottom legs of the pins are facing up as though you were about to solder them.  

Support the 2nd pcb from the back and take a small hard flat tool like the joined end of a set of tweezers or a spudger stick or something, lay the end of the tool flat on the ends of a few pins, and press the pins straight in, right down flush with the surface of the pcb.

The 2nd pcb holds the pin header insulator in place and lets you drive the pins through the insulator, until the tool hits the surface of the 1st pcb.

Do this for all the pins untill all the pins are pushed through and the tips of the pins are flush with the surface of the pcb.  

Now apply flux to the pads and solder them. Just put solder on the iron and touch it to the pads, and let the flux bring the solder down into the via, leaving a little round dome.  

After all pins are soldered, slide the loose pcb off the pins.

The point of all that was that now the pins are taller than they would have been and they're now tall enough to make good contact with the socket on the card.  

Another option is, solder the pins normally without the above procedure, and then remove the insulator strip after the pins are soldered.

The 2 rows of DIP pins on the outside edges do not need any special treatment.

# Reference Material
[WP-2 Owner & Service Manuals](https://archive.org/search.php?query=Tandy%20WP-2)  
Card slot signals & usage: Service Manual 8-2, C-3.  
Executable "RUN" files: Service Manual 4-16, D-1.  

### Pin Socket Header:  
[Original Connectors](ref/JC20-B38S-F1.pdf)  
Datasheet for both the slot in the computer and the connector in the card.  

You can't get the real connector any more, but you can get a generic socket header which fits the pins.  
The pins inside the card slot are 1 row x 38 pins, 1.27mm pitch, 6.0mm long

SAMTEC 8.5mm Pin Socket  
<https://duckduckgo.com/?q=SMS-138-01>  
<https://www.digikey.com/en/products/detail/samtec-inc/SMS-138-01-G-S/9773732>  
<https://www.mouser.com/ProductDetail/Samtec/SMS-138-01-G-S>  

There are less expensive generic female 1.27mm pitch pin headers on ebay and aliexpress etc, but they don't work for this. Sorry :/

### RAM:  
Compatible Specs: SRAM, 128Kx8, 5v, Parallel, TSOP-32 (8x20mm) or sTSOP-32 (8x14mm)  
Several parts are compatible. Several examples are listed in the schematic, and the BOM links include a compatibe part.  Here are some pre-loaded searches:  
[DigiKey](https://www.digikey.com/short/zw38nv)  
[Mouser](https://mou.sr/2GcUWHl) (many of the pictures are wrong, so ignore the pictures)  

### ROM:  
Compatible Specs: FLASH, 256Kx8, 5v, Parallel, TSOP-32 (8x20mm) or sTSOP-32 (8x14mm)  
As with the SRAM, several parts are compatible. A few example part numbers are listed in the schematic, and the BOM links include a compatible part.  

Notes about some of the card slot signals:  

Pin 2, /DET Card Detect: WP-2 uses to detect the type of card. The pin has a pullup to VDD inside the WP-2. A RAM card should connect this pin to GND, which tells the WP-2 that it is a RAM card. A ROM card should leave this pin not connected, which means it will be pulled high by the pullup resistor inside the WP-2, which tells the WP-2 that it is a ROM card.

Pin 3, CE2, active-high chip-enable: CE2 is not actually an inverse copy of /CE1 and does not actually change state. It's wired directly to VDD inside the WP-2. Since it's not actually switched, it's not the best way to enable/disable the IC, even if the SRAM chip has a CE2 pin. It would work, just that the IC would be enabled 100% of the time that the card was inserted and the WP-2 was powered on. These PCBs don't connect CE2 from the WP-2. They do hardwire the CE2 pin on the SRAM chip to VMEM right on the card.

Pin 15 -> RA5 -> IC5 pin 66, "S1"  
Pin 16 -> RA5 -> IC5 pin 67, "S2"  
Pin 36 -> RA5 -> IC5 pin 68, "S3"  

RA5 is 100k pullup to VDD.  
IC5 is a gate array with unknown programming.  

The service manual says these pins (15, 16, 36) have no connection in the original IC Cards.

Pin 17, A17: Only used for ROM. RAM may only go up to 128K. ROM may go to 256K. The RAM card does not connect A17. The ROM card does.

Pin 37, BCHK/Vchk, Battery Voltage Check: Unknown usage. The schematic on service manual page 8-2 doesn't show Vchk connecting to anything, and I also cannot find anything anywhere on the board that connects to the pin. These PCBs don't connect this pin.  

### Reading the RAM card:  
You can read out the contents of the RAM card with the ROM card programming adapter, by just telling the programmer to ignore the chip ID and assume the device is a SST39SF010A. (128K version of the family of flash chip on the ROM card.)

The ROM card has a 256K 29F020-compatible chip, and the programming adapter presents a 29F020 pinout on the DIP pins to the programmer. The RAM card has a 128K SRAM.

So to read the RAM card just pretend it's a 128K version of 29F020, which is 29F010. Specifically an actual part number would be "SST39SF010A".   You can only read, NOT write. 
Example for a TL-866 programmer using the "minipro" util, read the ram card and save a copy to a file named ram.bin:
    minipro -x -p SST39SF010A -r ram.bin

# TODO
CamelFORTH on ROM?  
But how to construct rom image? Same as RAM?

Document how to export gerbers for JLCPCB/PCBWAY/etc  

Document how to select the right options in JLCPCB/PCBWAY/etc  

Add a 5v power output to power a [MounT](https://github.com/bkw777/MounT) ?
