# Expansion IC Card for TANDY WP-2

NOT YET TESTED - FOR REFERENCE ONLY UNTIL VERIFIED  
Status: 2020-10-19  
Earlier version has been tested and verified. Current version waiting for PCB's to test.  

## RAM version
![](WP-2_IC_Card_v003_RAM_1.jpg)  
![](WP-2_IC_Card_v003_RAM_2.jpg)  
![](WP-2_IC_Card_v003_RAM_3.jpg)  
![](WP-2_IC_Card_v003_RAM_4.jpg)  
![](WP-2_IC_Card_v003_RAM_5.jpg)  
![](WP-2_IC_Card_v003_RAM_6.jpg)  
![](PCB/WP-2_IC_Card_v003_RAM.svg)  

3d-printed carrier  
[Carrier v003 at Shapeways](https://shpws.me/Si2L)  

PCB (Select 0.8mm pcb option at checkout)  
[PCB v003_RAM at OSHPark](https://oshpark.com/shared_projects/7H6gMMx5)  

BOM  
[Parts for v003_RAM from DigiKey](https://www.digikey.com/short/zn95q5)

## RAM version w/battery and no carrier
![](WP-2_IC_Card_v004_RAM_B_1.jpg)  
![](WP-2_IC_Card_v004_RAM_B_2.jpg)  
![](WP-2_IC_Card_v004_RAM_B_3.jpg)  
![](WP-2_IC_Card_v004_RAM_B.svg)  

PCB (Select 0.8mm pcb option at checkout)  
[PCB v004_RAM_B at OSHPark](https://oshpark.com/shared_projects/1InS1yR8)  

BOM  
[Parts for v004_RAM_B from DigiKey](https://www.digikey.com/short/znbqq9)


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
![](WP-2_IC_Card_v003_ROM_programming_adapter.svg)  

PCB (Select 0.8mm pcb option at checkout)  
[PCB v003_ROM_programming_adapter at OSHPark](https://oshpark.com/shared_projects/5rdprQ0J)  

BOM  
[Parts for v003_ROM_programming_adapter from DigiKey](https://www.digikey.com/short/zn9rqn)

Take 2 of the un-used pins from the 2.54mm set and solder-bridge one side to make a "male jumper" for the WRITE pads on the IC-Card. Bend the pins apart slightly so the fit is stiff.


# Reference
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
PCB needs to be 0.8mm thick instead of the standard 1.6mm.

RAM:  
SRAM, 128Kx8, 5v, Parallel, TSOP-32 (8x20mm) or sTSOP-32 (8x14mm)  
[DigiKey](https://www.digikey.com/short/zw38nv)  
[Mouser](https://mou.sr/2GcUWHl) (many of the pictures are wrong, so ignore the pictures)  

ROM:  
FLASH, 256Kx8, 5v, Parallel, TSOP-32 (8x20mm) or sTSOP-32 (8x14mm)  

# TODO
CamelFORTH on ROM?  
But how to construct rom image?  
