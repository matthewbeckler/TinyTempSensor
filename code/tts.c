// Tiny Temp Sensor
//  Reads a thermistor value and displays colors on an RGB LED.
// Matthew Beckler
// For ATtiny13A

#include <inttypes.h>
#include <avr/io.h>

//#define F_CPU 9600000
#define F_CPU 10420000
#include <util/delay.h>

#define NOP() asm volatile ("nop")

/* ATtiny13A pinout:
               +---------------+
    ICSP Reset |  1 PB5 VCC  8 | VCC
               |  2 PB3 PB2  7 | Blue cathode (ICSP SCK)
 Green cathode |  3 PB4 PB1  6 | Red cathode (ICSP MISO)
           GND |  4 GND AIN0 5 | Thermmistor analog input (ICSP MOSI)
               +---------------+

    Using this mainline code to test clock speed:

    int main(void)
    {
        // set clock prescaler: 0 gives full 4.8 MHz from internal oscillator.
        CLKPR = _BV(CLKPCE);
        CLKPR = 0;

        DDRB = 0xff;

        while (1)
        {
            NOP();
            PORTB = 0x00;   // <-- Start
            NOP();
            PORTB = 0xFF;
            NOP();
            PORTB = 0x00;   // <-- End
            NOP();
            PORTB = 0xFF;
            NOP();
            NOP();
            NOP();
            NOP();
            NOP();
        }
    }

    Measure the two falling edges: I measured 384 ns, which is four cycles (two nops, two port outputs).
    1 / (384ns / 4) = 10.42 MHz
    What does this mean? I thought the clock speed was supposed to be 9.6 mhz? Maybe it's out of calibration? Does that matter?

    I measured the frequencies from the timer module, and I'm off by a bit--I think the clockspeed is closer to 9.6 mhz on *mine*. -aww, 03/01/2011
*/


int main(void)
{
    // set clock prescaler: 0 gives full, unprescaled clock
    CLKPR = _BV(CLKPCE);
    CLKPR = 0;

    DDRB = 0xFF; // all outputs...yes, 1 = output, 0 = input, CWAA, Atmel!
    PORTB = 0x00; // turn low everything on PORTB 

    while (1)
    {
        // read thermistor value

        // do PWM stuff
    }
}
