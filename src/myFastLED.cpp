#include <Arduino.h>
#include <FastLED.h>
#include "myFastLED.h"

#define MAX_LEDS 255

CRGB leds[MAX_LEDS];
int totLEDs[MAX_LEDS*3];
int T_NUM_LEDS = 3;

// initialize
extern "C" void fastLEDInit(int numLEDs, int controlPin)
{
    T_NUM_LEDS = numLEDs;

    switch (controlPin) {
        case 2:
            FastLED.addLeds<NEOPIXEL,2>(leds,T_NUM_LEDS);
        case 3:
            FastLED.addLeds<NEOPIXEL,3>(leds,T_NUM_LEDS);
        case 4:
            FastLED.addLeds<NEOPIXEL,4>(leds,T_NUM_LEDS);
        case 5:
            FastLED.addLeds<NEOPIXEL,5>(leds,T_NUM_LEDS);
        case 6:
            FastLED.addLeds<NEOPIXEL,6>(leds,T_NUM_LEDS);
        case 7:
            FastLED.addLeds<NEOPIXEL,7>(leds,T_NUM_LEDS);
        case 8:
            FastLED.addLeds<NEOPIXEL,8>(leds,T_NUM_LEDS);
        case 9:
            FastLED.addLeds<NEOPIXEL,9>(leds,T_NUM_LEDS);
        case 10:
            FastLED.addLeds<NEOPIXEL,10>(leds,T_NUM_LEDS);
        case 11:
            FastLED.addLeds<NEOPIXEL,11>(leds,T_NUM_LEDS);
        case 12:
            FastLED.addLeds<NEOPIXEL,12>(leds,T_NUM_LEDS);
        case 13:
            FastLED.addLeds<NEOPIXEL,13>(leds,T_NUM_LEDS);
        default :
            FastLED.addLeds<NEOPIXEL,6>(leds,T_NUM_LEDS);
    }

    for (int k = 0; k < MAX_LEDS; k++)
    {
        leds[k] = CRGB::Black;
    }
    FastLED.show();
    delay(10); // delay in ms
}

// write to LED strip
extern "C" void fastLEDCommand(uint8_T *colorArray, int nled, int *totLEDs)
{
    for (int n = 0; n < 3*nled; n++)
    {
        totLEDs[n] = colorArray[n];
    }
    for (int k=0; k<T_NUM_LEDS; k++)
    {
        leds[k].setRGB(totLEDs[3*k], totLEDs[3*k+1], totLEDs[3*k+2]);
    }
    FastLED.show();
    delay(10); // delay in ms
}
