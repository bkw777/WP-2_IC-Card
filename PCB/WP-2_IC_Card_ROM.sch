EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr USLetter 11000 8500
encoding utf-8
Sheet 1 1
Title "TANDY WP-2 256K ROM IC Card"
Date "2020-11-16"
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
P 7730 3240
F 0 "J1" H 7230 5210 50  0000 L CNN
F 1 "Conn_01x38_Female" H 7380 5210 50  0000 L CNN
F 2 "0_LOCAL:PinSocket_1x38x1.27_edge_s" H 7730 3240 50  0001 C CNN
F 3 "~" H 7730 3240 50  0001 C CNN
	1    7730 3240
	1    0    0    -1  
$EndComp
Text Label 7530 1540 2    50   ~ 0
~DET
Text Label 7530 1740 2    50   ~ 0
~CE1
Text Label 7530 1840 2    50   ~ 0
~OE
Text Label 7530 1940 2    50   ~ 0
D0
Text Label 7530 2040 2    50   ~ 0
D1
Text Label 7530 2140 2    50   ~ 0
D2
Text Label 7530 2240 2    50   ~ 0
D3
Text Label 7530 2340 2    50   ~ 0
D4
Text Label 7530 2440 2    50   ~ 0
D5
Text Label 7530 2540 2    50   ~ 0
D6
Text Label 7530 2640 2    50   ~ 0
D7
NoConn ~ 7530 2840
NoConn ~ 7530 2940
Text Label 7530 3140 2    50   ~ 0
A16
Text Label 7530 3240 2    50   ~ 0
A15
Text Label 7530 3340 2    50   ~ 0
A14
Text Label 7530 3440 2    50   ~ 0
A13
Text Label 7530 3540 2    50   ~ 0
A12
Text Label 7530 3640 2    50   ~ 0
A11
Text Label 7530 3740 2    50   ~ 0
A10
Text Label 7530 3840 2    50   ~ 0
A9
Text Label 7530 3940 2    50   ~ 0
A8
Text Label 7530 4040 2    50   ~ 0
A7
Text Label 7530 4140 2    50   ~ 0
A6
Text Label 7530 4240 2    50   ~ 0
A5
Text Label 7530 4340 2    50   ~ 0
A4
Text Label 7530 4440 2    50   ~ 0
A3
Text Label 7530 4540 2    50   ~ 0
A2
Text Label 7530 4640 2    50   ~ 0
A1
Text Label 7530 4740 2    50   ~ 0
A0
NoConn ~ 7530 4940
Entry Wire Line
	7030 1640 7130 1740
Wire Wire Line
	7130 1740 7530 1740
Entry Wire Line
	7030 1740 7130 1840
Wire Wire Line
	7130 1840 7530 1840
Entry Wire Line
	7030 1840 7130 1940
Wire Wire Line
	7130 1940 7530 1940
Entry Wire Line
	7030 1940 7130 2040
Wire Wire Line
	7130 2040 7530 2040
Entry Wire Line
	7030 2040 7130 2140
Wire Wire Line
	7130 2140 7530 2140
Entry Wire Line
	7030 2140 7130 2240
Wire Wire Line
	7130 2240 7530 2240
Entry Wire Line
	7030 2240 7130 2340
Wire Wire Line
	7130 2340 7530 2340
Entry Wire Line
	7030 2340 7130 2440
Wire Wire Line
	7130 2440 7530 2440
Entry Wire Line
	7030 2440 7130 2540
Wire Wire Line
	7130 2540 7530 2540
Entry Wire Line
	7030 2540 7130 2640
Wire Wire Line
	7130 2640 7530 2640
Entry Wire Line
	7030 3940 7130 4040
Wire Wire Line
	7130 4040 7530 4040
Entry Wire Line
	7030 4040 7130 4140
Wire Wire Line
	7130 4140 7530 4140
Entry Wire Line
	7030 4140 7130 4240
Wire Wire Line
	7130 4240 7530 4240
Entry Wire Line
	7030 4240 7130 4340
Wire Wire Line
	7130 4340 7530 4340
Entry Wire Line
	7030 4340 7130 4440
Wire Wire Line
	7130 4440 7530 4440
Entry Wire Line
	7030 4440 7130 4540
Wire Wire Line
	7130 4540 7530 4540
Entry Wire Line
	7030 4540 7130 4640
Wire Wire Line
	7130 4640 7530 4640
Entry Wire Line
	7030 4640 7130 4740
Wire Wire Line
	7130 4740 7530 4740
Entry Wire Line
	7030 3140 7130 3240
Wire Wire Line
	7130 3240 7530 3240
Entry Wire Line
	7030 3240 7130 3340
Wire Wire Line
	7130 3340 7530 3340
Entry Wire Line
	7030 3340 7130 3440
Wire Wire Line
	7130 3440 7530 3440
Entry Wire Line
	7030 3440 7130 3540
Wire Wire Line
	7130 3540 7530 3540
Entry Wire Line
	7030 3540 7130 3640
