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
P 7700 4040
F 0 "J1" H 7630 6100 50  0000 L CNN
F 1 "Conn_01x38_Male" H 7310 6000 50  0000 L CNN
F 2 "0_LOCAL:Pin_Header_Straight_1x38_Pitch1.27mm" H 7700 4040 50  0001 C CNN
F 3 "~" H 7700 4040 50  0001 C CNN
	1    7700 4040
	-1   0    0    -1  
$EndComp
Text Label 7500 2340 2    50   ~ 0
~DET
Text Label 7500 2540 2    50   ~ 0
~CE1
Text Label 7500 2640 2    50   ~ 0
~OE
Text Label 7500 2740 2    50   ~ 0
D0
Text Label 7500 2840 2    50   ~ 0
D1
Text Label 7500 2940 2    50   ~ 0
D2
Text Label 7500 3040 2    50   ~ 0
D3
Text Label 7500 3140 2    50   ~ 0
D4
Text Label 7500 3240 2    50   ~ 0
D5
Text Label 7500 3340 2    50   ~ 0
D6
Text Label 7500 3440 2    50   ~ 0
D7
NoConn ~ 7500 3640
NoConn ~ 7500 3740
Text Label 7500 3940 2    50   ~ 0
A16
Text Label 7500 4040 2    50   ~ 0
A15
Text Label 7500 4140 2    50   ~ 0
A14
Text Label 7500 4240 2    50   ~ 0
A13
Text Label 7500 4340 2    50   ~ 0
A12
Text Label 7500 4440 2    50   ~ 0
A11
Text Label 7500 4540 2    50   ~ 0
A10
Text Label 7500 4640 2    50   ~ 0
A9
Text Label 7500 4740 2    50   ~ 0
A8
Text Label 7500 4840 2    50   ~ 0
A7
Text Label 7500 4940 2    50   ~ 0
A6
Text Label 7500 5040 2    50   ~ 0
A5
Text Label 7500 5140 2    50   ~ 0
A4
Text Label 7500 5240 2    50   ~ 0
A3
Text Label 7500 5340 2    50   ~ 0
A2
Text Label 7500 5440 2    50   ~ 0
A1
Text Label 7500 5540 2    50   ~ 0
A0
NoConn ~ 7500 5740
Text Label 7500 5840 2    50   ~ 0
BCHK
Wire Wire Line
	7100 2540 7500 2540
Entry Wire Line
	7000 2540 7100 2640
Wire Wire Line
	7100 2640 7500 2640
Entry Wire Line
	7000 2640 7100 2740
Wire Wire Line
	7100 2740 7500 2740
Entry Wire Line
	7000 2740 7100 2840
Wire Wire Line
	7100 2840 7500 2840
Entry Wire Line
	7000 2840 7100 2940
Wire Wire Line
	7100 2940 7500 2940
Entry Wire Line
	7000 2940 7100 3040
Wire Wire Line
	7100 3040 7500 3040
Entry Wire Line
	7000 3040 7100 3140
Wire Wire Line
	7100 3140 7500 3140
Entry Wire Line
	7000 3140 7100 3240
Wire Wire Line
	7100 3240 7500 3240
Entry Wire Line
	7000 3240 7100 3340
Wire Wire Line
	7100 3340 7500 3340
Entry Wire Line
	7000 3340 7100 3440
Wire Wire Line
	7100 3440 7500 3440
Entry Wire Line
	7000 4740 7100 4840
Wire Wire Line
	7100 4840 7500 4840
Entry Wire Line
	7000 4840 7100 4940
Wire Wire Line
	7100 4940 7500 4940
Entry Wire Line
	7000 4940 7100 5040
Wire Wire Line
	7100 5040 7500 5040
Entry Wire Line
	7000 5040 7100 5140
Wire Wire Line
	7100 5140 7500 5140
Entry Wire Line
	7000 5140 7100 5240
Wire Wire Line
	7100 5240 7500 5240
Entry Wire Line
	7000 5240 7100 5340
Wire Wire Line
	7100 5340 7500 5340
Entry Wire Line
	7000 5340 7100 5440
Wire Wire Line
	7100 5440 7500 5440
Entry Wire Line
	7000 5440 7100 5540
Wire Wire Line
	7100 5540 7500 5540
Entry Wire Line
	7000 3940 7100 4040
Wire Wire Line
	7100 4040 7500 4040
Entry Wire Line
	7000 4040 7100 4140
Wire Wire Line
	7100 4140 7500 4140
Entry Wire Line
	7000 4140 7100 4240
Wire Wire Line
	7100 4240 7500 4240
