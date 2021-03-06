EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr USLetter 11000 8500
encoding utf-8
Sheet 1 1
Title "TANDY WP-2 IC Card Breakout"
Date "2021-03-06"
Rev "002"
Comp "Brian K. White - b.kenyon.w@gmail.com"
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L 0_LOCAL:Conn_01x38_Female J1
U 1 1 5F6EF0A3
P 8500 3300
F 0 "J1" H 8000 5270 50  0000 L CNN
F 1 "Conn_01x38_Female" H 8150 5270 50  0000 L CNN
F 2 "0_LOCAL:PinSocket_1x38x1.27_edge_s" H 8500 3300 50  0001 C CNN
F 3 "~" H 8500 3300 50  0001 C CNN
	1    8500 3300
	1    0    0    -1  
$EndComp
Text Label 8300 1600 2    50   ~ 0
~DET
Text Label 8300 1800 2    50   ~ 0
~CE1
Text Label 8300 1900 2    50   ~ 0
~OE
Text Label 8300 2000 2    50   ~ 0
D0
Text Label 8300 2100 2    50   ~ 0
D1
Text Label 8300 2200 2    50   ~ 0
D2
Text Label 8300 2300 2    50   ~ 0
D3
Text Label 8300 2400 2    50   ~ 0
D4
Text Label 8300 2500 2    50   ~ 0
D5
Text Label 8300 2600 2    50   ~ 0
D6
Text Label 8300 2700 2    50   ~ 0
D7
Text Label 8300 3200 2    50   ~ 0
A16
Text Label 8300 3300 2    50   ~ 0
A15
Text Label 8300 3400 2    50   ~ 0
A14
Text Label 8300 3500 2    50   ~ 0
A13
Text Label 8300 3600 2    50   ~ 0
A12
Text Label 8300 3700 2    50   ~ 0
A11
Text Label 8300 3800 2    50   ~ 0
A10
Text Label 8300 3900 2    50   ~ 0
A9
Text Label 8300 4000 2    50   ~ 0
A8
Text Label 8300 4100 2    50   ~ 0
A7
Text Label 8300 4200 2    50   ~ 0
A6
Text Label 8300 4300 2    50   ~ 0
A5
Text Label 8300 4400 2    50   ~ 0
A4
Text Label 8300 4500 2    50   ~ 0
A3
Text Label 8300 4600 2    50   ~ 0
A2
Text Label 8300 4700 2    50   ~ 0
A1
Text Label 8300 4800 2    50   ~ 0
A0
Entry Wire Line
	7800 1700 7900 1800
Wire Wire Line
	7900 1800 8300 1800
Entry Wire Line
	7800 1800 7900 1900
Wire Wire Line
	7900 1900 8300 1900
Entry Wire Line
	7800 1900 7900 2000
Wire Wire Line
	7900 2000 8300 2000
Entry Wire Line
	7800 2000 7900 2100
Wire Wire Line
	7900 2100 8300 2100
Entry Wire Line
	7800 2100 7900 2200
Wire Wire Line
	7900 2200 8300 2200
Entry Wire Line
	7800 2200 7900 2300
Wire Wire Line
	7900 2300 8300 2300
Entry Wire Line
	7800 2300 7900 2400
Wire Wire Line
	7900 2400 8300 2400
Entry Wire Line
	7800 2400 7900 2500
Wire Wire Line
	7900 2500 8300 2500
Entry Wire Line
	7800 2500 7900 2600
Wire Wire Line
	7900 2600 8300 2600
Entry Wire Line
	7800 2600 7900 2700
Wire Wire Line
	7900 2700 8300 2700
Entry Wire Line
	7800 4000 7900 4100
Wire Wire Line
	7900 4100 8300 4100
Entry Wire Line
	7800 4100 7900 4200
Wire Wire Line
	7900 4200 8300 4200
Entry Wire Line
	7800 4200 7900 4300
Wire Wire Line
	7900 4300 8300 4300
Entry Wire Line
	7800 4300 7900 4400
Wire Wire Line
	7900 4400 8300 4400
Entry Wire Line
	7800 4400 7900 4500
Wire Wire Line
	7900 4500 8300 4500
