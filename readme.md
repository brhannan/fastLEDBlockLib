# fastLEDBlockLib

A Simulink library containing driver blocks that can be used to control a WS2812 RGB LED strip with an Arduino Uno.

With the FastLED block library, you can use Simulink to create an algorithm that controls a WS2812 RGB LED strip through an Arduino. These blocks support code generation, so you can deploy your application to the Arduino.

## Dependencies

FastLED

MATLAB/Simulink

Simulink Support Package for Arduino Hardware

## Getting Started

Get the [FastLED library.](https://github.com/FastLED)

Copy contents of FastLED-master to FastLEDDriver/FastLED.

Open testFastLEDWrite.slx.

Connect an Arduino Uno to your machine.

Connect a WS2812B LED strip to the Arduino. Connect the control line to pin 6.

Press ctrl+b to deploy to the Arduino.
