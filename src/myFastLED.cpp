#include <Arduino.h>
#include <FastLED.h>
#include "myFastLED.h"

// initialize
extern "C" void mysetup(uint8_T DATA_PIN)
{
    uint8_T NUM_LEDS = 3;
    CRGB leds[3];
    FastLED.addLeds<NEOPIXEL, 5>(leds,3);
}

// write to LED strip
extern "C" void mywrite(boolean_T val)
{
    if (val)
    {
        CRGB leds[3];
        for (int k=0; k<3; k++)
        {
            leds[k] = CRGB::Blue;
        }
        FastLED.show();
    } else {
        CRGB leds[3];
        for (int k=0; k<3; k++)
        {
            leds[k] = CRGB::Black;
        }
        FastLED.show();
    }
}