Wire Wire Line
	7130 3640 7530 3640
Entry Wire Line
	7030 3640 7130 3740
Wire Wire Line
	7130 3740 7530 3740
Entry Wire Line
	7030 3740 7130 3840
Wire Wire Line
	7130 3840 7530 3840
Entry Wire Line
	7030 3840 7130 3940
Wire Wire Line
	7130 3940 7530 3940
Entry Wire Line
	7030 3040 7130 3140
Wire Wire Line
	7130 3140 7530 3140
$Comp
L power:GND #PWR0102
U 1 1 5F75F688
P 7530 1440
F 0 "#PWR0102" H 7530 1190 50  0001 C CNN
F 1 "GND" V 7530 1290 50  0000 R CNN
F 2 "" H 7530 1440 50  0001 C CNN
F 3 "" H 7530 1440 50  0001 C CNN
	1    7530 1440
	0    1    1    0   
$EndComp
$Comp
L power:VDD #PWR0103
U 1 1 5F7647D4
P 7530 5140
F 0 "#PWR0103" H 7530 4990 50  0001 C CNN
F 1 "VDD" V 7490 5240 50  0000 L CNN
F 2 "" H 7530 5140 50  0001 C CNN
F 3 "" H 7530 5140 50  0001 C CNN
	1    7530 5140
	0    -1   -1   0   
$EndComp
Text Notes 7770 1580 0    50   ~ 0
Card Detect: GND for RAM, NC for ROM
Text Notes 7760 5080 0    50   ~ 0
Battery Voltage Check - NC in WP-2
Text Notes 7760 5170 0    50   ~ 0
+5v
Text Notes 7190 1140 0    50   ~ 0
1x38 Male 1.27mm
$Comp
L 0_LOCAL:SST39SF020_TSOP U2
U 1 1 5F906116
P 5010 3300
F 0 "U2" H 5010 3300 50  0000 C CNN
F 1 "FLASH 256Kx8 5v Parallel" H 5010 4880 50  0000 C CNN
F 2 "0_LOCAL:TSOP32-14mm" H 4510 4450 50  0001 C CNN
F 3 "https://ww1.microchip.com/downloads/en/DeviceDoc/20005022C.pdf" H 5010 3300 50  0001 C CNN
	1    5010 3300
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
	4100 4300 4200 4400
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
Text Label 4410 4400 2    50   ~ 0
~OE
Text Label 4410 4300 2    50   ~ 0
~CE1
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
	4200 4400 4410 4400
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
$Comp
L power:GND #PWR0108
U 1 1 5FA08971
P 7530 2740
F 0 "#PWR0108" H 7530 2490 50  0001 C CNN
F 1 "GND" V 7530 2590 50  0000 R CNN
F 2 "" H 7530 2740 50  0001 C CNN
F 3 "" H 7530 2740 50  0001 C CNN
	1    7530 2740
	0    1    1    0   
$EndComp
Wire Bus Line
	7030 5200 5900 5200
Connection ~ 5900 5200
Connection ~ 4100 5200
Entry Wire Line
	4100 3700 4200 3800
Text Label 4410 3800 2    50   ~ 0
A17
Wire Wire Line
	4200 3800 4410 3800
Entry Wire Line
	7030 2940 7130 3040
Wire Wire Line
	7130 3040 7530 3040
Text Label 7530 3040 2    50   ~ 0
A17
Text Notes 7770 1480 0    50   ~ 0
GND
Text Notes 7770 2780 0    50   ~ 0
GND
$Comp
L power:VDD #PWR0110
U 1 1 5F83B4C3
P 5010 2000
F 0 "#PWR0110" H 5010 1850 50  0001 C CNN
F 1 "VDD" H 5010 2150 50  0000 L CNN
F 2 "" H 5010 2000 50  0001 C CNN
F 3 "" H 5010 2000 50  0001 C CNN
	1    5010 2000
	1    0    0    -1  
$EndComp
$Comp
L 0_LOCAL:R R1
U 1 1 5F8FDC45
P 3830 5500
F 0 "R1" V 3740 5500 50  0000 C CNN
F 1 "47K" V 3830 5500 50  0000 C CNN
F 2 "0_LOCAL:R_0805" V 3760 5500 50  0001 C CNN
F 3 "~" H 3830 5500 50  0001 C CNN
	1    3830 5500
	0    1    1    0   
$EndComp
Entry Wire Line
	2910 5400 3010 5500
Text Label 3010 5500 0    50   ~ 0
~WE
$Comp
L power:VDD #PWR0111
U 1 1 5F9099AB
P 3980 5500
F 0 "#PWR0111" H 3980 5350 50  0001 C CNN
F 1 "VDD" V 3980 5650 50  0000 L CNN
F 2 "" H 3980 5500 50  0001 C CNN
F 3 "" H 3980 5500 50  0001 C CNN
	1    3980 5500
	0    1    1    0   
$EndComp
Text Label 4410 4200 2    50   ~ 0
~WE
Wire Wire Line
	4200 4200 4410 4200
