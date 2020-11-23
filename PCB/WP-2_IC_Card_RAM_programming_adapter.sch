EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr USLetter 11000 8500
encoding utf-8
Sheet 1 1
Title "TANDY WP-2 128K RAM IC Card Programming Adapter"
Date "2020-11-16"
Rev ""
Comp "Brian K. White - b.kenyon.w@gmail.com"
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L 0_LOCAL:Conn_01x38_Male J1
U 1 1 5F6EF0A3
P 3700 3900
F 0 "J1" H 3630 5960 50  0000 L CNN
F 1 "Conn_01x38_Male" H 3310 5860 50  0000 L CNN
F 2 "0_LOCAL:Pin_Header_Straight_1x38_Pitch1.27mm" H 3700 3900 50  0001 C CNN
F 3 "~" H 3700 3900 50  0001 C CNN
	1    3700 3900
	-1   0    0    -1  
$EndComp
Text Label 3500 2200 2    50   ~ 0
~DET
Text Label 3500 2400 2    50   ~ 0
~CE1
Text Label 3500 2500 2    50   ~ 0
~OE
Text Label 3500 2600 2    50   ~ 0
D0
Text Label 3500 2700 2    50   ~ 0
D1
Text Label 3500 2800 2    50   ~ 0
D2
Text Label 3500 2900 2    50   ~ 0
D3
Text Label 3500 3000 2    50   ~ 0
D4
Text Label 3500 3100 2    50   ~ 0
D5
Text Label 3500 3200 2    50   ~ 0
D6
Text Label 3500 3300 2    50   ~ 0
D7
NoConn ~ 3500 3500
NoConn ~ 3500 3600
Text Label 3500 3800 2    50   ~ 0
A16
Text Label 3500 3900 2    50   ~ 0
A15
Text Label 3500 4000 2    50   ~ 0
A14
Text Label 3500 4100 2    50   ~ 0
A13
Text Label 3500 4200 2    50   ~ 0
A12
Text Label 3500 4300 2    50   ~ 0
A11
Text Label 3500 4400 2    50   ~ 0
A10
Text Label 3500 4500 2    50   ~ 0
A9
Text Label 3500 4600 2    50   ~ 0
A8
Text Label 3500 4700 2    50   ~ 0
A7
Text Label 3500 4800 2    50   ~ 0
A6
Text Label 3500 4900 2    50   ~ 0
A5
Text Label 3500 5000 2    50   ~ 0
A4
Text Label 3500 5100 2    50   ~ 0
A3
Text Label 3500 5200 2    50   ~ 0
A2
Text Label 3500 5300 2    50   ~ 0
A1
Text Label 3500 5400 2    50   ~ 0
A0
NoConn ~ 3500 5600
Text Label 3500 5700 2    50   ~ 0
BCHK
Wire Wire Line
	3100 2400 3500 2400
Entry Wire Line
	3000 2400 3100 2500
Wire Wire Line
	3100 2500 3500 2500
Entry Wire Line
	3000 2500 3100 2600
Wire Wire Line
	3100 2600 3500 2600
Entry Wire Line
	3000 2600 3100 2700
Wire Wire Line
	3100 2700 3500 2700
Entry Wire Line
	3000 2700 3100 2800
Wire Wire Line
	3100 2800 3500 2800
Entry Wire Line
	3000 2800 3100 2900
Wire Wire Line
	3100 2900 3500 2900
Entry Wire Line
	3000 2900 3100 3000
Wire Wire Line
	3100 3000 3500 3000
Entry Wire Line
	3000 3000 3100 3100
Wire Wire Line
	3100 3100 3500 3100
Entry Wire Line
	3000 3100 3100 3200
Wire Wire Line
	3100 3200 3500 3200
Entry Wire Line
	3000 3200 3100 3300
Wire Wire Line
	3100 3300 3500 3300
Entry Wire Line
	3000 4600 3100 4700
Wire Wire Line
	3100 4700 3500 4700
Entry Wire Line
	3000 4700 3100 4800
Wire Wire Line
	3100 4800 3500 4800
Entry Wire Line
	3000 4800 3100 4900
Wire Wire Line
	3100 4900 3500 4900
Entry Wire Line
	3000 4900 3100 5000
Wire Wire Line
	3100 5000 3500 5000
Entry Wire Line
	3000 5000 3100 5100
Wire Wire Line
	3100 5100 3500 5100
Entry Wire Line
	3000 5100 3100 5200
Wire Wire Line
	3100 5200 3500 5200
Entry Wire Line
	3000 5200 3100 5300
Wire Wire Line
	3100 5300 3500 5300
Entry Wire Line
	3000 5300 3100 5400
Wire Wire Line
	3100 5400 3500 5400
Entry Wire Line
	3000 3800 3100 3900
Wire Wire Line
	3100 3900 3500 3900