Entry Wire Line
	7800 4500 7900 4600
Wire Wire Line
	7900 4600 8300 4600
Entry Wire Line
	7800 4600 7900 4700
Wire Wire Line
	7900 4700 8300 4700
Entry Wire Line
	7800 4700 7900 4800
Wire Wire Line
	7900 4800 8300 4800
Entry Wire Line
	7800 3200 7900 3300
Wire Wire Line
	7900 3300 8300 3300
Entry Wire Line
	7800 3300 7900 3400
Wire Wire Line
	7900 3400 8300 3400
Entry Wire Line
	7800 3400 7900 3500
Wire Wire Line
	7900 3500 8300 3500
Entry Wire Line
	7800 3500 7900 3600
Wire Wire Line
	7900 3600 8300 3600
Entry Wire Line
	7800 3600 7900 3700
Wire Wire Line
	7900 3700 8300 3700
Entry Wire Line
	7800 3700 7900 3800
Wire Wire Line
	7900 3800 8300 3800
Entry Wire Line
	7800 3800 7900 3900
Wire Wire Line
	7900 3900 8300 3900
Entry Wire Line
	7800 3900 7900 4000
Wire Wire Line
	7900 4000 8300 4000
Entry Wire Line
	7800 3100 7900 3200
Wire Wire Line
	7900 3200 8300 3200
$Comp
L power:GND #PWR0102
U 1 1 5F75F688
P 8300 1500
F 0 "#PWR0102" H 8300 1250 50  0001 C CNN
F 1 "GND" V 8300 1350 50  0000 R CNN
F 2 "" H 8300 1500 50  0001 C CNN
F 3 "" H 8300 1500 50  0001 C CNN
	1    8300 1500
	0    1    1    0   
$EndComp
$Comp
L power:VDD #PWR0103
U 1 1 5F7647D4
P 8300 5200
F 0 "#PWR0103" H 8300 5050 50  0001 C CNN
F 1 "VDD" V 8260 5300 50  0000 L CNN
F 2 "" H 8300 5200 50  0001 C CNN
F 3 "" H 8300 5200 50  0001 C CNN
	1    8300 5200
	0    -1   -1   0   
$EndComp
Text Notes 8540 1640 0    50   ~ 0
Card Detect: GND for RAM, NC for ROM
Text Notes 8530 5140 0    50   ~ 0
Battery Voltage Check - NC in WP-2
Text Notes 8530 5230 0    50   ~ 0
+5v
Text Notes 7960 1200 0    50   ~ 0
1x38 Female 1.27mm
$Comp
L 0_LOCAL:SST39SF020_TSOP U2
U 1 1 5F906116
P 6410 3300
F 0 "U2" H 6410 3300 50  0000 C CNN
F 1 "FLASH 256Kx8 5v Parallel" H 6410 4880 50  0000 C CNN
F 2 "0_LOCAL:TSOP32-14mm" H 5910 4450 50  0001 C CNN
F 3 "https://ww1.microchip.com/downloads/en/DeviceDoc/20005022C.pdf" H 6410 3300 50  0001 C CNN
	1    6410 3300
	1    0    0    -1  
$EndComp
Entry Wire Line
	5500 2900 5600 3000
Entry Wire Line
	5500 3000 5600 3100
Entry Wire Line
	5500 3100 5600 3200
Entry Wire Line
	5500 3200 5600 3300
Entry Wire Line
	5500 3300 5600 3400
Entry Wire Line
	5500 3400 5600 3500
Entry Wire Line
	5500 3500 5600 3600
Entry Wire Line
	5500 3600 5600 3700
Entry Wire Line
	5500 2100 5600 2200
Entry Wire Line
	5500 2200 5600 2300
Entry Wire Line
	5500 2300 5600 2400
Entry Wire Line
	5500 2400 5600 2500
Entry Wire Line
	5500 2500 5600 2600
Entry Wire Line
	5500 2600 5600 2700
Entry Wire Line
	5500 2700 5600 2800
Entry Wire Line
	5500 2800 5600 2900
Entry Wire Line
	5500 2000 5600 2100
Entry Wire Line
	5500 4300 5600 4400
Entry Wire Line
	5500 4200 5600 4300
