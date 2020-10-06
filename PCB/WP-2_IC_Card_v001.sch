EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr USLetter 11000 8500
encoding utf-8
Sheet 1 1
Title "TANDY WP-2 128K RAM IC Card"
Date "2020-09-26"
Rev ""
Comp "Brian K. White - b.kenyon.w@gmail.com"
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L 0_LOCAL:Conn_01x38_Female J1
U 1 1 5F6EF0A3
P 8430 3700
F 0 "J1" H 7930 5670 50  0000 L CNN
F 1 "Conn_01x38_Female" H 8080 5670 50  0000 L CNN
F 2 "0_LOCAL:Socket_Edge_1x38_1.27m" H 8430 3700 50  0001 C CNN
F 3 "~" H 8430 3700 50  0001 C CNN
	1    8430 3700
	1    0    0    -1  
$EndComp
Text Label 8230 1900 2    50   ~ 0
GND
Text Label 8230 2000 2    50   ~ 0
~DET
Text Label 8230 2100 2    50   ~ 0
CE2
Text Label 8230 2200 2    50   ~ 0
~CE1
Text Label 8230 2300 2    50   ~ 0
~OE
Text Label 8230 2400 2    50   ~ 0
D0
Text Label 8230 2500 2    50   ~ 0
D1
Text Label 8230 2600 2    50   ~ 0
D2
Text Label 8230 2700 2    50   ~ 0
D3
Text Label 8230 2800 2    50   ~ 0
D4
Text Label 8230 2900 2    50   ~ 0
D5
Text Label 8230 3000 2    50   ~ 0
D6
Text Label 8230 3100 2    50   ~ 0
D7
NoConn ~ 8230 3300
NoConn ~ 8230 3400
Text Label 8230 3600 2    50   ~ 0
A16
Text Label 8230 3700 2    50   ~ 0
A15
Text Label 8230 3800 2    50   ~ 0
A14
Text Label 8230 3900 2    50   ~ 0
A13
Text Label 8230 4000 2    50   ~ 0
A12
Text Label 8230 4100 2    50   ~ 0
A11
Text Label 8230 4200 2    50   ~ 0
A10
Text Label 8230 4300 2    50   ~ 0
A9
Text Label 8230 4400 2    50   ~ 0
A8
Text Label 8230 4500 2    50   ~ 0
A7
Text Label 8230 4600 2    50   ~ 0
A6
Text Label 8230 4700 2    50   ~ 0
A5
Text Label 8230 4800 2    50   ~ 0
A4
Text Label 8230 4900 2    50   ~ 0
A3
Text Label 8230 5000 2    50   ~ 0
A2
Text Label 8230 5100 2    50   ~ 0
A1
Text Label 8230 5200 2    50   ~ 0
A0
Text Label 8230 5300 2    50   ~ 0
R~W
NoConn ~ 8230 5400
Text Label 8230 5500 2    50   ~ 0
BCHK
Text Label 8230 5600 2    50   ~ 0
VDD
$Comp
L 0_LOCAL:62-65C1024_TSOP-I-32 U1
U 1 1 5F718069
P 2910 3200
F 0 "U1" H 2910 3200 50  0000 C CNN
F 1 "SRAM 128Kx8 5v Parallel" H 3480 4520 50  0000 C CNN
F 2 "0_LOCAL:TSOP32-20mm" H 2410 4350 50  0001 C CNN
F 3 "http://www.issi.com/WW/pdf/61-64C5128AL.pdf" H 2910 3200 50  0001 C CNN
	1    2910 3200
	1    0    0    -1  
$EndComp
Text Label 2910 4500 3    50   ~ 0
GND
Entry Wire Line
	7730 2000 7830 2100
Wire Wire Line
	7830 2100 8230 2100
Entry Wire Line
	7730 2100 7830 2200
Wire Wire Line
	7830 2200 8230 2200
Entry Wire Line
	7730 2200 7830 2300
Wire Wire Line
	7830 2300 8230 2300
Entry Wire Line
	7730 2300 7830 2400
Wire Wire Line
	7830 2400 8230 2400
Entry Wire Line
	7730 2400 7830 2500
Wire Wire Line
	7830 2500 8230 2500
Entry Wire Line
	7730 2500 7830 2600
Wire Wire Line
	7830 2600 8230 2600
Entry Wire Line
	7730 2600 7830 2700
Wire Wire Line
	7830 2700 8230 2700
Entry Wire Line
	7730 2700 7830 2800
Wire Wire Line
	7830 2800 8230 2800
Entry Wire Line
	7730 2800 7830 2900
Wire Wire Line
	7830 2900 8230 2900