Entry Wire Line
	3000 3900 3100 4000
Wire Wire Line
	3100 4000 3500 4000
Entry Wire Line
	3000 4000 3100 4100
Wire Wire Line
	3100 4100 3500 4100
Entry Wire Line
	3000 4100 3100 4200
Wire Wire Line
	3100 4200 3500 4200
Entry Wire Line
	3000 4200 3100 4300
Wire Wire Line
	3100 4300 3500 4300
Entry Wire Line
	3000 4300 3100 4400
Wire Wire Line
	3100 4400 3500 4400
Entry Wire Line
	3000 4400 3100 4500
Wire Wire Line
	3100 4500 3500 4500
Entry Wire Line
	3000 4500 3100 4600
Wire Wire Line
	3100 4600 3500 4600
Entry Wire Line
	3000 3700 3100 3800
Wire Wire Line
	3100 3800 3500 3800
Text Notes 3740 2240 0    50   ~ 0
Card Detect
Text Notes 3730 5740 0    50   ~ 0
Battery Check
Text Notes 3730 5830 0    50   ~ 0
+5v
Text Notes 3180 1780 0    50   ~ 0
1x38 Male 1.27mm\nTANDY WP-2 IC Card pinout
Entry Wire Line
	6000 3800 6100 3900
Entry Wire Line
	6000 3900 6100 4000
Entry Wire Line
	6000 4000 6100 4100
Entry Wire Line
	6000 4100 6100 4200
Entry Wire Line
	6000 4200 6100 4300
Entry Wire Line
	6000 4300 6100 4400
Entry Wire Line
	6000 3600 6100 3700
Entry Wire Line
	6000 3000 6100 3100
Entry Wire Line
	6000 3100 6100 3200
Entry Wire Line
	6000 3200 6100 3300
Entry Wire Line
	6000 3300 6100 3400
Entry Wire Line
	6000 3400 6100 3500
Entry Wire Line
	6000 3500 6100 3600
Entry Wire Line
	6000 3700 6100 3800
Entry Wire Line
	7000 3700 7100 3600
Wire Wire Line
	6810 3700 7000 3700
Entry Wire Line
	7000 3100 7100 3000
Wire Wire Line
	6810 3100 7000 3100
Entry Wire Line
	7000 3300 7100 3200
Wire Wire Line
	6810 3300 7000 3300
Entry Wire Line
	7000 3400 7100 3300
Wire Wire Line
	6810 3400 7000 3400
Entry Wire Line
	7000 3500 7100 3400
Wire Wire Line
	6810 3500 7000 3500
Entry Wire Line
	7000 3600 7100 3500
Wire Wire Line
	6810 3600 7000 3600
Text Label 6810 3800 0    50   ~ 0
~OE
Text Label 6810 4000 0    50   ~ 0
~CE1
Text Label 6310 3100 2    50   ~ 0
A16
Text Label 6310 3200 2    50   ~ 0
A14
Text Label 6810 3300 0    50   ~ 0
R~W
Text Label 6810 3400 0    50   ~ 0
A13
Text Label 6310 3300 2    50   ~ 0
A12
Text Label 6810 3700 0    50   ~ 0
A11
Text Label 6810 3900 0    50   ~ 0
A10
Text Label 6810 3600 0    50   ~ 0
A9
Text Label 6810 3500 0    50   ~ 0
A8
Text Label 6310 3400 2    50   ~ 0
A7
Text Label 6310 3500 2    50   ~ 0
A6
Text Label 6310 3600 2    50   ~ 0
A5
Text Label 6310 3700 2    50   ~ 0
A4
Text Label 6310 3900 2    50   ~ 0
A2
Text Label 6310 4000 2    50   ~ 0
A1
Text Label 6310 4100 2    50   ~ 0
A0
Text Label 6310 4200 2    50   ~ 0
D0
Text Label 6310 4300 2    50   ~ 0
D1
Text Label 6310 4400 2    50   ~ 0
D2
Text Label 6810 4500 0    50   ~ 0
D3
Text Label 6810 4400 0    50   ~ 0
D4
Text Label 6810 4300 0    50   ~ 0
D5
Text Label 6810 4200 0    50   ~ 0
D6
Text Label 6810 4100 0    50   ~ 0
D7
Wire Wire Line
	6100 4400 6310 4400
Wire Wire Line
	6100 4300 6310 4300
Wire Wire Line
	6100 4200 6310 4200
Wire Wire Line
	6100 4100 6310 4100
Wire Wire Line
	6100 4000 6310 4000
Wire Wire Line
	6100 3900 6310 3900
Wire Wire Line
	6100 3800 6310 3800
Wire Wire Line
	6100 3600 6310 3600
Wire Wire Line
	6100 3500 6310 3500
Wire Wire Line
	6100 3400 6310 3400