Entry Wire Line
	7200 2100 7300 2000
Wire Wire Line
	7010 2100 7200 2100
Entry Wire Line
	7200 2200 7300 2100
Wire Wire Line
	7010 2200 7200 2200
Entry Wire Line
	7200 2300 7300 2200
Wire Wire Line
	7010 2300 7200 2300
Entry Wire Line
	7200 2400 7300 2300
Wire Wire Line
	7010 2400 7200 2400
Entry Wire Line
	7200 2500 7300 2400
Wire Wire Line
	7010 2500 7200 2500
Entry Wire Line
	7200 2600 7300 2500
Wire Wire Line
	7010 2600 7200 2600
Entry Wire Line
	7200 2700 7300 2600
Wire Wire Line
	7010 2700 7200 2700
Entry Wire Line
	7200 2800 7300 2700
Wire Wire Line
	7010 2800 7200 2800
Text Label 5810 4400 2    50   ~ 0
~OE
Text Label 5810 4300 2    50   ~ 0
~CE_IC
Text Label 5810 3700 2    50   ~ 0
A16
Text Label 5810 3600 2    50   ~ 0
A15
Text Label 5810 3500 2    50   ~ 0
A14
Text Label 5810 3400 2    50   ~ 0
A13
Text Label 5810 3300 2    50   ~ 0
A12
Text Label 5810 3200 2    50   ~ 0
A11
Text Label 5810 3100 2    50   ~ 0
A10
Text Label 5810 3000 2    50   ~ 0
A9
Text Label 5810 2900 2    50   ~ 0
A8
Text Label 5810 2800 2    50   ~ 0
A7
Text Label 5810 2700 2    50   ~ 0
A6
Text Label 5810 2600 2    50   ~ 0
A5
Text Label 5810 2500 2    50   ~ 0
A4
Text Label 5810 2400 2    50   ~ 0
A3
Text Label 5810 2300 2    50   ~ 0
A2
Text Label 5810 2200 2    50   ~ 0
A1
Text Label 5810 2100 2    50   ~ 0
A0
Text Label 7010 2100 0    50   ~ 0
D0
Text Label 7010 2200 0    50   ~ 0
D1
Text Label 7010 2300 0    50   ~ 0
D2
Text Label 7010 2400 0    50   ~ 0
D3
Text Label 7010 2500 0    50   ~ 0
D4
Text Label 7010 2600 0    50   ~ 0
D5
Text Label 7010 2700 0    50   ~ 0
D6
Text Label 7010 2800 0    50   ~ 0
D7
$Comp
L power:GND #PWR0107
U 1 1 5F90616D
P 6410 4500
F 0 "#PWR0107" H 6410 4250 50  0001 C CNN
F 1 "GND" H 6450 4290 50  0000 C CNN
F 2 "" H 6410 4500 50  0001 C CNN
F 3 "" H 6410 4500 50  0001 C CNN
	1    6410 4500
	1    0    0    -1  
$EndComp
Wire Wire Line
	5600 4300 5810 4300
Wire Wire Line
	5600 4400 5810 4400
Wire Wire Line
	5600 3700 5810 3700
Wire Wire Line
	5600 3600 5810 3600
Wire Wire Line
	5600 3500 5810 3500
Wire Wire Line
	5600 3400 5810 3400
Wire Wire Line
	5600 3300 5810 3300
Wire Wire Line
	5600 3200 5810 3200
Wire Wire Line
	5600 3100 5810 3100
Wire Wire Line
	5600 3000 5810 3000
Wire Wire Line
	5600 2900 5810 2900
Wire Wire Line
	5600 2800 5810 2800
Wire Wire Line
	5600 2700 5810 2700
Wire Wire Line
	5600 2600 5810 2600
Wire Wire Line
	5600 2500 5810 2500
Wire Wire Line
	5600 2400 5810 2400
Wire Wire Line
	5600 2300 5810 2300
Wire Wire Line
	5600 2200 5810 2200
Wire Wire Line
	5600 2100 5810 2100