Entry Wire Line
	7730 2900 7830 3000
Wire Wire Line
	7830 3000 8230 3000
Entry Wire Line
	7730 3000 7830 3100
Wire Wire Line
	7830 3100 8230 3100
Entry Wire Line
	7730 4400 7830 4500
Wire Wire Line
	7830 4500 8230 4500
Entry Wire Line
	7730 4500 7830 4600
Wire Wire Line
	7830 4600 8230 4600
Entry Wire Line
	7730 4600 7830 4700
Wire Wire Line
	7830 4700 8230 4700
Entry Wire Line
	7730 4700 7830 4800
Wire Wire Line
	7830 4800 8230 4800
Entry Wire Line
	7730 4800 7830 4900
Wire Wire Line
	7830 4900 8230 4900
Entry Wire Line
	7730 4900 7830 5000
Wire Wire Line
	7830 5000 8230 5000
Entry Wire Line
	7730 5000 7830 5100
Wire Wire Line
	7830 5100 8230 5100
Entry Wire Line
	7730 5100 7830 5200
Wire Wire Line
	7830 5200 8230 5200
Entry Wire Line
	7730 3600 7830 3700
Wire Wire Line
	7830 3700 8230 3700
Entry Wire Line
	7730 3700 7830 3800
Wire Wire Line
	7830 3800 8230 3800
Entry Wire Line
	7730 3800 7830 3900
Wire Wire Line
	7830 3900 8230 3900
Entry Wire Line
	7730 3900 7830 4000
Wire Wire Line
	7830 4000 8230 4000
Entry Wire Line
	7730 4000 7830 4100
Wire Wire Line
	7830 4100 8230 4100
Entry Wire Line
	7730 4100 7830 4200
Wire Wire Line
	7830 4200 8230 4200
Entry Wire Line
	7730 4200 7830 4300
Wire Wire Line
	7830 4300 8230 4300
Entry Wire Line
	7730 4300 7830 4400
Wire Wire Line
	7830 4400 8230 4400
Entry Wire Line
	7730 3500 7830 3600
Wire Wire Line
	7830 3600 8230 3600
$Comp
L power:GND #PWR0102
U 1 1 5F75F688
P 8230 1900
F 0 "#PWR0102" H 8230 1650 50  0001 C CNN
F 1 "GND" V 8230 1750 50  0000 R CNN
F 2 "" H 8230 1900 50  0001 C CNN
F 3 "" H 8230 1900 50  0001 C CNN
	1    8230 1900
	0    1    1    0   
$EndComp
$Comp
L power:VDD #PWR0103
U 1 1 5F7647D4
P 8230 5600
F 0 "#PWR0103" H 8230 5450 50  0001 C CNN
F 1 "VDD" V 8280 5750 50  0000 L CNN
F 2 "" H 8230 5600 50  0001 C CNN
F 3 "" H 8230 5600 50  0001 C CNN
	1    8230 5600
	0    -1   -1   0   
$EndComp
$Comp
L power:VDD #PWR0104
U 1 1 5F768D54
P 2910 1900
F 0 "#PWR0104" H 2910 1750 50  0001 C CNN
F 1 "VDD" H 2950 2090 50  0000 C CNN
F 2 "" H 2910 1900 50  0001 C CNN
F 3 "" H 2910 1900 50  0001 C CNN
	1    2910 1900
	1    0    0    -1  
$EndComp
Entry Wire Line
	2000 2900 2100 3000
Entry Wire Line
	2000 3000 2100 3100
Entry Wire Line
	2000 3100 2100 3200
Entry Wire Line
	2000 3200 2100 3300
Entry Wire Line
	2000 3300 2100 3400
Entry Wire Line
	2000 3400 2100 3500
Entry Wire Line
	2000 3500 2100 3600
Entry Wire Line
	2000 3600 2100 3700
Entry Wire Line
	2000 2100 2100 2200
Entry Wire Line
	2000 2200 2100 2300
Entry Wire Line
	2000 2300 2100 2400
Entry Wire Line
	2000 2400 2100 2500
Entry Wire Line
	2000 2500 2100 2600
Entry Wire Line
	2000 2600 2100 2700
Entry Wire Line
	2000 2700 2100 2800
Entry Wire Line
	2000 2800 2100 2900
Entry Wire Line
	2000 2000 2100 2100
Entry Wire Line
	2000 3900 2100 4000
Entry Wire Line
	2000 4000 2100 4100
Entry Wire Line
	2000 4100 2100 4200
Entry Wire Line
	2000 4200 2100 4300
Entry Wire Line
	3700 2100 3800 2000
Wire Wire Line
	3510 2100 3700 2100
