// Tiny Temp Sensor
//  Reads a thermistor value and displays colors on an RGB LED.
// Matthew Beckler
// For ATtiny13A

#include <inttypes.h>
#include <avr/io.h>
#include <avr/interrupt.h>

//#define F_CPU 9600000
#define F_CPU 10420000
#include <util/delay.h>

#define NOP() asm volatile ("nop")

/* ATtiny13A pinout:
               +---------------+
    ICSP Reset |  1 PB5 VCC  8 | VCC
            NC |  2 PB3 PB2  7 | Blue cathode (ICSP SCK)
 Green cathode |  3 PB4 PB1  6 | Red cathode (ICSP MISO)
           GND |  4 GND AIN0 5 | Thermistor analog input (ICSP MOSI)
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

volatile unsigned char red, green, blue;

//                                  viol  indi  blue  grn   yel   ora   red   redder
const unsigned char map_red[8]   = {0xEE, 0x4B, 0x00, 0x00, 0xFF, 0xFF, 0x77, 0xFF};
const unsigned char map_green[8] = {0x82, 0x00, 0x00, 0xFF, 0xFF, 0x7F, 0x00, 0x00};
const unsigned char map_blue[8]  = {0xEE, 0x82, 0xFF, 0x00, 0x00, 0x00, 0x00, 0x00};

// Vector 10, program address 0x0009, called "ADC", when ADC conversion is complete
ISR(ADC_vect) // whenever the analog sampling has finished
{
    // use the value in ADCH (ignore the lower two bits in ADCL[7:6]) to update red, blue, green
    // maybe just use the upper three bits or something with a lookup table?
    //unsigned char index = (ADCH >> 5);

    // new plan, since we can't use the whole range of 0-Vdd with the thermistor for realistic room temperatures
    // we're going to use a simple little lookup table thing here.
    // Centering it around room temp with eight colors ranging from 32F - 95F
    // TODO test this out, and also measure the room-temp resistance of the thermistor!
#define ADC_VIOLET  60
#define ADC_INDIGO  72
#define ADC_BLUE    85
#define ADC_GREEN   99
#define ADC_YELLOW  113
#define ADC_ORANGE  128
#define ADC_RED     141
#define ADC_REDDER  154
    unsigned char index;
    if (ADCH < ADC_VIOLET)
        index = 0;
    else if (ADCH < ADC_INDIGO)
        index = 1;
    else if (ADCH < ADC_BLUE)
        index = 2;
    else if (ADCH < ADC_GREEN)
        index = 3;
    else if (ADCH < ADC_YELLOW)
        index = 4;
    else if (ADCH < ADC_ORANGE)
        index = 5;
    else if (ADCH < ADC_RED)
        index = 6;
    else
        index = 7;

    red   = map_red[index];
    green = map_green[index];
    blue  = map_blue[index];
}

//ISR(TIM0_OVF_vect){}

int main(void)
{
    unsigned char i;

#define RB_RED      1
#define RB_GREEN    2
#define RB_BLUE     4
// common + RGB led needs active low = on
//                              high = off
#define RB_ALL_OFF  0x16
#define RB_ALL_ON   255 - RB_ALL_OFF

    // set clock prescaler: 0 gives full, unprescaled clock
    //CLKPR = _BV(CLKPCE);
    //CLKPR = 0;

    DDRB = 0xF7; // all outputs except RB3 which is the thermistor analog input...yes, 1 = output, 0 = input, CWAA, Atmel!
    PORTB = RB_ALL_OFF; // turn high the pins for the led cathodes (common anode means high = off)
    PORTB = 0x00;
    MCUCR = _BV(PUD); // disable internal pullups

    // set up the timer to overflow every once in a while
    TCCR0B = _BV(CS02) | _BV(CS00); // clk_IO / 1024 prescaler
    TIMSK0 = _BV(TOIE0);

    // set up the ADC for reading ADC3, auto triggered
    ADMUX = _BV(ADLAR) | _BV(MUX1) | _BV(MUX0);
    ADCSRA = _BV(ADEN) | _BV(ADATE) | _BV(ADIE); // TODO what should the prescaler be? ADPS[2:0] (datasheet page 94)
    ADCSRB = _BV(ADTS2); // set the auto trigger source to Timer/Counter Overflow (100)
    DIDR0 = 0xFF; // "when a digital signal is not needed, this bit should be written logic one to reduce power consumption"

    red = 1;
    blue = 1;
    green = 250;

    sei();

    while (1)
    {
        //PORTB = ~PORTB;
        // do PWM on the three channels
        PORTB = 0xFF;
        for (i = 255; i != 0; i--)
        {
            if (i == red)   PORTB &= ~(_BV(RB_RED));
            if (i == green) PORTB &= ~(_BV(RB_GREEN));
            if (i == blue)  PORTB &= ~(_BV(RB_BLUE));
        }
    }
}