$Comp
L power:GND #PWR0108
U 1 1 5FA08971
P 8300 2800
F 0 "#PWR0108" H 8300 2550 50  0001 C CNN
F 1 "GND" V 8300 2650 50  0000 R CNN
F 2 "" H 8300 2800 50  0001 C CNN
F 3 "" H 8300 2800 50  0001 C CNN
	1    8300 2800
	0    1    1    0   
$EndComp
Connection ~ 5500 5200
Entry Wire Line
	5500 3700 5600 3800
Text Label 5810 3800 2    50   ~ 0
A17
Wire Wire Line
	5600 3800 5810 3800
Entry Wire Line
	7800 3000 7900 3100
Wire Wire Line
	7900 3100 8300 3100
Text Label 8300 3100 2    50   ~ 0
A17
Text Notes 8540 1540 0    50   ~ 0
GND
Text Notes 8540 2840 0    50   ~ 0
GND
$Comp
L power:VDD #PWR0110
U 1 1 5F83B4C3
P 6410 2000
F 0 "#PWR0110" H 6410 1850 50  0001 C CNN
F 1 "VDD" H 6410 2150 50  0000 L CNN
F 2 "" H 6410 2000 50  0001 C CNN
F 3 "" H 6410 2000 50  0001 C CNN
	1    6410 2000
	1    0    0    -1  
$EndComp
$Comp
L 0_LOCAL:R R1
U 1 1 5F8FDC45
P 4740 5500
F 0 "R1" V 4650 5500 50  0000 C CNN
F 1 "47K" V 4740 5500 50  0000 C CNN
F 2 "0_LOCAL:R_0805" V 4670 5500 50  0001 C CNN
F 3 "~" H 4740 5500 50  0001 C CNN
	1    4740 5500
	0    1    1    0   
$EndComp
Entry Wire Line
	4300 5400 4400 5500
Text Label 4400 5500 0    50   ~ 0
~WE_IC
$Comp
L power:VDD #PWR0111
U 1 1 5F9099AB
P 4890 5500
F 0 "#PWR0111" H 4890 5350 50  0001 C CNN
F 1 "VDD" V 4890 5650 50  0000 L CNN
F 2 "" H 4890 5500 50  0001 C CNN
F 3 "" H 4890 5500 50  0001 C CNN
	1    4890 5500
	0    1    1    0   
$EndComp
Text Label 5810 4200 2    50   ~ 0
~WE_IC
Wire Wire Line
	5600 4200 5810 4200
Entry Wire Line
	5500 4100 5600 4200
Text Notes 4360 1240 0    50   ~ 0
U1/U2: SST39SF020A AM29F020 GLS29EE020
$Comp
L 0_LOCAL:SST39SF020_TSOP U1
U 1 1 5FA8764D
P 4310 3300
F 0 "U1" H 4310 3300 50  0000 C CNN
F 1 "FLASH 256Kx8 5v Parallel" H 4310 4880 50  0000 C CNN
F 2 "0_LOCAL:TSOP32-20mm" H 3810 4450 50  0001 C CNN
F 3 "https://ww1.microchip.com/downloads/en/DeviceDoc/20005022C.pdf" H 4310 3300 50  0001 C CNN
	1    4310 3300
	1    0    0    -1  
$EndComp
Entry Wire Line
	3400 2900 3500 3000
Entry Wire Line
	3400 3000 3500 3100
Entry Wire Line
	3400 3100 3500 3200
Entry Wire Line
	3400 3200 3500 3300
Entry Wire Line
	3400 3300 3500 3400
Entry Wire Line
	3400 3400 3500 3500
Entry Wire Line
	3400 3500 3500 3600
Entry Wire Line
	3400 3600 3500 3700
Entry Wire Line
	3400 2100 3500 2200
Entry Wire Line
	3400 2200 3500 2300
Entry Wire Line
	3400 2300 3500 2400
Entry Wire Line
	3400 2400 3500 2500
Entry Wire Line
	3400 2500 3500 2600
Entry Wire Line
	3400 2600 3500 2700
Entry Wire Line
	3400 2700 3500 2800
Entry Wire Line
	3400 2800 3500 2900
Entry Wire Line
	3400 2000 3500 2100
Entry Wire Line
	3400 4300 3500 4400
Entry Wire Line
	3400 4200 3500 4300
Entry Wire Line
	5100 2100 5200 2000
