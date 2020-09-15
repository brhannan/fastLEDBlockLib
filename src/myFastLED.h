#ifndef _MY_FASTLED_H_
#define _MY_FASTLED_H_
#include "rtwtypes.h"

#ifdef __cplusplus
extern "C" {
#endif
    
void mysetup(uint8_T DATA_PIN);
void mywrite(boolean_T val);

#ifdef __cplusplus
}
#endif
#endif // _MY_FASTLED_H_