Entry Wire Line
	3700 2200 3800 2100
Wire Wire Line
	3510 2200 3700 2200
Entry Wire Line
	3700 2300 3800 2200
Wire Wire Line
	3510 2300 3700 2300
Entry Wire Line
	3700 2400 3800 2300
Wire Wire Line
	3510 2400 3700 2400
Entry Wire Line
	3700 2500 3800 2400
Wire Wire Line
	3510 2500 3700 2500
Entry Wire Line
	3700 2600 3800 2500
Wire Wire Line
	3510 2600 3700 2600
Entry Wire Line
	3700 2700 3800 2600
Wire Wire Line
	3510 2700 3700 2700
Entry Wire Line
	3700 2800 3800 2700
Wire Wire Line
	3510 2800 3700 2800
$Comp
L power:GND #PWR0105
U 1 1 5F7A1390
P 8030 2000
F 0 "#PWR0105" H 8030 1750 50  0001 C CNN
F 1 "GND" V 8030 1850 50  0000 R CNN
F 2 "" H 8030 2000 50  0001 C CNN
F 3 "" H 8030 2000 50  0001 C CNN
	1    8030 2000
	0    1    1    0   
$EndComp
Entry Wire Line
	7730 5200 7830 5300
Wire Wire Line
	7830 5300 8230 5300
Text Label 2310 4300 2    50   ~ 0
R~W
Text Label 2310 4200 2    50   ~ 0
~OE
Text Label 2310 4100 2    50   ~ 0
~CE1
Text Label 2310 4000 2    50   ~ 0
CE2
Text Label 2310 3700 2    50   ~ 0
A16
Text Label 2310 3600 2    50   ~ 0
A15
Text Label 2310 3500 2    50   ~ 0
A14
Text Label 2310 3400 2    50   ~ 0
A13
Text Label 2310 3300 2    50   ~ 0
A12
Text Label 2310 3200 2    50   ~ 0
A11
Text Label 2310 3100 2    50   ~ 0
A10
Text Label 2310 3000 2    50   ~ 0
A9
Text Label 2310 2900 2    50   ~ 0
A8
Text Label 2310 2800 2    50   ~ 0
A7
Text Label 2310 2700 2    50   ~ 0
A6
Text Label 2310 2600 2    50   ~ 0
A5
Text Label 2310 2500 2    50   ~ 0
A4
Text Label 2310 2400 2    50   ~ 0
A3
Text Label 2310 2300 2    50   ~ 0
A2
Text Label 2310 2200 2    50   ~ 0
A1
Text Label 2310 2100 2    50   ~ 0
A0
Text Label 3510 2100 0    50   ~ 0
D0
Text Label 3510 2200 0    50   ~ 0
D1
Text Label 3510 2300 0    50   ~ 0
D2
Text Label 3510 2400 0    50   ~ 0
D3
Text Label 3510 2500 0    50   ~ 0
D4
Text Label 3510 2600 0    50   ~ 0
D5
Text Label 3510 2700 0    50   ~ 0
D6
Text Label 3510 2800 0    50   ~ 0
D7
$Comp
L power:GND #PWR0106
U 1 1 5F7B4456
P 2910 4500
F 0 "#PWR0106" H 2910 4250 50  0001 C CNN
F 1 "GND" H 2950 4290 50  0000 C CNN
F 2 "" H 2910 4500 50  0001 C CNN
F 3 "" H 2910 4500 50  0001 C CNN
	1    2910 4500
	1    0    0    -1  
$EndComp
Text Notes 8470 2040 0    50   ~ 0
Card Detect
Text Notes 8460 5540 0    50   ~ 0
Battery Check
Text Notes 8460 5630 0    50   ~ 0
+5v
Wire Wire Line
	2100 4300 2310 4300
Wire Wire Line
	2100 4200 2310 4200
Wire Wire Line
	2100 4100 2310 4100
Wire Wire Line
	2100 4000 2310 4000
Wire Wire Line
	2100 3700 2310 3700
Wire Wire Line
	2100 3600 2310 3600
Wire Wire Line
	2100 3500 2310 3500
Wire Wire Line
	2100 3400 2310 3400
Wire Wire Line
	2100 3300 2310 3300
Wire Wire Line
	2100 3200 2310 3200
Wire Wire Line
	2100 3100 2310 3100
Wire Wire Line
	2100 3000 2310 3000
Wire Wire Line
	2100 2900 2310 2900
Wire Wire Line
	2100 2800 2310 2800
Wire Wire Line
	2100 2700 2310 2700
Wire Wire Line
	2100 2600 2310 2600
Wire Wire Line
	2100 2500 2310 2500
