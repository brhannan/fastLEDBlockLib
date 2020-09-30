#include <Arduino.h>
#include <FastLED.h>
#include "myFastLED.h"

#define MAX_LEDS 255
#define DATA_PIN 6

CRGB leds[MAX_LEDS];
int totLEDs[MAX_LEDS*3];
int g_NUM_LEDS = 3;

// initialize
extern "C" void fastLEDInit(int NUM_LEDS)
{
    g_NUM_LEDS = NUM_LEDS;
    FastLED.addLeds<NEOPIXEL,DATA_PIN>(leds,g_NUM_LEDS);
    for (int k = 0; k < MAX_LEDS; k++)
    {
        leds[k] = CRGB::Black;
    }
    FastLED.show();
    delay(10); // delay in ms
}

// write to LED strip
extern "C" void fastLEDCommand(uint8_T *colorArray, int *totLEDs)
{
    for (int n = 0; n < 3*g_NUM_LEDS; n++)
    {
        totLEDs[n] = colorArray[n];
    }
    for (int k=0; k<g_NUM_LEDS; k++)
    {
        leds[k].setRGB(totLEDs[3*k], totLEDs[3*k+1], totLEDs[3*k+2]);
    }
    FastLED.show();
    delay(10); // delay in ms
}