Wire Wire Line
	4910 2100 5100 2100
Entry Wire Line
	5100 2200 5200 2100
Wire Wire Line
	4910 2200 5100 2200
Entry Wire Line
	5100 2300 5200 2200
Wire Wire Line
	4910 2300 5100 2300
Entry Wire Line
	5100 2400 5200 2300
Wire Wire Line
	4910 2400 5100 2400
Entry Wire Line
	5100 2500 5200 2400
Wire Wire Line
	4910 2500 5100 2500
Entry Wire Line
	5100 2600 5200 2500
Wire Wire Line
	4910 2600 5100 2600
Entry Wire Line
	5100 2700 5200 2600
Wire Wire Line
	4910 2700 5100 2700
Entry Wire Line
	5100 2800 5200 2700
Wire Wire Line
	4910 2800 5100 2800
Text Label 3710 4400 2    50   ~ 0
~OE
Text Label 3710 4300 2    50   ~ 0
~CE_IC
Text Label 3710 3700 2    50   ~ 0
A16
Text Label 3710 3600 2    50   ~ 0
A15
Text Label 3710 3500 2    50   ~ 0
A14
Text Label 3710 3400 2    50   ~ 0
A13
Text Label 3710 3300 2    50   ~ 0
A12
Text Label 3710 3200 2    50   ~ 0
A11
Text Label 3710 3100 2    50   ~ 0
A10
Text Label 3710 3000 2    50   ~ 0
A9
Text Label 3710 2900 2    50   ~ 0
A8
Text Label 3710 2800 2    50   ~ 0
A7
Text Label 3710 2700 2    50   ~ 0
A6
Text Label 3710 2600 2    50   ~ 0
A5
Text Label 3710 2500 2    50   ~ 0
A4
Text Label 3710 2400 2    50   ~ 0
A3
Text Label 3710 2300 2    50   ~ 0
A2
Text Label 3710 2200 2    50   ~ 0
A1
Text Label 3710 2100 2    50   ~ 0
A0
Text Label 4910 2100 0    50   ~ 0
D0
Text Label 4910 2200 0    50   ~ 0
D1
Text Label 4910 2300 0    50   ~ 0
D2
Text Label 4910 2400 0    50   ~ 0
D3
Text Label 4910 2500 0    50   ~ 0
D4
Text Label 4910 2600 0    50   ~ 0
D5
Text Label 4910 2700 0    50   ~ 0
D6
Text Label 4910 2800 0    50   ~ 0
D7
$Comp
L power:GND #PWR0101
U 1 1 5FA878F5
P 4310 4500
F 0 "#PWR0101" H 4310 4250 50  0001 C CNN
F 1 "GND" H 4350 4290 50  0000 C CNN
F 2 "" H 4310 4500 50  0001 C CNN
F 3 "" H 4310 4500 50  0001 C CNN
	1    4310 4500
	1    0    0    -1  
$EndComp
Wire Wire Line
	3500 4300 3710 4300
Wire Wire Line
	3500 4400 3710 4400
Wire Wire Line
	3500 3700 3710 3700
Wire Wire Line
	3500 3600 3710 3600
Wire Wire Line
	3500 3500 3710 3500
Wire Wire Line
	3500 3400 3710 3400
Wire Wire Line
	3500 3300 3710 3300
Wire Wire Line
	3500 3200 3710 3200
Wire Wire Line
	3500 3100 3710 3100
Wire Wire Line
	3500 3000 3710 3000
Wire Wire Line
	3500 2900 3710 2900
Wire Wire Line
	3500 2800 3710 2800
Wire Wire Line
	3500 2700 3710 2700
Wire Wire Line
	3500 2600 3710 2600
Wire Wire Line
	3500 2500 3710 2500
Wire Wire Line
	3500 2400 3710 2400
Wire Wire Line
	3500 2300 3710 2300
Wire Wire Line
	3500 2200 3710 2200
Wire Wire Line
	3500 2100 3710 2100
Entry Wire Line
	3400 3700 3500 3800
Text Label 3710 3800 2    50   ~ 0
A17
Wire Wire Line
	3500 3800 3710 3800
