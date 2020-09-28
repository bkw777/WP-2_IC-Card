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


# References
[WP-2 Manual](https://archive.org/search.php?query=Tandy%20WP-2)  
Contains schematics, pinout, and mechanical drawings of the card and slot.

[Card & Slot Connectors](ref/JC20-B38S-F1.pdf)  
Datasheet for both the slot in the computer and the connector in the card.

You can't get the real connector any more, but you can get a generic 1.27mm pitch 1x50 socket header which fits the pins.  
The card socket has 38 pins, and the generic socket has 50 pins. The extra socket pins can just be cut off.  
The pins in the slot inside the WP-2 are 6.0mm long, and the generic socket is only 4.4mm deep.  
The PCB is recessed so that when the card is inserted as far as possible, the pins only go 4.4mm into the socket.

[1x50 1.27mm pitch sockets](https://ebay.com/sch/i.html?_nkw=1.27mm+header+female)

Compatible RAM chips  
SRAM 128Kx8 5v Parallel TSOP-32 or sTSOP-32  
[DigiKey](https://www.digikey.com/short/zw38nv)  
[Mouser](https://mou.sr/2GcUWHl) (ignore the pictures, several have wrong pictures)  

# TODO
See if 256K RAM works:  
https://www.mouser.com/ProductDetail/Alliance-Memory/AS6C2008A-55STIN  
The WP-2 manual states that the max RAM card supported is 128K, and the max ROM card is 256K.  
There is an A17 pin in the slot. Try connecting the A17 line and just see if the WP-2 firmware actually recognizes 256K RAM.  

ROM version  
CamelFORTH on ROM  
But how to construct rom image?  