Wire Wire Line
	2100 2400 2310 2400
Wire Wire Line
	2100 2300 2310 2300
Wire Wire Line
	2100 2200 2310 2200
Wire Wire Line
	2100 2100 2310 2100
Wire Bus Line
	2000 6010 3800 6010
Text Notes 2420 1620 0    50   ~ 0
TSOP-32 8x20 footprint
Text Notes 7610 1600 0    50   ~ 0
1x38 1.27mm pitch female
$Comp
L 0_LOCAL:Net-Tie_2 NT1
U 1 1 5F8923B3
P 8130 2000
F 0 "NT1" H 8050 2040 50  0001 C CNN
F 1 "Net-Tie_2" H 8140 1990 50  0001 C CNN
F 2 "0_LOCAL:Net_Tie_2p_8mil" H 8130 2000 50  0001 C CNN
F 3 "~" H 8130 2000 50  0001 C CNN
	1    8130 2000
	1    0    0    -1  
$EndComp
$Comp
L 0_LOCAL:62-65C1024_TSOP-I-32 U2
U 1 1 5F906116
P 5010 3200
F 0 "U2" H 5010 3200 50  0000 C CNN
F 1 "SRAM 128Kx8 5v Parallel" H 5590 4520 50  0000 C CNN
F 2 "0_LOCAL:TSOP32-14mm" H 4510 4350 50  0001 C CNN
F 3 "http://www.issi.com/WW/pdf/61-64C5128AL.pdf" H 5010 3200 50  0001 C CNN
	1    5010 3200
	1    0    0    -1  
$EndComp
Text Label 5010 4500 3    50   ~ 0
GND
$Comp
L power:VDD #PWR0101
U 1 1 5F906121
P 5010 1900
F 0 "#PWR0101" H 5010 1750 50  0001 C CNN
F 1 "VDD" H 5050 2090 50  0000 C CNN
F 2 "" H 5010 1900 50  0001 C CNN
F 3 "" H 5010 1900 50  0001 C CNN
	1    5010 1900
	1    0    0    -1  
$EndComp
Entry Wire Line
	4100 2900 4200 3000
Entry Wire Line
	4100 3000 4200 3100
Entry Wire Line
	4100 3100 4200 3200
Entry Wire Line
	4100 3200 4200 3300
Entry Wire Line
	4100 3300 4200 3400
Entry Wire Line
	4100 3400 4200 3500
Entry Wire Line
	4100 3500 4200 3600
Entry Wire Line
	4100 3600 4200 3700
Entry Wire Line
	4100 2100 4200 2200
Entry Wire Line
	4100 2200 4200 2300
Entry Wire Line
	4100 2300 4200 2400
Entry Wire Line
	4100 2400 4200 2500
Entry Wire Line
	4100 2500 4200 2600
Entry Wire Line
	4100 2600 4200 2700
Entry Wire Line
	4100 2700 4200 2800
Entry Wire Line
	4100 2800 4200 2900
Entry Wire Line
	4100 2000 4200 2100
Entry Wire Line
	4100 3900 4200 4000
Entry Wire Line
	4100 4000 4200 4100
Entry Wire Line
	4100 4100 4200 4200
Entry Wire Line
	4100 4200 4200 4300
Entry Wire Line
	5800 2100 5900 2000
Wire Wire Line
	5610 2100 5800 2100
Entry Wire Line
	5800 2200 5900 2100
Wire Wire Line
	5610 2200 5800 2200
Entry Wire Line
	5800 2300 5900 2200
Wire Wire Line
	5610 2300 5800 2300
Entry Wire Line
	5800 2400 5900 2300
Wire Wire Line
	5610 2400 5800 2400
Entry Wire Line
	5800 2500 5900 2400
Wire Wire Line
	5610 2500 5800 2500
Entry Wire Line
	5800 2600 5900 2500
Wire Wire Line
	5610 2600 5800 2600
Entry Wire Line
	5800 2700 5900 2600
Wire Wire Line
	5610 2700 5800 2700
Entry Wire Line
	5800 2800 5900 2700
Wire Wire Line
	5610 2800 5800 2800