$Comp
L power:VDD #PWR0104
U 1 1 5FA87915
P 4310 2000
F 0 "#PWR0104" H 4310 1850 50  0001 C CNN
F 1 "VDD" H 4310 2150 50  0000 L CNN
F 2 "" H 4310 2000 50  0001 C CNN
F 3 "" H 4310 2000 50  0001 C CNN
	1    4310 2000
	1    0    0    -1  
$EndComp
Text Label 3710 4200 2    50   ~ 0
~WE_IC
Wire Wire Line
	3500 4200 3710 4200
Entry Wire Line
	3400 4100 3500 4200
Connection ~ 5200 5200
Wire Bus Line
	5200 5200 5500 5200
Text Notes 3810 1610 0    50   ~ 0
TSOP-I-32 8x20 footprint
Text Notes 5900 1610 0    50   ~ 0
sTSOP-I-32 8x14 footprint
Text Label 8300 4900 2    50   ~ 0
R~W
Text Notes 8540 1740 0    50   ~ 0
Hard trace to VDD.
Text Notes 8550 2930 0    50   ~ 0
IC5_66
Text Notes 8550 3030 0    50   ~ 0
IC5_67
Text Notes 8530 5030 0    50   ~ 0
IC5_68
Entry Wire Line
	7800 4800 7900 4900
Wire Wire Line
	8300 4900 7900 4900
NoConn ~ 3710 3900
NoConn ~ 5810 3900
Wire Bus Line
	5500 5200 7300 5200
$Comp
L 0_LOCAL:Conn_02x20_Odd_Even J2
U 1 1 60471143
P 2000 3000
F 0 "J2" H 2050 4150 50  0000 C CNN
F 1 "Conn_02x20_Odd_Even" H 2050 4050 50  0000 C CNN
F 2 "0_LOCAL:PinHeader_2x20_P2.54mm" H 2000 3000 50  0001 C CNN
F 3 "~" H 2000 3000 50  0001 C CNN
	1    2000 3000
	1    0    0    -1  
$EndComp
Wire Bus Line
	1400 5200 2700 5200
Entry Wire Line
	1400 2100 1500 2200
Wire Wire Line
	1800 2200 1500 2200
Entry Wire Line
	1400 2200 1500 2300
Wire Wire Line
	1800 2300 1500 2300
Entry Wire Line
	1400 2300 1500 2400
Wire Wire Line
	1800 2400 1500 2400
Entry Wire Line
	1400 2400 1500 2500
Wire Wire Line
	1800 2500 1500 2500
Entry Wire Line
	1400 2500 1500 2600
Wire Wire Line
	1800 2600 1500 2600
Entry Wire Line
	1400 2600 1500 2700
Wire Wire Line
	1800 2700 1500 2700
Entry Wire Line
	1400 2700 1500 2800
Wire Wire Line
	1800 2800 1500 2800
Entry Wire Line
	1400 2800 1500 2900
Wire Wire Line
	1800 2900 1500 2900
Entry Wire Line
	1400 2900 1500 3000
Wire Wire Line
	1800 3000 1500 3000
Entry Wire Line
	1400 3000 1500 3100
Wire Wire Line
	1800 3100 1500 3100
Entry Wire Line
	1400 3100 1500 3200
Wire Wire Line
	1800 3200 1500 3200
Entry Wire Line
	1400 3200 1500 3300
Wire Wire Line
	1800 3300 1500 3300
Entry Wire Line
	1400 3300 1500 3400
Wire Wire Line
	1800 3400 1500 3400
Entry Wire Line
	1400 3400 1500 3500
Wire Wire Line
	1800 3500 1500 3500
Entry Wire Line
	1400 3500 1500 3600
Wire Wire Line
	1800 3600 1500 3600
Entry Wire Line
	1400 3600 1500 3700
Wire Wire Line
	1800 3700 1500 3700
Entry Wire Line
	1400 3900 1500 4000
Wire Wire Line
	1800 4000 1500 4000
Entry Wire Line
	2600 2100 2700 2000
Wire Wire Line
	2300 2100 2600 2100
Entry Wire Line
	2600 2200 2700 2100
Wire Wire Line
	2300 2200 2600 2200
