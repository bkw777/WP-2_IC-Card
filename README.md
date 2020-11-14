# Expansion IC Card for TANDY WP-2

The TANDY WP-2 has an expansion slot that accepts "IC Cards" that may be either RAM or ROM, up to 128K RAM, up to 256K ROM. Here are a few different types of cards to fit that slot. So far, one RAM and one ROM in the form of a small pcb that snaps into a 3d-printed carrier, and one RAM and one ROM in the form of a large pcb with no carrier. The large RAM card includes a battery backup.

All but the programming adapter must be thinner PCBs than the standard 1.6mm.  
The small cards that fit in the 3d-printed carrier must be 0.8mm thick.  
The large RAM card with the coin cell battery holder may be up to 1.0mm thick.  
The large ROM card may be up to 1.2mm thick.  

## Status: 2020-11-13  
Testing is almost done but not complete yet.  
Current designs delivered, in hand, just not built or tested yet.  
STILL JUST FOR REFERENCE AT THIS TIME  
I do not recommend ordering any of the PCBs until this notice is removed.

An earlier simpler RAM version has been tested and verified. The basic circuit works and the concept & operation proven, and all physical/mechanical aspects of the carrier and pcb outline and pin header are settled. What has not yet been tested are the ROM cards, ROM card programming adapter, and the capacitor and battery and diodes add-ons to the RAM cards.

## RAM CARDS

### RAM_cap_carried
RAM card with optional memory power capacitor, small pcb in a 3d-printed carrier.

You may build this two ways:  

Basic: Don't install any components other than the SRAM chip and pin socket. Solder-bridge the D1/SB1 footprint.

Full: Install all components, including a diode on D1/SB1.

Full configuration provides about 10 minutes of memory power from a capacitor while the card is ejected or the WP-2 power is off.

Requires a thinner PCB than normal.  
This PCB may be up to 0.8mm thick.  

![](WP-2_IC_Card_RAM_cap_carried_1.jpg)  
![](WP-2_IC_Card_RAM_cap_carried_2.jpg)  
![](WP-2_IC_Card_v003_Carrier.jpg)  
![](WP-2_IC_Card_RAM_cap_carried_3.jpg)  
![](WP-2_IC_Card_RAM_cap_carried_4.jpg)  
![](WP-2_IC_Card_RAM_cap_carried_empty.jpg)  
![](WP-2_IC_Card_RAM_cap_carried_no_cap_solder_bridge.jpg)  
![](WP-2_IC_Card_RAM_cap_carried_full.jpg)  
![](PCB/WP-2_IC_Card_RAM_cap_carried.svg)  

