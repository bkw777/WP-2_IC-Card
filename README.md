# Expansion IC Card for TANDY WP-2

![](assembly_1.jpg)  
![](assembly_2.jpg)  
![](assembly_3.jpg)  
![](assembly_4.jpg)  
![](assembly_5.jpg)  
![](carrier_1.jpg)  
![](directions_1.jpg)  
![](directions_2.jpg)  
![](directions_3.jpg)  
![](directions_4.jpg)  
![](directions_5.jpg)  
![](PCB/WP-2_IC_Card_RAM_128K_1.jpg)  
![](PCB/WP-2_IC_Card_RAM_128K_2.jpg)  
![](PCB/WP-2_IC_Card_RAM_128K_3.jpg)  
![](PCB/WP-2_IC_Card_RAM_128K.svg)  

# Links to get the parts

NOT YET TESTED - BUY AT OWN RISK - FOR REFERENCE ONLY UNTIL VERIFIED  
Status: 2020-09-28 waiting for PCB and carrier to arrive  

3d-printed carrier (hint, select Multijet Fusion PA12 Black for a close match to the WP-2 itself)  
[ShapeWays](http://shpws.me/ShjK)  

PCB  
[OSHPark](https://oshpark.com/shared_projects/7Gr3WoFh) (Select 0.8mm pcb)  

SRAM  
[DigiKey](https://www.digikey.com/short/zw38nv)  
[Mouser](https://mou.sr/2GcUWHl) (ignore the pictures, several are wrong)  

Pin Socket  
[1x50 1.27mm pitch sockets](https://ebay.com/sch/i.html?_nkw=1.27mm+header+female) Look for single row by 40 or more pins.


# References
[WP-2 Manual](https://archive.org/search.php?query=Tandy%20WP-2)  
Contains schematics, pinout, and mechanical drawings of the card and slot.

[Card & Slot Connectors](ref/JC20-B38S-F1.pdf)  
Datasheet for both the slot in the computer and the connector in the card.

You can't get the real connector any more, but you can get a generic 1.27mm pitch 1x50 socket header which fits the pins.  
The card socket has 38 pins, and the generic socket has 50 pins. The extra socket pins can just be cut off.  
The pins in the slot inside the WP-2 are 6.0mm long, and the generic socket is only 4.4mm deep.  
The PCB is recessed so that when the card is inserted as far as possible, the pins only go 4.4mm into the socket.

Compatible RAM chips: SRAM 128Kx8 5v Parallel, TSOP-32 or sTSOP-32  

# TODO
See if 256K RAM works:  
[256Kx8 SRAM](https://www.mouser.com/ProductDetail/Alliance-Memory/AS6C2008A-55STIN)  
The WP-2 manual states that the max RAM card supported is 128K, and the max ROM card is 256K.  
There is an A17 pin in the slot. Try connecting the A17 line and just see if the WP-2 firmware actually recognizes 256K RAM.  

ROM version  
CamelFORTH on ROM  
But how to construct rom image?  

# Variations / WIP
v002:  
* Alternative pcb & carrier design to avoid unprintable thin walls around the pin header. Technically meets printability specs, but the big flat 0.7mm sheets are probably pushing the limit too far to actually get good results.  
![](Carrier/PCB_v002_1.jpg)  
![](Carrier/Carrier_v002_45mm_1.jpg)  
![](Carrier/Carrier_v002_45mm_2.jpg)  
![](Carrier/Carrier_v002_45mm_3.jpg)  

v003:  
This one looks good so far. Waiting for parts to verify.  
* "Captain Crunch" (smaller pcb)  
* keep-alive cap  
* attached A17 for possible 256K  
* redesign carrier to remove un-printable thin walls  
[v003 PCB at OSHPark](https://oshpark.com/shared_projects/2riwzeJS)  
[v003 Carrier at Shapeways](http://shpws.me/ShPp) or [v003 Carrier at Sculpteo](https://www.sculpteo.com/en/print/wp-2_ic_card_carrier_v003-6/EjsFtMjc)  
[WP-2_IC_Card_Carrier_v003.stl](Carrier/WP-2_IC_Card_Carrier_v003.stl)  
![](PCB/WP-2_IC_Card_RAM_128K_v003.svg)  
![](PCB/WP-2_IC_Card_RAM_128K_v003_1.jpg)  
![](Carrier/Carrier_v003_1.jpg)  
![](PCB/WP-2_IC_Card_RAM_128K_v003_2.jpg)  
![](PCB/WP-2_IC_Card_RAM_128K_v003_3.jpg)  
![](PCB/WP-2_IC_Card_RAM_128K_v003_4.jpg)  
![](PCB/WP-2_IC_Card_RAM_128K_v003_5.jpg)  
![](PCB/WP-2_IC_Card_RAM_128K_v003_6.jpg)  

v003-bare:  
* Experimenter, normal 1.6mm pcb, no carrier  
* Without a carrier to fill the slot and ensure the pin header is always perfectly centered, it's possible to damage the pins in the slot. Use with care.  
* v003 schematic  
<https://oshpark.com/shared_projects/ZoP4Znqc>  
![](PCB/WP-2_IC_Card_RAM_128K_bare_1.jpg)  

v004:  
* Different female pin header: SMS-138-01-x-x  
  PCB is the same as v003 except for the silkscreen version number and the 3d part models of the header and carrier.  
  carrier is different because the new header has different dimensions.  
[v004 Carrier at Shapeways](http://shpws.me/Si2L)  
![](WP-2_IC_Card_RAM_128K_v004_1.jpg)  
![](WP-2_IC_Card_RAM_128K_v004_2.jpg)  
![](WP-2_IC_Card_RAM_128K_v004_3.jpg)  
![](WP-2_IC_Card_RAM_128K_v004_4.jpg)  
![](WP-2_IC_Card_RAM_128K_v004_5.jpg)  
![](WP-2_IC_Card_RAM_128K_v004_6.jpg)  
![](WP-2_IC_Card_RAM_128K_v004_7.jpg)  