Entry Wire Line
	7000 4240 7100 4340
Wire Wire Line
	7100 4340 7500 4340
Entry Wire Line
	7000 4340 7100 4440
Wire Wire Line
	7100 4440 7500 4440
Entry Wire Line
	7000 4440 7100 4540
Wire Wire Line
	7100 4540 7500 4540
Entry Wire Line
	7000 4540 7100 4640
Wire Wire Line
	7100 4640 7500 4640
Entry Wire Line
	7000 4640 7100 4740
Wire Wire Line
	7100 4740 7500 4740
Entry Wire Line
	7000 3840 7100 3940
Wire Wire Line
	7100 3940 7500 3940
Text Notes 7740 2380 0    50   ~ 0
Card Detect
Text Notes 7730 5880 0    50   ~ 0
Battery Check
Text Notes 7730 5970 0    50   ~ 0
+5v
Text Notes 7180 1920 0    50   ~ 0
1x38 Male 1.27mm
Entry Wire Line
	4370 4000 4470 4100
Entry Wire Line
	4370 4100 4470 4200
Entry Wire Line
	4370 4200 4470 4300
Entry Wire Line
	4370 4300 4470 4400
Entry Wire Line
	4370 4400 4470 4500
Entry Wire Line
	4370 4500 4470 4600
Entry Wire Line
	4370 3800 4470 3900
Entry Wire Line
	4370 3200 4470 3300
Entry Wire Line
	4370 3300 4470 3400
Entry Wire Line
	4370 3400 4470 3500
Entry Wire Line
	4370 3500 4470 3600
Entry Wire Line
	4370 3600 4470 3700
Entry Wire Line
	4370 3700 4470 3800
Entry Wire Line
	4370 3900 4470 4000
Entry Wire Line
	5370 3900 5470 3800
Wire Wire Line
	5180 3900 5370 3900
Entry Wire Line
	5370 3300 5470 3200
Wire Wire Line
	5180 3300 5370 3300
Entry Wire Line
	5370 3500 5470 3400
Wire Wire Line
	5180 3500 5370 3500
Entry Wire Line
	5370 3600 5470 3500
Wire Wire Line
	5180 3600 5370 3600
Entry Wire Line
	5370 3700 5470 3600
Wire Wire Line
	5180 3700 5370 3700
Entry Wire Line
	5370 3800 5470 3700
Wire Wire Line
	5180 3800 5370 3800
Text Label 5180 4000 0    50   ~ 0
~OE
Text Label 5180 4200 0    50   ~ 0
~CE1
Text Label 4680 3300 2    50   ~ 0
A16
Text Label 4680 3400 2    50   ~ 0
A14
Text Label 5180 3500 0    50   ~ 0
R~W
Text Label 5180 3600 0    50   ~ 0
A13
Text Label 4680 3500 2    50   ~ 0
A12
Text Label 5180 3900 0    50   ~ 0
A11
Text Label 5180 4100 0    50   ~ 0
A10
Text Label 5180 3800 0    50   ~ 0
A9
Text Label 5180 3700 0    50   ~ 0
A8
Text Label 4680 3600 2    50   ~ 0
A7
Text Label 4680 3700 2    50   ~ 0
A6
Text Label 4680 3800 2    50   ~ 0
A5
Text Label 4680 3900 2    50   ~ 0
A4
Text Label 4680 4100 2    50   ~ 0
A2
Text Label 4680 4200 2    50   ~ 0
A1
Text Label 4680 4300 2    50   ~ 0
A0
Text Label 4680 4400 2    50   ~ 0
D0
Text Label 4680 4500 2    50   ~ 0
D1
Text Label 4680 4600 2    50   ~ 0
D2
Text Label 5180 4700 0    50   ~ 0
D3
Text Label 5180 4600 0    50   ~ 0
D4
Text Label 5180 4500 0    50   ~ 0
D5
Text Label 5180 4400 0    50   ~ 0
D6
Text Label 5180 4300 0    50   ~ 0
D7
Wire Wire Line
	4470 4600 4680 4600
Wire Wire Line
	4470 4500 4680 4500
Wire Wire Line
	4470 4400 4680 4400
Wire Wire Line
	4470 4300 4680 4300
Wire Wire Line
	4470 4200 4680 4200
Wire Wire Line
	4470 4100 4680 4100
Wire Wire Line
	4470 4000 4680 4000
Wire Wire Line
	4470 3800 4680 3800
Wire Wire Line
	4470 3700 4680 3700
Wire Wire Line
	4470 3600 4680 3600
Wire Wire Line
	4470 3500 4680 3500
Wire Wire Line
	4470 3400 4680 3400
