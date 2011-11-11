EESchema Schematic File Version 2  date Fri 11 Nov 2011 03:07:50 PM EST
LIBS:power
LIBS:device
LIBS:transistors
LIBS:conn
LIBS:linear
LIBS:regul
LIBS:74xx
LIBS:cmos4000
LIBS:adc-dac
LIBS:memory
LIBS:xilinx
LIBS:special
LIBS:microcontrollers
LIBS:dsp
LIBS:microchip
LIBS:analog_switches
LIBS:motorola
LIBS:texas
LIBS:intel
LIBS:audio
LIBS:interface
LIBS:digital-audio
LIBS:philips
LIBS:display
LIBS:cypress
LIBS:siliconi
LIBS:opto
LIBS:atmel
LIBS:contrib
LIBS:valves
LIBS:wayne_and_layne_kicad_symbols
LIBS:tiny_temp_sensor-cache
EELAYER 25  0
EELAYER END
$Descr A4 11700 8267
encoding utf-8
Sheet 1 1
Title ""
Date "11 nov 2011"
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
Connection ~ 1450 1950
Wire Wire Line
	1450 1900 1450 1950
Wire Wire Line
	4600 3650 4900 3650
Wire Wire Line
	5750 2950 5500 2950
Wire Wire Line
	3650 4450 3900 4450
Wire Wire Line
	3900 4450 3900 4350
Wire Wire Line
	3900 3650 3900 3850
Wire Wire Line
	1200 2650 1200 2750
Wire Wire Line
	1200 2750 2000 2750
Wire Wire Line
	2000 2750 2000 2450
Wire Wire Line
	2000 2450 2100 2450
Wire Wire Line
	1200 2050 1200 1950
Wire Wire Line
	1200 1950 2000 1950
Wire Wire Line
	2000 1950 2000 2250
Wire Wire Line
	2000 2250 2100 2250
Wire Wire Line
	6300 2150 6650 2150
Wire Wire Line
	6300 2250 6650 2250
Wire Wire Line
	6300 2050 6650 2050
Wire Wire Line
	6300 1950 6650 1950
Wire Wire Line
	6300 1750 6650 1750
Wire Wire Line
	6300 1850 6650 1850
Connection ~ 3900 3750
Wire Wire Line
	3900 3150 3900 3050
Wire Wire Line
	3900 3050 3650 3050
Wire Wire Line
	4600 1450 5050 1450
Wire Wire Line
	4600 1650 5050 1650
Wire Wire Line
	4600 2050 5050 2050
Wire Wire Line
	4600 1850 5050 1850
Wire Wire Line
	4600 2250 5050 2250
Wire Wire Line
	4600 2450 5050 2450
Wire Wire Line
	6250 3500 6800 3500
Wire Wire Line
	6250 3650 6800 3650
Wire Wire Line
	6250 3800 6800 3800
Wire Wire Line
	3600 3750 3900 3750
Wire Wire Line
	5400 3650 5550 3650
$Comp
L PWR_FLAG #FLG01
U 1 1 4EBD7DD5
P 1450 1900
F 0 "#FLG01" H 1450 1995 30  0001 C CNN
F 1 "PWR_FLAG" H 1450 2080 30  0000 C CNN
	1    1450 1900
	1    0    0    -1  
$EndComp
$Comp
L R J1
U 1 1 4EBD7D84
P 5150 3650
F 0 "J1" V 5230 3650 50  0000 C CNN
F 1 "0" V 5150 3650 50  0000 C CNN
	1    5150 3650
	0    1    1    0   
$EndComp
Text Label 5000 1850 0    60   ~ 0
GREEN
Text Label 5000 1650 0    60   ~ 0
BLUE
Text Label 5000 2250 0    60   ~ 0
RED
Text Label 4650 2050 0    60   ~ 0
THERM
Text Notes 3000 3700 0    60   ~ 0
Thermistor\nConnection
Text Notes 7200 1950 0    60   ~ 0
ICSP\nprogramming\nheader
Text Notes 5450 2800 0    60   ~ 0
Mounting hole
Text Label 5500 2950 0    60   ~ 0
GND
$Comp
L CONN_1 P2
U 1 1 4E5FD344
P 5900 2950
F 0 "P2" H 5980 2950 40  0000 L CNN
F 1 "CONN_1" H 5900 3005 30  0001 C CNN
	1    5900 2950
	1    0    0    -1  
$EndComp
Text Label 3600 3750 0    60   ~ 0
THERM
Text Label 6400 3800 0    60   ~ 0
BLUE
Text Label 4650 2250 0    60   ~ 0
PB3
Text Label 6400 3650 0    60   ~ 0
GREEN
Text Label 6400 3500 0    60   ~ 0
RED
Text Label 4600 3650 0    60   ~ 0
VCC
$Comp
L RGB_LED_CA D1
U 1 1 4E5FC57D
P 5900 3650
F 0 "D1" H 5900 3350 60  0000 C CNN
F 1 "RGB_LED_CA" H 5900 3950 60  0000 C CNN
	1    5900 3650
	1    0    0    -1  
$EndComp
Text Label 4650 2450 0    60   ~ 0
RESET
Text Label 4650 1850 0    60   ~ 0
SCK
Text Label 4650 1650 0    60   ~ 0
MISO
Text Label 4650 1450 0    60   ~ 0
MOSI
Text Label 3650 3050 0    60   ~ 0
VCC
Text Label 3650 4450 0    60   ~ 0
GND
$Comp
L R R1
U 1 1 4E5FC514
P 3900 3400
F 0 "R1" V 3980 3400 50  0000 C CNN
F 1 "THERM" V 3900 3400 50  0000 C CNN
	1    3900 3400
	1    0    0    -1  
$EndComp
$Comp
L R R2
U 1 1 4E5FC4E7
P 3900 4100
F 0 "R2" V 3980 4100 50  0000 C CNN
F 1 "10K" V 3900 4100 50  0000 C CNN
	1    3900 4100
	1    0    0    -1  
$EndComp
Text Label 6300 2250 0    60   ~ 0
MOSI
Text Label 6300 2150 0    60   ~ 0
RESET
Text Label 6300 2050 0    60   ~ 0
SCK
Text Label 6300 1950 0    60   ~ 0
MISO
Text Label 6300 1850 0    60   ~ 0
VCC
Text Label 6300 1750 0    60   ~ 0
GND
$Comp
L CONN_6 P1
U 1 1 4E5FC3FD
P 7000 2000
F 0 "P1" V 6950 2000 60  0000 C CNN
F 1 "ICSP" V 7050 2000 60  0000 C CNN
	1    7000 2000
	1    0    0    -1  
$EndComp
Text Label 1750 1950 0    60   ~ 0
VCC
Text Label 1750 2750 0    60   ~ 0
GND
$Comp
L BATTERY BT1
U 1 1 4E5FC3CB
P 1200 2350
F 0 "BT1" H 1200 2550 50  0000 C CNN
F 1 "BATTERY" H 1200 2160 50  0000 C CNN
	1    1200 2350
	0    1    1    0   
$EndComp
$Comp
L ATTINY13DIP-SO U1
U 1 1 4E5FC3C3
P 3350 1950
F 0 "U1" H 3350 1250 60  0000 C CNN
F 1 "ATTINY13A" H 3350 2700 60  0000 C CNN
	1    3350 1950
	1    0    0    -1  
$EndComp
$EndSCHEMATC