Text Label 4410 4300 2    50   ~ 0
R~W
Text Label 4410 4200 2    50   ~ 0
~OE
Text Label 4410 4100 2    50   ~ 0
~CE1
Text Label 4410 4000 2    50   ~ 0
CE2
Text Label 4410 3700 2    50   ~ 0
A16
Text Label 4410 3600 2    50   ~ 0
A15
Text Label 4410 3500 2    50   ~ 0
A14
Text Label 4410 3400 2    50   ~ 0
A13
Text Label 4410 3300 2    50   ~ 0
A12
Text Label 4410 3200 2    50   ~ 0
A11
Text Label 4410 3100 2    50   ~ 0
A10
Text Label 4410 3000 2    50   ~ 0
A9
Text Label 4410 2900 2    50   ~ 0
A8
Text Label 4410 2800 2    50   ~ 0
A7
Text Label 4410 2700 2    50   ~ 0
A6
Text Label 4410 2600 2    50   ~ 0
A5
Text Label 4410 2500 2    50   ~ 0
A4
Text Label 4410 2400 2    50   ~ 0
A3
Text Label 4410 2300 2    50   ~ 0
A2
Text Label 4410 2200 2    50   ~ 0
A1
Text Label 4410 2100 2    50   ~ 0
A0
Text Label 5610 2100 0    50   ~ 0
D0
Text Label 5610 2200 0    50   ~ 0
D1
Text Label 5610 2300 0    50   ~ 0
D2
Text Label 5610 2400 0    50   ~ 0
D3
Text Label 5610 2500 0    50   ~ 0
D4
Text Label 5610 2600 0    50   ~ 0
D5
Text Label 5610 2700 0    50   ~ 0
D6
Text Label 5610 2800 0    50   ~ 0
D7
$Comp
L power:GND #PWR0107
U 1 1 5F90616D
P 5010 4500
F 0 "#PWR0107" H 5010 4250 50  0001 C CNN
F 1 "GND" H 5050 4290 50  0000 C CNN
F 2 "" H 5010 4500 50  0001 C CNN
F 3 "" H 5010 4500 50  0001 C CNN
	1    5010 4500
	1    0    0    -1  
$EndComp
Wire Wire Line
	4200 4300 4410 4300
Wire Wire Line
	4200 4200 4410 4200
Wire Wire Line
	4200 4100 4410 4100
Wire Wire Line
	4200 4000 4410 4000
Wire Wire Line
	4200 3700 4410 3700
Wire Wire Line
	4200 3600 4410 3600
Wire Wire Line
	4200 3500 4410 3500
Wire Wire Line
	4200 3400 4410 3400
Wire Wire Line
	4200 3300 4410 3300
Wire Wire Line
	4200 3200 4410 3200
Wire Wire Line
	4200 3100 4410 3100
Wire Wire Line
	4200 3000 4410 3000
Wire Wire Line
	4200 2900 4410 2900
Wire Wire Line
	4200 2800 4410 2800
Wire Wire Line
	4200 2700 4410 2700
Wire Wire Line
	4200 2600 4410 2600
Wire Wire Line
	4200 2500 4410 2500
Wire Wire Line
	4200 2400 4410 2400
Wire Wire Line
	4200 2300 4410 2300
Wire Wire Line
	4200 2200 4410 2200
Wire Wire Line
	4200 2100 4410 2100
Wire Bus Line
	4100 6010 5900 6010
Text Notes 4520 1620 0    50   ~ 0
sTSOP-32 8x14 footprint
Wire Bus Line
	7730 6010 5900 6010
Connection ~ 5900 6010
Wire Bus Line
	4100 6010 3800 6010
Connection ~ 4100 6010
Connection ~ 3800 6010
Text Notes 2000 6280 0    50   ~ 0
Example compatible SRAM parts: TC551001 IS61C1024 IS62C1024 CY62128 CY7C109D AS6C1008 AS7C1024B R1LP0108E
Text Notes 2000 6800 0    50   ~ 0
The Small-TSOP (8x14) version of some parts (ex: CY62128ELL-55ZAXI)\nuse a pin numbering that doesn't match the sTSOP symbol above,\nbut all parts still have the same signals at the same physical pin locations.\n\nThe PCB is compatible with these parts, just disregard the pin numbers used in the datasheet.
Text Notes 8630 3540 2    50   ~ 0
A17
$Comp
L power:GND #PWR0108
U 1 1 5FA08971
P 8230 3200
F 0 "#PWR0108" H 8230 2950 50  0001 C CNN
F 1 "GND" V 8230 3050 50  0000 R CNN
F 2 "" H 8230 3200 50  0001 C CNN
F 3 "" H 8230 3200 50  0001 C CNN
	1    8230 3200
	0    1    1    0   
$EndComp
Text Label 8230 3200 2    50   ~ 0
GND
Wire Bus Line
	3800 2000 3800 6010
Wire Bus Line
	5900 2000 5900 6010
Wire Bus Line
	2000 2000 2000 6010
Wire Bus Line
	4100 2000 4100 6010
Wire Bus Line
	7730 2000 7730 6010
$EndSCHEMATC