Wire Wire Line
	4470 3300 4680 3300
$Comp
L power:GND #PWR0108
U 1 1 5FA08971
P 7500 3540
F 0 "#PWR0108" H 7500 3290 50  0001 C CNN
F 1 "GND" V 7500 3390 50  0000 R CNN
F 2 "" H 7500 3540 50  0001 C CNN
F 3 "" H 7500 3540 50  0001 C CNN
	1    7500 3540
	0    1    1    0   
$EndComp
Entry Wire Line
	7000 3740 7100 3840
Wire Wire Line
	7100 3840 7500 3840
Text Label 7500 3840 2    50   ~ 0
A17
Text Notes 7740 2280 0    50   ~ 0
GND
Text Notes 7740 3580 0    50   ~ 0
GND
Text Label 5180 3300 0    50   ~ 0
A15
Text Label 7500 5640 2    50   ~ 0
R~W
Entry Wire Line
	7000 5540 7100 5640
Wire Wire Line
	7100 5640 7500 5640
$Comp
L 0_LOCAL:Conn_02x16_Counter_Clockwise J2
U 1 1 5F97A8B8
P 4880 3900
F 0 "J2" H 4950 4850 50  0000 C CNN
F 1 "Conn_02x16_Counter_Clockwise" H 4950 4750 50  0000 C CNN
F 2 "0_LOCAL:2x16x600" H 4880 3900 50  0001 C CNN
F 3 "~" H 4880 3900 50  0001 C CNN
	1    4880 3900
	1    0    0    -1  
$EndComp
Text Label 5180 3200 0    50   ~ 0
VDD
Entry Wire Line
	5370 4000 5470 3900
Wire Wire Line
	5180 4000 5370 4000
Entry Wire Line
	5370 4100 5470 4000
Wire Wire Line
	5180 4100 5370 4100
Entry Wire Line
	5370 4200 5470 4100
Wire Wire Line
	5180 4200 5370 4200
Entry Wire Line
	5370 4300 5470 4200
Wire Wire Line
	5180 4300 5370 4300
Entry Wire Line
	5370 4400 5470 4300
Wire Wire Line
	5180 4400 5370 4400
Entry Wire Line
	5370 4500 5470 4400
Wire Wire Line
	5180 4500 5370 4500
Entry Wire Line
	5370 4600 5470 4500
Wire Wire Line
	5180 4600 5370 4600
Entry Wire Line
	5370 4700 5470 4600
Wire Wire Line
	5180 4700 5370 4700
Wire Wire Line
	4470 3900 4680 3900
Wire Bus Line
	4370 6000 5470 6000
Connection ~ 5470 6000
Wire Bus Line
	5470 6000 7000 6000
Wire Wire Line
	7500 5940 7100 5940
Entry Wire Line
	7000 5840 7100 5940
Text Label 7500 5940 2    50   ~ 0
VDD
$Comp
L power:GND #PWR0101
U 1 1 5FAB7ED9
P 4680 4700
F 0 "#PWR0101" H 4680 4450 50  0001 C CNN
F 1 "GND" V 4680 4570 50  0000 R CNN
F 2 "" H 4680 4700 50  0001 C CNN
F 3 "" H 4680 4700 50  0001 C CNN
	1    4680 4700
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR0102
U 1 1 5FAC2431
P 7500 2240
F 0 "#PWR0102" H 7500 1990 50  0001 C CNN
F 1 "GND" V 7500 2090 50  0000 R CNN
F 2 "" H 7500 2240 50  0001 C CNN
F 3 "" H 7500 2240 50  0001 C CNN
	1    7500 2240
	0    1    1    0   
$EndComp
Text Notes 7740 2480 0    50   ~ 0
CE2: The card shorts CE2 to VMEM, so do not connect.
NoConn ~ 4680 3200
Entry Wire Line
	5370 3200 5470 3100
Wire Wire Line
	5180 3200 5370 3200
Text Label 4680 4000 2    50   ~ 0
A3
Text Notes 4080 2730 0    50   ~ 0
CY62128E / IS62C1024 / AS6C1008\n\nTSOP to DIL pin headers for programmer ZIF socket\n\nSame pinout as the DIP/SOIC version of the IC.
NoConn ~ 7500 2340
NoConn ~ 7500 5840
Entry Wire Line
	7000 2440 7100 2540
NoConn ~ 7500 2440
NoConn ~ 5180 3400
Wire Bus Line
	4370 3100 4370 6000
Wire Bus Line
	5470 3100 5470 6000
Wire Bus Line
	7000 2140 7000 6000
$EndSCHEMATC