CARRIER  (RAM and ROM versions both use this same carrier)  
[Carrier v003 at Shapeways](https://shpws.me/Si2L)  

PCB  
[PCB RAM_cap_carried at OSHPark](https://oshpark.com/shared_projects/ElSkz5po) (Select 0.8mm pcb thickness at checkout)  

BOM  
[Parts for RAM_cap_carried from DigiKey](https://www.digikey.com/short/zdp7q1)


### RAM_cap_batt_no_carrier
RAM version with optional battery and no 3d-printed carrier.  

You may build this 4 ways:

Basic: Don't install any components other than the SRAM chip and pin socket. Solder-bridge the D1/SB1 footprint.  
Memory is lost immediately when the card is ejected or the WP-2 is turned off.

With cap, no battery: Install C1, R1, R2, and diode on D1/SB1.  
Provides about 10 minutes of memory power.

With battery, no cap: Install battery holder, D2, R2, and diode on D1/SB1.  
Provides about 10 years of memory power, but only while the battery remains connected. Memory is lost immediately if battery is removed.

Full: Install all components, including diode on D1/SB1.
Provides about 10 years of memory power, and about 10 minutes of memory power without the battery.

Requires a thinner PCB than normal.  
This PCB may be up to 1.0mm thick.  

![](WP-2_IC_Card_RAM_cap_batt_no_carrier_1.jpg)  
![](WP-2_IC_Card_RAM_cap_batt_no_carrier_empty.jpg)  
![](WP-2_IC_Card_RAM_cap_batt_no_carrier_no_cap_no_batt_solder_bridge.jpg)  
![](WP-2_IC_Card_RAM_cap_batt_no_carrier_no_batt.jpg)  
![](WP-2_IC_Card_RAM_cap_batt_no_carrier_no_cap.jpg)  
![](WP-2_IC_Card_RAM_cap_batt_no_carrier_full.jpg)  
![](PCB/WP-2_IC_Card_RAM_cap_batt_no_carrier.svg)  

PCB  
[PCB RAM_cap_batt_no_carrier at OSHPark](https://oshpark.com/shared_projects/eNruwuT6) (Select 0.8mm pcb thickness at checkout)  

BOM  
[Parts for RAM_cap_batt_no_carrier at DigiKey](https://www.digikey.com/short/zn0wrr)


## ROM CARDS

### ROM_carried
"ROM" based on a flash chip, which may be written using a matching programming adapter and standard eprom burner.

Requires a thinner PCB than normal.  
This PCB may be up to 0.8mm thick.  

![](WP-2_IC_Card_ROM_carried.jpg)  
![](PCB/WP-2_IC_Card_ROM_carried.svg)  

PCB  
[PCB ROM_carried at OSHPark](https://oshpark.com/shared_projects/zKWT2O4v) (Select 0.8mm pcb thickness at checkout)  
[PCB ROM_carried at PCBWAY](https://www.pcbway.com/project/shareproject/WP_2_IC_Card__256K_ROM__carried.html) (Select 0.8mm pcb thickness at checkout)  

BOM  
[Parts for ROM_carried from DigiKey](https://www.digikey.com/short/zn95jj)

### ROM_no_carrier
Same as above but on a big pcb with no carrier, instead of a small pcb in a 3d-printed carrier.  

Requires a thinner PCB than normal.  
This PCB may be up to 1.2mm thick.  

![](WP-2_IC_Card_ROM_no_carrier.jpg)  
![](PCB/WP-2_IC_Card_ROM_no_carrier.svg)  

PCB  
[PCB ROM_no_carrier at OSHPark](https://oshpark.com/shared_projects/GTC2pMRm) (Select 0.8mm pcb thickness at checkout)  
[PCB ROM_no_carrier at PCBWAY](https://www.pcbway.com/project/shareproject/WP_2_IC_Card_ROM_no_carrier.html) (Select 1.2mm pcb thickness at checkout)  

BOM  
[Parts for ROM_no_carrier at DigiKey](https://www.digikey.com/short/zn95jj)


## ROM Programming Adapter
Use with a standard eprom programmer such as TL-866, to write either of the ROM cards.

![](WP-2_IC_Card_ROM_programming_adapter.jpg)  
![](WP-2_IC_Card_ROM_programming_adapter_carried.jpg)  
![](WP-2_IC_Card_ROM_programming_adapter_no_carrier.jpg)  
![](PCB/WP-2_IC_Card_ROM_programming_adapter.svg)  

PCB    
[PCB ROM_programming_adapter at OSHPark](https://oshpark.com/shared_projects/AU1iXOKs)  
[PCB ROM_programming_adapter at PCBWAY](https://www.pcbway.com/project/shareproject/WP_2_IC_Card_ROM_programming_adapter.html)

BOM  
[Parts for ROM_programming_adapter from DigiKey](https://www.digikey.com/short/zn9rqn)

Make a write-enable jumper for the WRITE pads on the ROM IC Cards by taking 2 of the left over 2.54mm pins and solder-bridging the two pins on one side. Pinch the pins together a little to make the fit stiff when plugged into the WRITE holes on the card.



# Reference Material
[WP-2 Owner & Service Manuals](https://archive.org/search.php?query=Tandy%20WP-2)  
Card slot signals & usage: Service Manual 8-2, C-3. (other places like 4-20, 4-25 not as accurate)  
Executable/"RUN" files: Service Manual 4-16, D-1.  

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

Notes about the card slot pinout & signals:  
Some places in the Owner's Manual and Service Manual do not describe the IC Card pins accurately. The schematic on page 8-2 in the Service Manual is correct about all the following points.

Pin 2, /DET Card Detect: WP-2 uses to detect the type of card. The pin has a pullup to VDD inside the WP-2. RAM card should connect this pin to GND. ROM card should leave this pin not connected.

Pin 3, CE2, active-high chip-enable: Some places in the Service Manual claim this is an alternative chip-enable, equivalent to and inverse of /CE1. This is not true, and some other places in the service manual are correct. CE2 is not actually the inverse of /CE1 and does not actually change state. This pin is physically hardwired directly to VDD inside the WP-2. It's even a heavy trace that could be used as an alternative power source not just a signal. Since it's not actually switched, it's not the best way to enable/disable the IC. It would work, just that the IC would be enabled 100% of the time that the card was inserted and the WP-2 was powered on. These PCBs don't connect CE2.

Pins 15, 16, 36: Some places in the service manual say these pins are all NC, but they all actually connect to RA5 and IC5.  

Pin 15 -> RA5 -> IC5 pin 66, "S1" on IC5 on the schematic.  
Pin 16 -> RA5 -> IC5 pin 67, "S2" on IC5 on the schematic.  
Pin 15 -> RA5 -> IC5 pin 68, "S3" on IC5 on the schematic.  

RA5 is 5 x 100k pullup resistors to VDD.  
IC5 is a gate array with unknown programming.  

It's possible that the programming inside the gate array does not connect these pins to anything. But since the pins are physically connected to both the pullup resistors and the IC, it means the pins are not actually available for another use the way they would be if they were actually NC.  

For example, to enable writing the ROM card with the programming adapter, yet disable writing any other time, the card needs a pullup on /WE to the IC, and disconnected R/W pin from the card slot. If pins 15 and 16 were really not connected to anything inside the WP-2, then it would be possible to have the programming adapter automatically enable writing by having the R/W-/WE line pass out pin 15 and back in pin 16, and have the programming adapter connect pins 15 and 16 to each other. But since the pins actually do connect to things, don't do that.

Pin 17, A17: Only used for ROM. RAM may only go up to 128K. ROM may go to 256K. The RAM PCBs do not connect A17. The ROM PCBs do.

Pin 37, BCHK/Vchk, Battery Voltage Check: Unknown usage. The schematic on service manual page 8-2 doesn't show Vchk connecting to anything else. I probed all over the board and could not find continuity anywhere, but I couldn't see both sides of the pcb and so could not say for sure that the pin isn't connected to anything. These PCBs don't connect Vchk.  

# TODO
CamelFORTH on ROM?  
But how to construct rom image? Same as RAM (which requires formatting and is a filesystem with multiple files and names and metadata like a disk)? Or raw executable written starting a 0x0000?

Document how to export gerbers for JLCPCB  

Document how to select the right options in JLCPCB  

Format the battery-backed SRAM version, save a few files on it, then use a temporary manually wired programming adapter (NOT the programming adapter for the ROM board), and use a programmer to dump the contents of the SRAM to examine how the WP-2 uses the RAM.  

Add a 5v power output to power a [MounT](https://github.com/bkw777/MounT) ?