Entry Wire Line
	2600 2300 2700 2200
Wire Wire Line
	2300 2300 2600 2300
Entry Wire Line
	2600 2400 2700 2300
Wire Wire Line
	2300 2400 2600 2400
Entry Wire Line
	2600 2500 2700 2400
Wire Wire Line
	2300 2500 2600 2500
Entry Wire Line
	2600 2600 2700 2500
Wire Wire Line
	2300 2600 2600 2600
Entry Wire Line
	2600 2800 2700 2700
Wire Wire Line
	2300 2800 2600 2800
Entry Wire Line
	2600 2900 2700 2800
Wire Wire Line
	2300 2900 2600 2900
Entry Wire Line
	2600 3000 2700 2900
Wire Wire Line
	2300 3000 2600 3000
Entry Wire Line
	2600 3100 2700 3000
Wire Wire Line
	2300 3100 2600 3100
Entry Wire Line
	2600 3200 2700 3100
Wire Wire Line
	2300 3200 2600 3200
Entry Wire Line
	2600 3300 2700 3200
Wire Wire Line
	2300 3300 2600 3300
Entry Wire Line
	2600 3400 2700 3300
Wire Wire Line
	2300 3400 2600 3400
Entry Wire Line
	2600 3500 2700 3400
Wire Wire Line
	2300 3500 2600 3500
Entry Wire Line
	2600 3600 2700 3500
Wire Wire Line
	2300 3600 2600 3600
Entry Wire Line
	2600 3700 2700 3600
Wire Wire Line
	2300 3700 2600 3700
Entry Wire Line
	2600 3800 2700 3700
Wire Wire Line
	2300 3800 2600 3800
Entry Wire Line
	2600 4000 2700 3900
Wire Wire Line
	2300 4000 2600 4000
Wire Bus Line
	7800 5200 7300 5200
Connection ~ 7300 5200
Wire Bus Line
	2700 5200 3400 5200
Connection ~ 2700 5200
Connection ~ 3400 5200
Entry Wire Line
	7800 1500 7900 1600
Wire Wire Line
	8300 1600 7900 1600
$Comp
L power:GND #PWR0105
U 1 1 6064B688
P 1800 2100
F 0 "#PWR0105" H 1800 1850 50  0001 C CNN
F 1 "GND" V 1800 1950 50  0000 R CNN
F 2 "" H 1800 2100 50  0001 C CNN
F 3 "" H 1800 2100 50  0001 C CNN
	1    1800 2100
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR0106
U 1 1 60668305
P 2300 2700
F 0 "#PWR0106" H 2300 2450 50  0001 C CNN
F 1 "GND" V 2300 2550 50  0000 R CNN
F 2 "" H 2300 2700 50  0001 C CNN
F 3 "" H 2300 2700 50  0001 C CNN
	1    2300 2700
	0    -1   -1   0   
$EndComp
$Comp
L power:VDD #PWR0109
U 1 1 6068F29C
P 2300 3900
F 0 "#PWR0109" H 2300 3750 50  0001 C CNN
F 1 "VDD" V 2300 4010 50  0000 L CNN
F 2 "" H 2300 3900 50  0001 C CNN
F 3 "" H 2300 3900 50  0001 C CNN
	1    2300 3900
	0    1    1    0   
$EndComp
Wire Wire Line
	8300 2900 7900 2900
Wire Wire Line
	8300 3000 7900 3000
Wire Wire Line
	8300 5000 7900 5000
Wire Wire Line
	8300 5100 7900 5100
Entry Wire Line
	7800 2800 7900 2900
Entry Wire Line
	7800 2900 7900 3000
Entry Wire Line
	7800 4900 7900 5000
Entry Wire Line
	7800 5000 7900 5100
