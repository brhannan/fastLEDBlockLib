#ifndef _MY_FASTLED_H_
#define _MY_FASTLED_H_
#include "rtwtypes.h"

#ifdef __cplusplus
extern "C" {
#endif
    
void mysetup(uint8_T DATA_PIN, uint8_T NUM_LEDS);
void mywrite(boolean_T val, uint8_T NUM_LEDS);

#ifdef __cplusplus
}
#endif
#endif // _MY_FASTLED_H_