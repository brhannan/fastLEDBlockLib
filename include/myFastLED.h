#ifndef _MY_FASTLED_H_
#define _MY_FASTLED_H_
#include "rtwtypes.h"

#ifdef __cplusplus
extern "C" {
#endif

void fastLEDInit(int NUM_LEDS);
void fastLEDCommand(uint8_T *colorArray, int nled, int *totLEDs);

#ifdef __cplusplus
}
#endif
#endif // _MY_FASTLED_H_