Text Label 2600 2100 2    50   ~ 0
~DET
Text Label 8300 1700 2    50   ~ 0
CE2
Text Label 8300 2900 2    50   ~ 0
S1
Text Label 8300 3000 2    50   ~ 0
S2
Text Label 8300 5000 2    50   ~ 0
S3
Text Label 8300 5100 2    50   ~ 0
BCHK
Text Label 2600 2200 2    50   ~ 0
~CE_IC
Text Label 2600 2300 2    50   ~ 0
D0
Text Label 2600 2400 2    50   ~ 0
D2
Text Label 2600 2500 2    50   ~ 0
D4
Text Label 2600 2600 2    50   ~ 0
D6
Text Label 2600 2800 2    50   ~ 0
S2
Text Label 2600 2900 2    50   ~ 0
A16
Text Label 2600 3000 2    50   ~ 0
A14
Text Label 2600 3100 2    50   ~ 0
A12
Text Label 2600 3200 2    50   ~ 0
A10
Text Label 2600 3300 2    50   ~ 0
A8
Text Label 2600 3400 2    50   ~ 0
A6
Text Label 2600 3500 2    50   ~ 0
A4
Text Label 2600 3600 2    50   ~ 0
A2
Text Label 2600 3700 2    50   ~ 0
A0
Text Label 2600 3800 2    50   ~ 0
S3
Text Label 1500 2200 0    50   ~ 0
~CE1
Text Label 1500 2300 0    50   ~ 0
~OE
Text Label 1500 2400 0    50   ~ 0
D1
Text Label 1500 2500 0    50   ~ 0
D3
Text Label 1500 2600 0    50   ~ 0
D5
Text Label 1500 2700 0    50   ~ 0
D7
Text Label 1500 2800 0    50   ~ 0
S1
Text Label 1500 2900 0    50   ~ 0
A17
Text Label 1500 3000 0    50   ~ 0
A15
Text Label 1500 3100 0    50   ~ 0
A13
Text Label 1500 3200 0    50   ~ 0
A11
Text Label 1500 3300 0    50   ~ 0
A9
Text Label 1500 3400 0    50   ~ 0
A7
Text Label 1500 3500 0    50   ~ 0
A5
Text Label 1500 3600 0    50   ~ 0
A3
Text Label 1500 3700 0    50   ~ 0
A1
Text Label 1500 4000 0    50   ~ 0
R~W
Text Label 2600 4000 2    50   ~ 0
~WE_IC
Wire Wire Line
	4590 5500 4400 5500
Entry Wire Line
	1400 3700 1500 3800
Wire Wire Line
	1800 3800 1500 3800
Text Label 1500 3800 0    50   ~ 0
R~W
Text Notes 1720 1240 0    50   ~ 0
2x20 Male 2.54mm
NoConn ~ 8300 1700
$Comp
L 0_LOCAL:R R2
U 1 1 6047A390
P 4740 5700
F 0 "R2" V 4650 5700 50  0000 C CNN
F 1 "47K" V 4740 5700 50  0000 C CNN
F 2 "0_LOCAL:R_0805" V 4670 5700 50  0001 C CNN
F 3 "~" H 4740 5700 50  0001 C CNN
	1    4740 5700
	0    1    1    0   
$EndComp
Entry Wire Line
	4300 5600 4400 5700
Text Label 4400 5700 0    50   ~ 0
~CE_IC
$Comp
L power:VDD #PWR0113
U 1 1 6047A4A4
P 4890 5700
F 0 "#PWR0113" H 4890 5550 50  0001 C CNN
F 1 "VDD" V 4890 5850 50  0000 L CNN
F 2 "" H 4890 5700 50  0001 C CNN
F 3 "" H 4890 5700 50  0001 C CNN
	1    4890 5700
	0    1    1    0   
$EndComp
Wire Wire Line
	4590 5700 4400 5700
Wire Bus Line
	3400 5200 4300 5200
Connection ~ 4300 5200
Wire Bus Line
	4300 5200 5200 5200
Entry Wire Line
	1400 3800 1500 3900
Wire Wire Line
	1800 3900 1500 3900
Text Label 1500 3900 0    50   ~ 0
BCHK
Wire Bus Line
	4300 5200 4300 5600
Wire Bus Line
	5200 2000 5200 5200
Wire Bus Line
	7300 2000 7300 5200
Wire Bus Line
	2700 2000 2700 5200
Wire Bus Line
	3400 2000 3400 5200
Wire Bus Line
	5500 2000 5500 5200
Wire Bus Line
	1400 2100 1400 5200
Wire Bus Line
	7800 1500 7800 5200
$EndSCHEMATC
