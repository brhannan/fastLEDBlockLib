#include <Arduino.h>
#include <FastLED.h>
#include "myFastLED.h"

#define MAX_LEDS 255

CRGB leds[MAX_LEDS];

// initialize
extern "C" void fastLEDInit(int numLEDs, int controlPin)
{
    // switch block is used b/c addLeds 2nd template arg must be const
    switch (controlPin) {
        case 2:
            FastLED.addLeds<NEOPIXEL,2>(leds,numLEDs);
        case 3:
            FastLED.addLeds<NEOPIXEL,3>(leds,numLEDs);
        case 4:
            FastLED.addLeds<NEOPIXEL,4>(leds,numLEDs);
        case 5:
            FastLED.addLeds<NEOPIXEL,5>(leds,numLEDs);
        case 6:
            FastLED.addLeds<NEOPIXEL,6>(leds,numLEDs);
        case 7:
            FastLED.addLeds<NEOPIXEL,7>(leds,numLEDs);
        case 8:
            FastLED.addLeds<NEOPIXEL,8>(leds,numLEDs);
        case 9:
            FastLED.addLeds<NEOPIXEL,9>(leds,numLEDs);
        case 10:
            FastLED.addLeds<NEOPIXEL,10>(leds,numLEDs);
        case 11:
            FastLED.addLeds<NEOPIXEL,11>(leds,numLEDs);
        case 12:
            FastLED.addLeds<NEOPIXEL,12>(leds,numLEDs);
        case 13:
            FastLED.addLeds<NEOPIXEL,13>(leds,numLEDs);
        default :
            FastLED.addLeds<NEOPIXEL,6>(leds,numLEDs);
    }
}

// write to LED strip
extern "C" void fastLEDCommand(uint8_T *colors, int nled)
{
    for (int k=0; k<nled; k++)
    {
        leds[k].setRGB(colors[3*k], colors[3*k+1], colors[3*k+2]);
    }
    FastLED.show();
    delay(10); // delay in ms
}