Wire Wire Line
	6100 3300 6310 3300
Wire Wire Line
	6100 3200 6310 3200
Wire Wire Line
	6100 3100 6310 3100
$Comp
L power:GND #PWR0108
U 1 1 5FA08971
P 3500 3400
F 0 "#PWR0108" H 3500 3150 50  0001 C CNN
F 1 "GND" V 3500 3250 50  0000 R CNN
F 2 "" H 3500 3400 50  0001 C CNN
F 3 "" H 3500 3400 50  0001 C CNN
	1    3500 3400
	0    1    1    0   
$EndComp
Entry Wire Line
	3000 3600 3100 3700
Wire Wire Line
	3100 3700 3500 3700
Text Label 3500 3700 2    50   ~ 0
A17
Text Notes 3740 2140 0    50   ~ 0
GND
Text Notes 3740 3440 0    50   ~ 0
GND
Text Label 6810 3100 0    50   ~ 0
A15
Text Label 3500 5500 2    50   ~ 0
R~W
Entry Wire Line
	3000 5400 3100 5500
Wire Wire Line
	3100 5500 3500 5500
$Comp
L 0_LOCAL:Conn_02x16_Counter_Clockwise J2
U 1 1 5F97A8B8
P 6510 3700
F 0 "J2" H 6580 4650 50  0000 C CNN
F 1 "Conn_02x16_Counter_Clockwise" H 6580 4550 50  0000 C CNN
F 2 "0_LOCAL:2x16x600" H 6510 3700 50  0001 C CNN
F 3 "~" H 6510 3700 50  0001 C CNN
	1    6510 3700
	1    0    0    -1  
$EndComp
Text Label 6810 3000 0    50   ~ 0
VDD
Entry Wire Line
	7000 3800 7100 3700
Wire Wire Line
	6810 3800 7000 3800
Entry Wire Line
	7000 3900 7100 3800
Wire Wire Line
	6810 3900 7000 3900
Entry Wire Line
	7000 4000 7100 3900
Wire Wire Line
	6810 4000 7000 4000
Entry Wire Line
	7000 4100 7100 4000
Wire Wire Line
	6810 4100 7000 4100
Entry Wire Line
	7000 4200 7100 4100
Wire Wire Line
	6810 4200 7000 4200
Entry Wire Line
	7000 4300 7100 4200
Wire Wire Line
	6810 4300 7000 4300
Entry Wire Line
	7000 4400 7100 4300
Wire Wire Line
	6810 4400 7000 4400
Entry Wire Line
	7000 4500 7100 4400
Wire Wire Line
	6810 4500 7000 4500
Wire Wire Line
	6100 3700 6310 3700
Wire Wire Line
	3500 5800 3100 5800
Entry Wire Line
	3000 5700 3100 5800
Text Label 3500 5800 2    50   ~ 0
VDD
$Comp
L power:GND #PWR0101
U 1 1 5FAB7ED9
P 6310 4500
F 0 "#PWR0101" H 6310 4250 50  0001 C CNN
F 1 "GND" V 6310 4370 50  0000 R CNN
F 2 "" H 6310 4500 50  0001 C CNN
F 3 "" H 6310 4500 50  0001 C CNN
	1    6310 4500
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR0102
U 1 1 5FAC2431
P 3500 2100
F 0 "#PWR0102" H 3500 1850 50  0001 C CNN
F 1 "GND" V 3500 1950 50  0000 R CNN
F 2 "" H 3500 2100 50  0001 C CNN
F 3 "" H 3500 2100 50  0001 C CNN
	1    3500 2100
	0    1    1    0   
$EndComp
Text Notes 3740 2340 0    50   ~ 0
CE2
NoConn ~ 6310 3000
Entry Wire Line
	7000 3000 7100 2900
Wire Wire Line
	6810 3000 7000 3000
Text Label 6310 3800 2    50   ~ 0
A3
Text Notes 5630 2360 0    50   ~ 0
DIL pin headers for programmer ZIF socket\n628128 pinout - generic SRAM 128Kx8 5v parallel
NoConn ~ 3500 2200
NoConn ~ 3500 5700
Entry Wire Line
	3000 2300 3100 2400
NoConn ~ 3500 2300
NoConn ~ 6810 3200
Text Notes 6810 3200 0    50   ~ 0
CE2
Text Notes 3320 6390 0    50   ~ 0
For TL-866: Specify device "628128" (Standard/Generic SRAM 128Kx8 5v parallel)
Wire Bus Line
	6000 6000 3000 6000
Wire Bus Line
	7100 6000 6000 6000
Wire Bus Line
	6000 2900 6000 6000
Wire Bus Line
	7100 2900 7100 6000
Wire Bus Line
	3000 2000 3000 6000
Connection ~ 6000 6000
$EndSCHEMATC