Entry Wire Line
	4100 4100 4200 4200
Text Notes 2960 1240 0    50   ~ 0
U1/U2: SST39SF020A AM29F020 GLS29EE020
$Comp
L 0_LOCAL:SST39SF020_TSOP U1
U 1 1 5FA8764D
P 2910 3300
F 0 "U1" H 2910 3300 50  0000 C CNN
F 1 "FLASH 256Kx8 5v Parallel" H 2910 4880 50  0000 C CNN
F 2 "0_LOCAL:TSOP32-20mm" H 2410 4450 50  0001 C CNN
F 3 "https://ww1.microchip.com/downloads/en/DeviceDoc/20005022C.pdf" H 2910 3300 50  0001 C CNN
	1    2910 3300
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
	2000 4300 2100 4400
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
Text Label 2310 4400 2    50   ~ 0
~OE
Text Label 2310 4300 2    50   ~ 0
~CE1
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
L power:GND #PWR0101
U 1 1 5FA878F5
P 2910 4500
F 0 "#PWR0101" H 2910 4250 50  0001 C CNN
F 1 "GND" H 2950 4290 50  0000 C CNN
F 2 "" H 2910 4500 50  0001 C CNN
F 3 "" H 2910 4500 50  0001 C CNN
	1    2910 4500
	1    0    0    -1  
$EndComp
Wire Wire Line
	2100 4300 2310 4300
Wire Wire Line
	2100 4400 2310 4400
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
Entry Wire Line
	2000 3700 2100 3800
Text Label 2310 3800 2    50   ~ 0
A17
Wire Wire Line
	2100 3800 2310 3800
$Comp
L power:VDD #PWR0104
U 1 1 5FA87915
P 2910 2000
F 0 "#PWR0104" H 2910 1850 50  0001 C CNN
F 1 "VDD" H 2910 2150 50  0000 L CNN
F 2 "" H 2910 2000 50  0001 C CNN
F 3 "" H 2910 2000 50  0001 C CNN
	1    2910 2000
	1    0    0    -1  
$EndComp
Text Label 2310 4200 2    50   ~ 0
~WE
Wire Wire Line
	2100 4200 2310 4200
Entry Wire Line
	2000 4100 2100 4200
Connection ~ 3800 5200
Wire Bus Line
	3800 5200 4100 5200
Text Notes 2410 1610 0    50   ~ 0
TSOP-I-32 8x20 footprint
Text Notes 4500 1610 0    50   ~ 0
sTSOP-I-32 8x14 footprint
Text Label 7530 4840 2    50   ~ 0
R~W
Text Notes 7770 1680 0    50   ~ 0
Hard trace to VDD.
Text Notes 7780 2870 0    50   ~ 0
IC5_66
Text Notes 7780 2970 0    50   ~ 0
IC5_67
Text Notes 7760 4970 0    50   ~ 0
IC5_68
Entry Wire Line
	7030 4740 7130 4840
$Comp
L 0_LOCAL:Jumper_NO_Small JP1
U 1 1 5F96166C
P 3360 5700
F 0 "JP1" H 3360 5760 50  0000 C CNN
F 1 "Write-Enable" H 3360 5640 50  0000 C CNN
F 2 "0_LOCAL:JP2_tight" H 3360 5700 50  0001 C CNN
F 3 "~" H 3360 5700 50  0001 C CNN
	1    3360 5700
	1    0    0    -1  
$EndComp
Entry Wire Line
	2910 5600 3010 5700
Text Label 3010 5700 0    50   ~ 0
R~W
Wire Wire Line
	3010 5700 3260 5700
Wire Bus Line
	2000 5200 2910 5200
Connection ~ 2910 5200
Wire Bus Line
	2910 5200 3800 5200
Wire Wire Line
	3010 5500 3630 5500
Wire Wire Line
	3460 5700 3630 5700
Wire Wire Line
	3630 5700 3630 5500
Connection ~ 3630 5500
Wire Wire Line
	3630 5500 3680 5500
Wire Wire Line
	7530 4840 7130 4840
NoConn ~ 7530 1540
NoConn ~ 7530 1640
NoConn ~ 7530 5040
NoConn ~ 2310 3900
NoConn ~ 4410 3900
Wire Bus Line
	4100 5200 5900 5200
Text Notes 7530 1640 2    50   ~ 0
CE2
Text Notes 7530 5040 2    50   ~ 0
BCHK
Text Notes 7530 4940 2    50   ~ 0
S3
Text Notes 7530 2940 2    50   ~ 0
S2
Text Notes 7530 2840 2    50   ~ 0
S1
Wire Bus Line
	2910 5200 2910 5600
Wire Bus Line
	3800 2000 3800 5200
Wire Bus Line
	5900 2000 5900 5200
Wire Bus Line
	2000 2000 2000 5200
Wire Bus Line
	4100 2000 4100 5200
Wire Bus Line
	7030 1640 7030 5200
$EndSCHEMATC
