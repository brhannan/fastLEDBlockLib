#ifndef _MY_FASTLED_H_
#define _MY_FASTLED_H_
#include "rtwtypes.h"

#ifdef __cplusplus
extern "C" {
#endif

void fastLEDInit(int NUM_LEDS, int controlPin);
void fastLEDCommand(uint8_T *colors, int nled, int b);

#ifdef __cplusplus
}
#endif
#endif // _MY_FASTLED_H_
