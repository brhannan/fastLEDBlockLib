#include <Arduino.h>
#include <FastLED.h>
#include "myFastLED2.h"

// initialize
extern "C" void mysetup(uint8_T DATA_PIN, uint8_T NUM_LEDS)
{
    CRGB leds[NUM_LEDS];
    FastLED.addLeds<NEOPIXEL,DATA_PIN>(leds,NUM_LEDS);
}

// write to LED strip
extern "C" void mywrite(boolean_T val, uint8_T NUM_LEDS)
{
    if (val)
    {
        CRGB leds[NUM_LEDS];
        for (int k=0; k<NUM_LEDS; k++)
        {
            leds[k] = CRGB::Blue;
        }
        FastLED.show();
    } else {
        CRGB leds[NUM_LEDS];
        for (int k=0; k<NUM_LEDS; k++)
        {
            leds[k] = CRGB::Black;
        }
        FastLED.show();
    }
}